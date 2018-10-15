import React from 'react';
import PropTypes from 'prop-types';
import { Alert } from 'antd';

export default class LoadError extends React.Component {
  static propTypes = {
    message: PropTypes.string,
    closable: PropTypes.bool,
  };

  render() {
    const { message, closable } = this.props;
    return (
      <Alert
        message='Error'
        description={ message }
        type='error'
        showIcon
        closable={ closable }
      />
    );
  }
}
