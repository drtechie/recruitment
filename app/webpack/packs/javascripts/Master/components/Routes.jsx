import React, { Component } from 'react';
import { Switch } from 'react-router-dom';
import { withRouter } from 'react-router';
import PropTypes from 'prop-types';
import Loadable from 'react-loadable';
import Shell from './Shell';
import PageLoading from '../../Common/PageLoading';
import RenderRoute from './RenderRoute';
import LoadError from '../../Common/LoadError';

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

class Routes extends Component {
  render() {
    const {
      location,
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
              path='/deee'
              component={ HelloAvegenView }
              authenticated={ false }
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
};

export default withRouter(Routes);
