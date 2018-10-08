import React from 'react';
import PropTypes from 'prop-types';

export default class LoadError extends React.Component {
  static propTypes = {
    message: PropTypes.string,
  };

  render() {
    const { message } = this.props;
    return (
      <div>
        {message}
      </div>

    );
  }
}
