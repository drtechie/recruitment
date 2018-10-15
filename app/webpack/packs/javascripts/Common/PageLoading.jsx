import React from 'react';
import { Spin, Icon } from 'antd';
import PropTypes from 'prop-types';

const antIcon = <Icon type='loading' style={ { fontSize: 24 } } spin />;

const PageLoading = ({
  isLoading, pastDelay, error,
}) => {
  if (isLoading && pastDelay) {
    return (
      <Spin indicator={ antIcon } style={ { position: 'fixed', left: '1em', top: '1em' } } />
    );
  } if (error && !isLoading) {
    return <p>Error!</p>;
  }
  return null;
};

PageLoading.propTypes = {
  isLoading: PropTypes.bool.isRequired,
  pastDelay: PropTypes.bool.isRequired,
  error: PropTypes.bool,
};

export default PageLoading;
