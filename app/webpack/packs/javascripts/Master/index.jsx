import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import MasterAppProvider from './MasterAppProvider';
import Routes from './components/Routes';

const MasterApp = (props) => {
  return (
    <MasterAppProvider { ...props }>
      <BrowserRouter>
        <Routes />
      </BrowserRouter>
    </MasterAppProvider>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('master');
  const data = JSON.parse(node.getAttribute('data'));

  ReactDOM.render(<MasterApp { ...data } />, node);
});
