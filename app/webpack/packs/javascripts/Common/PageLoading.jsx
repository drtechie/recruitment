import React from 'react';
import PropTypes from 'prop-types';

const PageLoading = ({
  isLoading, pastDelay, error,
}) => {
  if (isLoading && pastDelay) {
    return (
      <div>
        <div className='loader bar'>
          <div />
          <div />
          <div />
          <div />
        </div>
      </div>
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
