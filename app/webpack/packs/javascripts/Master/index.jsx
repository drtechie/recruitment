import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import MasterAppProvider from './MasterAppProvider';
import Routes from './components/Routes';

const MasterApp = () => {
  return (
    <MasterAppProvider>
      <BrowserRouter>
        <Routes />
      </BrowserRouter>
    </MasterAppProvider>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <MasterApp />,
    document.body.appendChild(document.createElement('div'))
  );
});
