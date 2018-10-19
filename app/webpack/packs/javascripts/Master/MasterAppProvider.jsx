import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import { withRouter } from 'react-router';
import { message } from 'antd';

const MasterAppContext = React.createContext();

class MasterAppProvider extends Component {
  constructor(props) {
    super(props);
    const {
      authToken, name, orgName, isAdmin,
    } = props;
    this.state = {
      nextPath: null,
      authToken,
      orgName,
      isAdmin,
      name,
      loggingIn: false,
      loggingOut: false,
    };
  }

  updateNextPathName = (path) => {
    this.setState({ nextPath: path });
  }

  handleLogin = (email, authCode) => {
    const { history } = this.props;
    const { nextPath } = this.state;
    this.setState({ loggingIn: true });
    axios.post('/api/v1/auth/login', {
      email,
      auth_code: authCode,
    })
      .then((response) => {
        message.success('Logged in!');
        const { authToken, name } = response.data;
        this.setState({ authToken, name });
        if (nextPath) {
          history.push(nextPath);
        } else {
          history.push('/select-interview');
        }
        this.setState({ loggingIn: false, nextPath: null });
      })
      .catch((error) => {
        message.error(error.response.data.error);
        this.setState({ loggingIn: false });
      });
  }

  handleLogout = () => {
    this.setState({ loggingOut: true });
    const { history } = this.props;
    axios.delete('/api/v1/auth/logout')
      .then(() => {
        message.success('Logged out!');
        this.setState({
          authToken: null, name: null, loggingOut: false, nextPath: null,
        });
        history.push('/');
      })
      .catch(() => {
        message.error('An error occurred when logging out.');
        this.setState({ loggingOut: false });
      });
  }

  render() {
    const { children } = this.props;
    return (
      <MasterAppContext.Provider
        value={ {
          updateNextPathName: this.updateNextPathName,
          handleLogin: this.handleLogin,
          handleLogout: this.handleLogout,
          ...this.state,
        } }
      >
        { children }
      </MasterAppContext.Provider>
    );
  }
}

MasterAppProvider.propTypes = {
  children: PropTypes.object,
  history: PropTypes.object,
  authToken: PropTypes.object,
  name: PropTypes.string,
  orgName: PropTypes.string,
  isAdmin: PropTypes.bool,
};

export default withRouter(MasterAppProvider);

export const MasterAppConsumer = MasterAppContext.Consumer;
