import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import { withRouter } from 'react-router';
import { message } from 'antd';

const MasterAppContext = React.createContext();

class MasterAppProvider extends Component {
  state = {
    nextPath: null,
    authToken: null,
    loggingIn: false,
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    const {
      authToken, name,
    } = nextProps;

    if (prevState.authToken !== nextProps.authToken) {
      return {
        authToken,
        name,
      };
    }
    // Return null to indicate no change to state.
    return null;
  }

  updateNextPathName = (path) => {
    this.setState({ nextPath: path });
  }

  updateLoginCredentials = (credentails) => {
    this.setState({ authToken: credentails.authToken, name: credentails.name });
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
        this.updateLoginCredentials(response);
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

  render() {
    const { children } = this.props;
    return (
      <MasterAppContext.Provider
        value={ {
          updateNextPathName: this.updateNextPathName,
          updateLoginCredentials: this.updateLoginCredentials,
          handleLogin: this.handleLogin,
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
};

export default withRouter(MasterAppProvider);

export const MasterAppConsumer = MasterAppContext.Consumer;
