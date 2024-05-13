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
  constructor(props) {
    super(props);
    this.trackMouseEventThrottled = this.debounce(this.trackEvent, 5000);
    this.trackWindowEventThrottled = this.debounce(this.trackEvent, 5000);
    this.trackEvent = this.trackEvent.bind(this);
    this.submitAnswer = this.submitAnswer.bind(this);
    this.trackVisibilityChange = this.trackVisibilityChange.bind(this);
    this.trackFullscreenChange = this.trackFullscreenChange.bind(this);
  }

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
    targetTimeForCurrentQuestion: null,
  };

  componentDidMount() {
    this.getAttempt();
    document.addEventListener('contextmenu', this.handleContextMenu);
    document.addEventListener('click', this.trackEvent);
    document.addEventListener('mousemove', this.trackMouseEvent);
    document.addEventListener('mousedown', this.trackMouseEvent);
    document.addEventListener('mouseup', this.trackMouseEvent);

    // Add event listener to track window events
    window.addEventListener('resize', this.trackWindowEvent);
    window.addEventListener('scroll', this.trackWindowEvent);
    document.addEventListener("visibilitychange", this.trackVisibilityChange);
    document.addEventListener("fullscreenchange", this.trackFullscreenChange);

    // Add event listener to track keyboard events
    document.addEventListener('keydown', this.trackKeyboardEvent);
    document.addEventListener('keyup', this.trackKeyboardEvent);
    document.addEventListener('keypress', this.trackKeyboardEvent);
  }

  componentDidUpdate(prevProps, prevState) {
    const { state: { attempt: { current_state } } } = this;
    if (current_state === 'in_progress' && current_state !== prevState.attempt.current_state) {
      this.fetchNewQuestion();
    }
  }

  componentWillUnmount() {
    document.removeEventListener('contextmenu', this.handleContextMenu);
    document.removeEventListener('click', this.trackEvent);
    document.removeEventListener('mousemove', this.trackMouseEvent);
    document.removeEventListener('mousedown', this.trackMouseEvent);
    document.removeEventListener('mouseup', this.trackMouseEvent);

    window.removeEventListener('resize', this.trackWindowEvent);
    window.removeEventListener('scroll', this.trackWindowEvent);
    document.removeEventListener("visibilitychange", this.trackVisibilityChange);
    document.removeEventListener("fullscreenchange", this.trackFullscreenChange);

    document.removeEventListener('keydown', this.trackKeyboardEvent);
    document.removeEventListener('keyup', this.trackKeyboardEvent);
    document.removeEventListener('keypress', this.trackKeyboardEvent);
  }

  debounce(func, delay) {
    let timeoutId;
    return function(...args) {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(() => {
        func.apply(this, args);
      }, delay);
    };
  }

  handleContextMenu = (event) => {
    event.preventDefault();
  }

  trackMouseEvent = (event) => {
    this.trackMouseEventThrottled(event.type, { clientX: event.clientX, clientY: event.clientY });
  }

  trackWindowEvent = (event) => {
    this.trackWindowEventThrottled(event.type, { innerWidth: window.innerWidth, innerHeight: window.innerHeight });
  }

  trackKeyboardEvent = (event) => {
    this.trackEvent(event.type, { key: event.key });
  }

  trackVisibilityChange() {
    this.trackEvent('visibilitychange', { visibilityState: document.visibilityState });
  }

  trackFullscreenChange() {
    this.trackEvent('fullscreenchange', { fullscreen: !!document.fullscreenElement });
  }

  trackEvent = (eventName, params) => {
    const {
      attempt
    } = this.state;
    const eventData = {
      name: eventName,
      params: params
    };

    if (attempt.id) {
      axios.post(`/api/v1/attempts/${attempt.id}/events`, eventData)
        .then(response => {
          console.log('Event submitted successfully:', response.data);
        })
        .catch(error => {
          console.error('Error submitting event:', error);
        });
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
          this.resetTimer();
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

  resetTimer = () => {
    const { attempt } = this.state;
    if (attempt.time_per_question) {
      const targetTimeForCurrentQuestion = new Date(new Date().getTime() + attempt.time_per_question * 1000);
      this.setState({ targetTimeForCurrentQuestion })
    }
  }

  render() {
    const {
      error, errorMessage, attempt, starting, attemptMessage,
      loading, fetchingNextQuestion, question, submittingAnswer,
      skippingAnswer, targetTimeForCurrentQuestion
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
                label="Time left for assessment:"
                type='warning'
                onEnd={ this.endAttempt }
              />
            }
            {
              targetTimeForCurrentQuestion && attempt.current_state === 'in_progress' && (
                <>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <CountDown
                    target={ targetTimeForCurrentQuestion }
                    label="Time left for question:"
                    type='danger'
                    onEnd={ () => {
                      const answer = {};
                      answer[question.id] = null;
                      this.submitAnswer(answer, true)
                    }}
                  />
                </>
              )
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
