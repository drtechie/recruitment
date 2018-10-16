import React from 'react';
import { Grid, Row, Col } from 'react-flexbox-grid';
import axios from 'axios';
import PropTypes from 'prop-types';
import { withMaster } from '../../Master/withMaster';
import LoadError from '../../Common/LoadError';
import AttemptStarter from './AttemptStarter';
import PageLoading from '../../Common/PageLoading';
import ShowQuestion from './ShowQuestion';

class AttemptInterview extends React.Component {
  state = {
    attempt: {},
    error: false,
    errorMessage: '',
    loading: false,
    starting: false,
    question: {},
    fetchingNextQuestion: false,
    submittingAnswer: false,
  };

  componentDidMount() {
    this.getAttempt();
  }

  componentDidUpdate(prevProps, prevState) {
    const { state: { attempt: { current_state } } } = this;
    if (current_state !== prevState.attempt.current_state) {
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

  fetchNewQuestion = () => {
    this.setState({ fetchingNextQuestion: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/next-question', {
      attempt_id: id,
    })
      .then((response) => {
        const { question } = response.data;
        this.setState({ question });
        this.setState({ fetchingNextQuestion: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ fetchingNextQuestion: false });
      });
  }

  submitAnswer = (answer) => {
    this.setState({ submittingAnswer: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/submit-answer', {
      attempt_id: id,
      answer,
    })
      .then((response) => {
        const { question } = response.data;
        this.setState({ question });
        this.setState({ submittingAnswer: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ submittingAnswer: false });
      });
  }

  render() {
    const {
      error, errorMessage, attempt, starting,
      loading, fetchingNextQuestion, question, submittingAnswer,
    } = this.state;
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
              attempt.current_state === 'in_progress' && question
              && (
                <ShowQuestion
                  question={ question }
                  submitAnswer={ this.submitAnswer }
                  submitting={ submittingAnswer }
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
