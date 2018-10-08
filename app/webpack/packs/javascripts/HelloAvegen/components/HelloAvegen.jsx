import React from 'react';
import { Input, AutoComplete, Button } from 'antd';
import { Grid, Row, Col } from 'react-flexbox-grid';
import QueueAnim from 'rc-queue-anim';
import avegenLogo from '../../../images/avegen-logo.png';

export default class HelloAvegen extends React.Component {
  state = {
    dataSource: [],
    loading: false,
  };

  handleChange = (value) => {
    this.setState({
      dataSource: !value || value.indexOf('@') >= 0 ? [] : [
        `${ value }@gmail.com`,
        `${ value }@yahoo.com`,
      ],
    });
  };

  enterLoading = () => {
    this.setState({ loading: true });
  }

  render() {
    const { dataSource, loading } = this.state;
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
                    src={ avegenLogo }
                    width='100%'
                    alt='Avegen Logo'
                  />
                </Col>
              </Row>
              <Row center='xs' key='welcome'>
                <Col xs={ 8 } className='margin-top-15'>
                  <h3 className='text-center'>Welcome to Avegen India Pvt Ltd Recruitment</h3>
                </Col>
              </Row>
              <Row center='xs' key='email'>
                <Col
                  xs={ 5 }
                  className='margin-top-15'
                >
                  <AutoComplete
                    dataSource={ dataSource }
                    style={ { width: '100%' } }
                    onChange={ this.handleChange }
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
                    loading={ loading }
                    onClick={ this.enterLoading }
                  >
                    Submit
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
