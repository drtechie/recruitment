import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import { Cookies, CookiesProvider } from 'react-cookie';
import MasterAppProvider from './MasterAppProvider';
import Routes from './components/Routes';

const MasterApp = (props) => {
  const cookies = new Cookies();
  const { authToken } = props;
  if (authToken) {
    cookies.set('authToken', JSON.stringify(authToken), { path: '/' });
  }
  return (
    <BrowserRouter>
      <CookiesProvider cookies={ cookies }>
        <MasterAppProvider { ...props }>
          <Routes />
        </MasterAppProvider>
      </CookiesProvider>
    </BrowserRouter>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('master');
  const data = JSON.parse(node.getAttribute('data'));

  ReactDOM.render(<MasterApp { ...data } />, node);
});
