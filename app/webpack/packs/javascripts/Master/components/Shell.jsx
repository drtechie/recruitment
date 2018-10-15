import React from 'react';
import PropTypes from 'prop-types';
import {
  Button, Layout, Icon, Menu, Dropdown,
} from 'antd';
import { Link } from 'react-router-dom';
import { Grid, Row, Col } from 'react-flexbox-grid';
import avegenLogo from '../../../images/avegen-logo.png';
import { withMaster } from '../withMaster';

const { Content, Footer } = Layout;

class Shell extends React.Component {
  static propTypes = {
    children: PropTypes.object.isRequired,
    authToken: PropTypes.object,
    name: PropTypes.string,
    handleLogout: PropTypes.func.isRequired,
    loggingOut: PropTypes.bool.isRequired,
  }

  render() {
    const {
      children, authToken, handleLogout, loggingOut, name,
    } = this.props;

    const menu = (
      <Menu>
        <Menu.Item key='1'>
          <Link
            to='/select-interview'
          >
            Interviews
          </Link>
        </Menu.Item>
        <Menu.Item
          key='3'
          loading={ loggingOut }
          onClick={ () => handleLogout() }
        >
          Logout <Icon type='logout' theme='outlined' />
        </Menu.Item>
      </Menu>
    );

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
              <Row>
                <Col xs={ 3 }>
                  <img
                    src={ avegenLogo }
                    width='150px'
                    alt='Avegen Logo'
                  />
                </Col>
                <Col
                  style={ { textAlign: 'right ' } }
                  xs={ 9 }
                  className='margin-top-15'
                >
                  Hello, <span className='text-bold padding-right-15'>{ name }</span>
                  <Dropdown overlay={ menu }>
                    <Button
                      type='primary'
                    >
                      Menu <Icon type='down' />
                    </Button>
                  </Dropdown>
                </Col>
              </Row>
            </Grid>
            )
          }
          { children }
        </Content>
        <Footer style={ { textAlign: 'center' } } theme='dark'>
          &copy; {(new Date()).getFullYear()} Avegen India Pvt Ltd
        </Footer>
      </Layout>
    );
  }
}

export default withMaster(Shell);
