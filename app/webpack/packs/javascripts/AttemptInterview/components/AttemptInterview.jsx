import React from 'react';
import { Grid, Row, Col } from 'react-flexbox-grid';
import axios from 'axios';
import PropTypes from 'prop-types';
import { message as popupMessage, Result } from 'antd';
import { withMaster } from '../../Master/withMaster';
import LoadError from '../../Common/LoadError';
import AttemptStarter from './AttemptStarter';
import PageLoading from '../../Common/PageLoading';
import ShowQuestion from '../../Common/ShowQuestion';
import CountDown from "../../Common/Countdown";

class AttemptInterview extends React.Component {
  state = {
    attempt: {},
    attemptMessage: 'You answers are under review. You will be contacted soon.',
    error: false,
    errorMessage: '',
    loading: false,
    starting: false,
    question: {},
    fetchingNextQuestion: false,
    submittingAnswer: false,
    skippingAnswer: false,
  };

  componentDidMount() {
    this.getAttempt();
  }

  componentDidUpdate(prevProps, prevState) {
    const { state: { attempt: { current_state } } } = this;
    if (current_state === 'in_progress' && current_state !== prevState.attempt.current_state) {
      this.fetchNewQuestion();
    }
  }

  getAttempt = () => {
    this.setState({ loading: true });
    const { props: { match: { params: { attemptID } } } } = this;
    axios.get(`/api/v1/attempts/${ attemptID }`)
      .then((response) => {
        const { attempt } = response.data;
        this.setState({ attempt });
        this.setState({ loading: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ loading: false });
      });
  }

  startAttempt = (selectedCategories) => {
    this.setState({ starting: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/start', {
      attempt_id: id,
      category_ids: selectedCategories,
    })
      .then((response) => {
        const { attempt } = response.data;
        this.setState({ attempt });
        this.setState({ starting: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ starting: false });
      });
  }

  endAttempt = () => {
    this.setState({ starting: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/end', {
      attempt_id: id,
    })
      .then((response) => {
        const { attempt } = response.data;
        this.setState({ attempt });
        this.setState({ starting: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ starting: false });
      });
  }

  fetchNewQuestion = () => {
    this.setState({ fetchingNextQuestion: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/next-question', {
      attempt_id: id,
    })
      .then((response) => {
        const { question, attempt, message } = response.data;
        if (attempt) {
          this.setState({ attempt });
        }
        if (question) {
          this.setState({ question });
        }
        if (message) {
          this.setState({ attemptMessage: message });
        }
        this.setState({ fetchingNextQuestion: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ fetchingNextQuestion: false });
      });
  }

  submitAnswer = (answer, skip) => {
    if (skip) {
      this.setState({ skippingAnswer: true });
    } else {
      this.setState({ submittingAnswer: true });
    }
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/submit-answer', {
      attempt_id: id,
      answer,
    })
      .then((response) => {
        const { message } = response.data;
        popupMessage.success(message);
        if (skip) {
          this.setState({ skippingAnswer: false });
        } else {
          this.setState({ submittingAnswer: false });
        }
        this.fetchNewQuestion();
      })
      .catch((error) => {
        popupMessage.error('An error occurred while submitting the answer. Contact support if issue persists.');
        this.setState({ error: true, errorMessage: error.response.data.error });
        if (skip) {
          this.setState({ skippingAnswer: false });
        } else {
          this.setState({ submittingAnswer: false });
        }
      });
  }

  render() {
    const {
      error, errorMessage, attempt, starting, attemptMessage,
      loading, fetchingNextQuestion, question, submittingAnswer,
      skippingAnswer,
    } = this.state;

    let targetTime;
    if (attempt.time_allowed && attempt.started_at) {
      const date = new Date(attempt.started_at * 1000);
      targetTime = date.setMinutes(date.getMinutes() + attempt.time_allowed);
    }
    return (
      <Grid
        fluid
      >
        <Row>
          <Col xs={ 12 } className='margin-top-15'>
            {
              (loading || fetchingNextQuestion)
                && <PageLoading isLoading={ true } pastDelay={ true } />
            }
            {
              error
              && (
                <div className='margin-bottom-1em'>
                  <LoadError message={ errorMessage } />
                </div>
              )
            }
            {
              attempt.current_state === 'not_started'
              && (
              <AttemptStarter
                attempt={ attempt }
                startAttempt={ this.startAttempt }
                starting={ starting }
              />
              )
            }
            {
              targetTime && attempt.current_state === 'in_progress' &&
              <CountDown
                target={ targetTime }
                onEnd={ this.endAttempt }
              />
            }
            {
              attempt.current_state === 'in_progress' && question.title
              && (
                <ShowQuestion
                  question={ question }
                  submitAnswer={ this.submitAnswer }
                  submitting={ submittingAnswer }
                  skipping={ skippingAnswer }
                />
              )
            }
            {
              attempt.current_state === 'submitted'
              && (
                <Result
                  status="success"
                  title="Answers Submitted"
                  subTitle={ attemptMessage }
                />
              )
            }
          </Col>
        </Row>
      </Grid>
    );
  }
}

AttemptInterview.propTypes = {
  match: PropTypes.object,
};

export default withMaster(AttemptInterview);
