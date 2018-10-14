import React from 'react';
import { Grid, Row, Col } from 'react-flexbox-grid';
import axios from 'axios';
import PropTypes from 'prop-types';
import { withMaster } from '../../Master/withMaster';
import LoadError from '../../Common/LoadError';
import AttemptStarter from './AttemptStarter';

class AttemptInterview extends React.Component {
  state = {
    attempt: {},
    error: false,
    errorMessage: '',
    loading: false,
    starting: false,
  };

  componentDidMount() {
    this.getAttempt();
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

  startAttempt = () => {
    this.setState({ starting: true });
    const {
      attempt: { id },
    } = this.state;
    axios.post('/api/v1/attempts/start', {
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

  render() {
    const {
      error, errorMessage, attempt, starting,
    } = this.state;
    return (
      <Grid
        fluid
      >
        <Row>
          <Col xs={ 12 } className='margin-top-15'>
            {
              error
              && (
                <LoadError message={ errorMessage } />
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
