import React, { Component } from 'react';
import { Switch } from 'react-router-dom';
import { withRouter } from 'react-router';
import PropTypes from 'prop-types';
import Loadable from 'react-loadable';
import { hot } from 'react-hot-loader';
import Shell from './Shell';
import PageLoading from '../../Common/PageLoading';
import RenderRoute from './RenderRoute';
import LoadError from '../../Common/LoadError';
import { withMaster } from '../withMaster';

function MyLoadable(opts) {
  return Loadable(Object.assign({
    loading: PageLoading,
    delay: 200,
    timeout: 10,
  }, opts));
}

const HelloIntervieweeView = MyLoadable({
  loader: () => import('../../HelloInterviewee/components/HelloInterviewee'),
  render(loaded, props) {
    const HelloInterviewee = loaded.default;
    return (
      <HelloInterviewee { ...props } />
    );
  },
});

const SelectInterviewView = MyLoadable({
  loader: () => import('../../SelectInterview/components/SelectInterview'),
  render(loaded, props) {
    const SelectInterview = loaded.default;
    return (
      <SelectInterview { ...props } />
    );
  },
});

const AttemptInterviewView = MyLoadable({
  loader: () => import('../../AttemptInterview/components/AttemptInterview'),
  render(loaded, props) {
    const AttemptInterview = loaded.default;
    return (
      <AttemptInterview { ...props } />
    );
  },
});

const PreviewQuestionView = MyLoadable({
  loader: () => import('../../PreviewQuestion/components/PreviewQuestion'),
  render(loaded, props) {
    const PreviewQuestion = loaded.default;
    return (
      <PreviewQuestion { ...props } />
    );
  },
});

class Routes extends Component {
  render() {
    const {
      location,
      authToken,
      isAdmin,
    } = this.props;

    return (
      <div>
        <Shell
          location={ location }
        >
          <Switch>
            <RenderRoute
              exact
              path='/'
              component={ HelloIntervieweeView }
            />
            <RenderRoute
              exact
              path='/select-interview'
              component={ SelectInterviewView }
              authenticated={ !!authToken }
              authRequired={ true }
            />
            <RenderRoute
              exact
              path='/attempt-interview/:attemptID'
              component={ AttemptInterviewView }
              authenticated={ !!authToken }
              authRequired={ true }
            />
            <RenderRoute
              exact
              path='/preview-question/:questionID'
              component={ PreviewQuestionView }
              authenticated={ !!authToken }
              authRequired={ true }
              isAdmin={ isAdmin }
              adminPrivRequired={ true }
            />
            <RenderRoute
              component={ LoadError }
              message='Not found.'
            />
          </Switch>
        </Shell>
      </div>
    );
  }
}

Routes.propTypes = {
  location: PropTypes.object,
  authToken: PropTypes.object,
  isAdmin: PropTypes.bool,
};

let routes = withMaster(withRouter(Routes));

if (process.env.NODE_ENV === 'development') {
  routes = hot(module)(routes);
}

const routesExport = routes;

export default routesExport;
