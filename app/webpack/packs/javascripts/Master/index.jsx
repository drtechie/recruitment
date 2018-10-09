import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import MasterAppProvider from './MasterAppProvider';
import Routes from './components/Routes';

const MasterApp = (props) => {
  return (
    <BrowserRouter>
      <MasterAppProvider { ...props }>
        <Routes />
      </MasterAppProvider>
    </BrowserRouter>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('master');
  const data = JSON.parse(node.getAttribute('data'));

  ReactDOM.render(<MasterApp { ...data } />, node);
});
