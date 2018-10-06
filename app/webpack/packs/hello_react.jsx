// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { Input, Layout, AutoComplete, Button } from 'antd';
import { Grid, Row, Col } from 'react-flexbox-grid';
const { Content, Footer } = Layout;
import avegenLogo from './images/avegen-logo.png';

class HelloAvegen extends React.Component {
  state = {
    dataSource: [],
    loading: false,
  };

  handleChange = (value) => {
    this.setState({
      dataSource: !value || value.indexOf('@') >= 0 ? [] : [
        `${value}@gmail.com`,
        `${value}@yahoo.com`,
      ],
    });
  };

  enterLoading = () => {
    this.setState({ loading: true });
  }

  render() {
    return (
      <Layout className="layout" style={{ minHeight: "100vh" }} >
        <Content
          style={{ margin: '69px 69px 0 69px', padding: 24, background: '#fff', minHeight: 'calc("100vh - 69px")' }}
        >
          <Grid fluid style={{minHeight: "100%", display: "flex"}}>
            <Row center="xs" middle="xs" style={{flexBasis: "100%"}}>
              <Col xs={12}>
                <Row center="xs">
                  <Col xs={8}>
                    <img
                      src={avegenLogo}
                      width={400}
                      alt='Avegen Logo'
                    />
                  </Col>
                </Row>
                <Row center="xs">
                  <Col xs={8} className='margin-top-15'>
                    <h3 className='text-center'>Welcome to Avegen India Pvt Ltd Recruitment</h3>
                  </Col>
                </Row>
                <Row center="xs">
                  <Col
                    span={12}
                    offset={6}
                    className='margin-top-15'
                  >
                    <AutoComplete
                      dataSource={this.state.dataSource}
                      style={{ width: 400 }}
                      onChange={this.handleChange}
                      placeholder="Email"
                    />
                  </Col>
                </Row>
                <Row center="xs">
                  <Col
                    span={12}
                    offset={6}
                    className='margin-top-5'
                  >
                    <Input
                      placeholder="Authentication Code"
                      style={{ width: 400 }}
                    />
                  </Col>
                </Row>
                <Row center="xs">
                  <Col
                    xs={8}
                    className='margin-top-15'
                  >
                    <Button
                      type="primary"
                      loading={this.state.loading} onClick={this.enterLoading}
                    >
                      Submit
                    </Button>
                  </Col>
                </Row>
              </Col>
            </Row>
          </Grid>
        </Content>
        <Footer style={{ textAlign: 'center' }} theme="dark">
          ©2018 Avegen India Pvt Ltd
        </Footer>
      </Layout>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <HelloAvegen/>,
    document.body.appendChild(document.createElement('div')));
})




