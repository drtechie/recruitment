import React from 'react';
import PropTypes from 'prop-types';
import { Button, Layout, Icon } from 'antd';
import { Grid, Row, Col } from 'react-flexbox-grid';
import { withMaster } from '../withMaster';

const { Content, Footer } = Layout;

class Shell extends React.Component {
  static propTypes = {
    children: PropTypes.object.isRequired,
    authToken: PropTypes.object,
    handleLogout: PropTypes.func.isRequired,
    loggingOut: PropTypes.bool.isRequired,
  }

  render() {
    const {
      children, authToken, handleLogout, loggingOut,
    } = this.props;
    return (
      <Layout className='layout' style={ { minHeight: '100vh' } }>
        <Content
          style={ {
            margin: '69px 69px 0 69px',
            padding: 24,
            background: '#fff',
            position: 'relative',
            minHeight: 'calc("100vh - 69px")',
          } }
        >
          {
            authToken && (
            <Grid fluid>
              <Row end='xs'>
                <Col
                  xs={ 12 }
                  className='margin-top-15'
                >
                  <Button
                    type='primary'
                    loading={ loggingOut }
                    onClick={ () => handleLogout() }
                  >
                    Logout
                    {' '}
                    <Icon type='logout' theme='outlined' />
                  </Button>
                </Col>
              </Row>
            </Grid>
            )
          }
          { children }
        </Content>
        <Footer style={ { textAlign: 'center' } } theme='dark'>
          &copy;
          {' '}
          {(new Date()).getFullYear()}
          {' '}
Avegen India Pvt Ltd
        </Footer>
      </Layout>
    );
  }
}

export default withMaster(Shell);
