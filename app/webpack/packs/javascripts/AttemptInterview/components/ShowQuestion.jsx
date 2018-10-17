import React from 'react';
import PropTypes from 'prop-types';
import { Button } from 'antd';
import MCQ from './MCQ';
import Essay from './Essay';

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
      question, submitting, skipping,
    } = this.props;

    const { value } = this.state;

    return (
      <div>
        <h3> { question.title } </h3>
        { question.type === 'Mcq' && <MCQ question={ question } onChange={ this.onChange } value={ value } />}
        { question.type === 'Essay' && <Essay question={ question } onChange={ this.onChange } value={ value } />}
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
      </div>
    );
  }
}

ShowQuestion.propTypes = {
  question: PropTypes.object.isRequired,
  submitAnswer: PropTypes.func.isRequired,
  submitting: PropTypes.bool.isRequired,
  skipping: PropTypes.bool.isRequired,
};

export default ShowQuestion;
