import React from 'react';
import { Checkbox } from 'antd';
import PropTypes from 'prop-types';

const CheckboxGroup = Checkbox.Group;

class MCQ extends React.Component {
  render() {
    const {
      question, onChange, value,
    } = this.props;

    return (
      <div>
        <ol type='A'>
          {
            question.details.options.map((option, key) => (
              <li
                key={ String.fromCharCode(65 + key) }
                dangerouslySetInnerHTML={ { __html: option } }
              />
            ))
          }
        </ol>
        <CheckboxGroup onChange={ onChange } value={ value }>
          {
            question.details.options.map((option, key) => (
              <Checkbox
                value={ key }
                key={ String.fromCharCode(65 + key) }
              >{ String.fromCharCode(65 + key) }
              </Checkbox>
            ))
          }
        </CheckboxGroup>
      </div>
    );
  }
}

MCQ.propTypes = {
  question: PropTypes.object.isRequired,
  onChange: PropTypes.func.isRequired,
  value: PropTypes.object,
};

export default MCQ;
