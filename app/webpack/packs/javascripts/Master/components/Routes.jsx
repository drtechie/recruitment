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

const HelloAvegenView = MyLoadable({
  loader: () => import('../../HelloAvegen/components/HelloAvegen'),
  render(loaded, props) {
    const HelloAvegen = loaded.default;
    return (
      <HelloAvegen { ...props } />
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

class Routes extends Component {
  render() {
    const {
      location,
      authToken,
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
              component={ HelloAvegenView }
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
};

export default hot(module)(withMaster(withRouter(Routes)));
