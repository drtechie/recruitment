import React from 'react';
import { Grid, Row, Col } from 'react-flexbox-grid';
import axios from 'axios';
import PropTypes from 'prop-types';
import { withMaster } from '../../Master/withMaster';
import LoadError from '../../Common/LoadError';
import PageLoading from '../../Common/PageLoading';
import ShowQuestion from '../../Common/ShowQuestion';

class PreviewQuestion extends React.Component {
  state = {
    error: false,
    errorMessage: '',
    loading: false,
    question: null,
  };

  componentDidMount() {
    this.getQuestion();
  }

  getQuestion = () => {
    this.setState({ loading: true });
    const { props: { match: { params: { questionID } } } } = this;
    axios.get(`/api/v1/questions/preview/${ questionID }`)
      .then((response) => {
        const { question } = response.data;
        this.setState({ question });
        this.setState({ loading: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ loading: false });
      });
  }

  render() {
    const {
      error, errorMessage, loading, question,
    } = this.state;
    return (
      <Grid
        fluid
      >
        <Row>
          <Col xs={ 12 } className='margin-top-15'>
            {
              loading
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
              question
              && (
                <ShowQuestion
                  question={ question }
                  preview={ true }
                />
              )
            }
          </Col>
        </Row>
      </Grid>
    );
  }
}

PreviewQuestion.propTypes = {
  match: PropTypes.object,
};

export default withMaster(PreviewQuestion);
