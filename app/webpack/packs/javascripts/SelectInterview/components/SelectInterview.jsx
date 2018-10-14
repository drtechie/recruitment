import React from 'react';
import {
  Tag, Button, List, Skeleton, Icon,
} from 'antd';
import { Grid, Row, Col } from 'react-flexbox-grid';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { withMaster } from '../../Master/withMaster';
import { capitalizeFirstLetter, getAttemptStateLabel } from '../../Common/Utils';
import LoadError from '../../Common/LoadError';

class SelectInterview extends React.Component {
  state = {
    attempts: [],
    error: false,
    errorMessage: '',
    loading: false,
  };

  componentDidMount() {
    this.getAttempts();
  }

  getAttempts = () => {
    this.setState({ loading: true });
    axios.get('/api/v1/attempts')
      .then((response) => {
        const { attempts } = response.data;
        this.setState({ attempts });
        if (attempts.length === 0) {
          this.setState({ error: true, errorMessage: 'No interviews for this user yet.' });
        }
        this.setState({ loading: false });
      })
      .catch((error) => {
        this.setState({ error: true, errorMessage: error.response.data.error });
        this.setState({ loading: false });
      });
  }

  render() {
    const {
      error, errorMessage, attempts, loading,
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
              attempts.length > 0
              && (
              <List
                bordered
                loading={ loading }
                itemLayout='horizontal'
                dataSource={ attempts }
                renderItem={ attempt => (
                  <List.Item actions={ [
                    <Link to={ `attempt-interview/${ attempt.id }` }>
                      <Button type='default' size='small' disabled={ ['reviewed', 'submitted'].includes(attempt.current_state) }>
                        { attempt.current_state === 'not_started' ? 'Start' : 'Continue' }
                        <Icon type='arrow-right' theme='outlined' />
                      </Button>
                    </Link>] }
                  >
                    <Skeleton loading={ attempt.loading } active>
                      <List.Item.Meta
                        title={ attempt.interview_name }
                        description={ (
                          <Tag color={ getAttemptStateLabel(attempt.current_state) }>
                            {capitalizeFirstLetter(attempt.current_state.replace(/_/g, ' '))}
                          </Tag>
) }
                      />
                    </Skeleton>
                  </List.Item>
                ) }
              />
              )
            }
          </Col>
        </Row>
      </Grid>
    );
  }
}

export default withMaster(SelectInterview);
