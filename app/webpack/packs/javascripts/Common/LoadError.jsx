import React from 'react';
import PropTypes from 'prop-types';
import { Alert } from 'antd';

export default class LoadError extends React.Component {
  static propTypes = {
    message: PropTypes.string,
  };

  render() {
    const { message } = this.props;
    return (
      <Alert
        message='Error'
        description={ message }
        type='error'
        showIcon
      />
    );
  }
}
