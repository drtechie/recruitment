import React from 'react';
import PropTypes from 'prop-types';
import { Button } from 'antd';
import MCQ from './MCQ';
import Essay from './Essay';
import { htmlWithLineBreaks } from "./Utils";

class ShowQuestion extends React.Component {
  state = {
    value: null,
  }

  componentDidUpdate(prevProps) {
    const { props: { question: { id } } } = this;
    if (id !== prevProps.question.id) {
      this.resetValue();
    }
  }

  onChange = (value) => {
    this.setState({
      value,
    });
  }

  resetValue = () => {
    this.setState({
      value: null,
    });
  }

  submitAnswer = () => {
    const { submitAnswer, question } = this.props;
    const { value } = this.state;
    const answer = {};
    answer[question.id] = value;
    submitAnswer(answer);
  }

  skipAnswer = () => {
    const { submitAnswer, question } = this.props;
    const answer = {};
    answer[question.id] = null;
    submitAnswer(answer, true);
  }

  render() {
    const {
      question, submitting, skipping, preview,
    } = this.props;

    const { value } = this.state;

    return (
      <div>
        <h3
          dangerouslySetInnerHTML={ // eslint-disable-line react/no-danger
            { __html: htmlWithLineBreaks(question.title) }
          }
          className='unselectable'
        />
        { question.type === 'Mcq' && <MCQ question={ question } onChange={ this.onChange } value={ value } />}
        { question.type === 'Essay' && <Essay question={ question } onChange={ this.onChange } value={ value } />}
        {
          !preview
          && (
          <div className='margin-top-3em'>
            <Button
              type='primary'
              loading={ submitting }
              disabled={ (value && value.length === 0) || !value }
              onClick={ this.submitAnswer }
            >
              Submit
            </Button>
            <Button
              className='margin-left-1em'
              type='danger'
              loading={ skipping }
              onClick={ this.skipAnswer }
            >
              Skip
            </Button>
          </div>
          )
        }
      </div>
    );
  }
}

ShowQuestion.propTypes = {
  question: PropTypes.object.isRequired,
  submitAnswer: PropTypes.func,
  submitting: PropTypes.bool,
  skipping: PropTypes.bool,
  preview: PropTypes.bool,
};

export default ShowQuestion;
