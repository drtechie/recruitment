import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import { withRouter } from 'react-router';
import { withCookies, Cookies } from 'react-cookie';
import { message } from 'antd';

const MasterAppContext = React.createContext();

class MasterAppProvider extends Component {
  constructor(props) {
    super(props);
    const {
      authToken, name,
      orgConfig: { logo: orgLogo },
      orgName,
      isAdmin,
    } = props;
    this.state = {
      nextPath: null,
      authToken,
      orgName,
      orgLogo,
      isAdmin,
      name,
      loggingIn: false,
      loggingOut: false,
    };
  }

  updateNextPathName = (path) => {
    this.setState({ nextPath: path });
  }

  setCookie = (key, data) => {
    const { cookies } = this.props;
    cookies.set(key, JSON.stringify(data), { path: '/' });
  }

  deleteCookie = (key) => {
    const { cookies } = this.props;
    cookies.remove(key, { path: '/' });
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
        this.setCookie('authToken', authToken);
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
        this.deleteCookie('authToken');
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
  orgConfig: PropTypes.object,
  isAdmin: PropTypes.bool,
  cookies: PropTypes.instanceOf(Cookies),
};

export default withRouter(withCookies(MasterAppProvider));

export const MasterAppConsumer = MasterAppContext.Consumer;
