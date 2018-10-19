import React from 'react';
import PropTypes from 'prop-types';
import { Input } from 'antd';

const { TextArea } = Input;

class Essay extends React.Component {
  render() {
    const {
      onChange, value,
    } = this.props;

    return (
      <div>
        <TextArea rows={ 4 } value={ value || '' } onChange={ (e) => onChange(e.target.value) } />
      </div>
    );
  }
}

Essay.propTypes = {
  onChange: PropTypes.func.isRequired,
  value: PropTypes.string,
};

export default Essay;
