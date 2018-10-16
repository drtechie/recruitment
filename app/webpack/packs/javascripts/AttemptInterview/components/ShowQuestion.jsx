import React from 'react';
import PropTypes from 'prop-types';
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

  render() {
    const {
      question, submitAnswer, submitting,
    } = this.props;

    const { value } = this.state;

    return (
      <div>
        <h3> { question.title } </h3>
        { question.type === 'Mcq' && <MCQ question={ question } onChange={ this.onChange } value={ value } />}
        { question.type === 'Essay' && <Essay question={ question } onChange={ this.onChange } value={ value } />}
      </div>
    );
  }
}

ShowQuestion.propTypes = {
  question: PropTypes.object.isRequired,
  submitAnswer: PropTypes.func.isRequired,
  submitting: PropTypes.bool.isRequired,
};

export default ShowQuestion;
