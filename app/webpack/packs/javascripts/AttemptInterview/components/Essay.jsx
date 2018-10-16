import React from 'react';
import PropTypes from 'prop-types';

class Essay extends React.Component {
  render() {
    const {
      question, onChange,
    } = this.props;

    return (
      <div>
        Essay question
      </div>
    );
  }
}

Essay.propTypes = {
  question: PropTypes.object.isRequired,
  onChange: PropTypes.func.isRequired,
};

export default Essay;
