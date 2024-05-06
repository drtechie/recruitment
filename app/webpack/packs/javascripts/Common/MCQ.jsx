import React from 'react';
import { Checkbox } from 'antd';
import PropTypes from 'prop-types';
import {htmlWithLineBreaks} from "./Utils";

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
                dangerouslySetInnerHTML={ // eslint-disable-line react/no-danger
                  { __html: htmlWithLineBreaks(option) }
                }
                className='unselectable'
              />
            ))
          }
        </ol>
        <CheckboxGroup onChange={ onChange } value={ value } className='margin-top-3em'>
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
  value: PropTypes.array,
};

export default MCQ;
