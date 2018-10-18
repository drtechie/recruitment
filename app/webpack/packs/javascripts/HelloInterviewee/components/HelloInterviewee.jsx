import React from 'react';
import {
  Icon, Input, AutoComplete, Button,
} from 'antd';
import { Grid, Row, Col } from 'react-flexbox-grid';
import QueueAnim from 'rc-queue-anim';
import PropTypes from 'prop-types';
import logo from '../../../images/logo.png';
import { withMaster } from '../../Master/withMaster';

class HelloInterviewee extends React.Component {
  state = {
    dataSource: [],
    email: '',
    authCode: '',
  };

  componentDidMount() {
    const { authToken, history } = this.props;
    if (authToken) {
      history.push('/select-interview');
    }
  }

  handleEmailChange = (value) => {
    if (!value || value.indexOf('@') >= 0) {
      this.setState({
        dataSource: [],
      });
    } else {
      this.setState({
        dataSource: [
          `${ value }@gmail.com`,
          `${ value }@yahoo.com`,
        ],
      });
    }
    this.setState({ email: value });
  };

  handleAuthCodeChange = (event) => {
    this.setState({ authCode: event.target.value });
  };

  render() {
    const { loggingIn, handleLogin, orgName } = this.props;
    const { dataSource, email, authCode } = this.state;
    return (
      <Grid
        fluid
        style={ {
          minHeight: '100%', display: 'flex', position: 'absolute', width: '100%',
        } }
      >
        <Row center='xs' middle='xs' style={ { flexBasis: '100%' } }>
          <Col xs={ 12 }>
            <QueueAnim
              delay={ 300 }
              animConfig={ [
                { opacity: [1, 0], translateY: [0, 50] },
              ] }
            >
              <Row center='xs' key='logo'>
                <Col xs={ 4 }>
                  <img
                    src={ logo }
                    width='100%'
                    alt={ `${ orgName } Logo` }
                  />
                </Col>
              </Row>
              <Row center='xs' key='welcome'>
                <Col xs={ 8 } className='margin-top-15'>
                  <h3 className='text-center'>Welcome to {orgName} Recruitment</h3>
                </Col>
              </Row>
              <Row center='xs' key='email'>
                <Col
                  xs={ 5 }
                  className='margin-top-15'
                >
                  <AutoComplete
                    dataSource={ dataSource }
                    value={ email }
                    style={ { width: '100%' } }
                    onChange={ this.handleEmailChange }
                    placeholder='Email'
                  />
                </Col>
              </Row>
              <Row center='xs' key='auth-code'>
                <Col
                  xs={ 5 }
                  className='margin-top-5'
                >
                  <Input
                    value={ authCode }
                    onChange={ this.handleAuthCodeChange }
                    placeholder='Authentication Code'
                    style={ { width: '100%' } }
                  />
                </Col>
              </Row>
              <Row center='xs' key='submit'>
                <Col
                  xs={ 5 }
                  className='margin-top-15'
                >
                  <Button
                    type='primary'
                    className='margin-left-1em '
                    loading={ loggingIn }
                    onClick={ () => handleLogin(email, authCode) }
                  >
                    Submit <Icon type='login' theme='outlined' />
                  </Button>
                </Col>
              </Row>
            </QueueAnim>
          </Col>
        </Row>
      </Grid>
    );
  }
}

HelloInterviewee.propTypes = {
  handleLogin: PropTypes.func.isRequired,
  loggingIn: PropTypes.bool.isRequired,
  history: PropTypes.object,
  authToken: PropTypes.object,
  orgName: PropTypes.string,
};

export default withMaster(HelloInterviewee);
