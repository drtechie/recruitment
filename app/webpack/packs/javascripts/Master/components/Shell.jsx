import React from 'react';
import PropTypes from 'prop-types';
import { Layout } from 'antd';

const { Content, Footer } = Layout;

class Shell extends React.Component {
  static propTypes = {
    children: PropTypes.object.isRequired,
  }

  render() {
    const { children } = this.props;
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

export default Shell;
