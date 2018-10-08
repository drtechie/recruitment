import React, { Component } from 'react';
import PropTypes from 'prop-types';

const MasterAppContext = React.createContext();

export default class MasterAppProvider extends Component {
  state = {
    nextPath: null,
    authToken: null,
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

  render() {
    const { children } = this.props;
    return (
      <MasterAppContext.Provider
        value={ { updateNextPathName: this.updateNextPathName, ...this.state } }
      >
        { children }
      </MasterAppContext.Provider>
    );
  }
}

MasterAppProvider.propTypes = {
  children: PropTypes.object,

};

export const MasterAppConsumer = MasterAppContext.Consumer;
