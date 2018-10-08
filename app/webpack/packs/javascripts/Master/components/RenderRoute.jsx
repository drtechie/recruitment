import React from 'react';
import PropTypes from 'prop-types';
import { Route } from 'react-router-dom';
import RequireAuth from './RequireAuth';
import { withMaster } from '../withMaster';

// Handler access to a route
const RenderRoute = ({
  component: Component,
  parent: ParentComponent,
  authRequired,
  authenticated,
  updateNextPathName,
  ...rest
}) => (
  <Route
    { ...rest }
    render={
      (props) => {
        const renderComponents = () => {
          let component;
          if (ParentComponent) {
            component = (
              <ParentComponent { ...props } { ...rest }>
                <Component
                  { ...props }
                  { ...rest }
                />
              </ParentComponent>
            );
          } else {
            component = (
              <Component
                { ...props }
                { ...rest }
              />
            );
          }
          return component;
        };
        if (authRequired) {
          return (
            <RequireAuth authenticated={ authenticated } updateNextPathName={ updateNextPathName }>
              { renderComponents() }
            </RequireAuth>
          );
        }
        return renderComponents();
      }
    }
  />
);

RenderRoute.propTypes = {
  component: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.func,
  ]),
  parent: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.func,
  ]),
  authRequired: PropTypes.bool,
  authenticated: PropTypes.bool,
  updateNextPathName: PropTypes.func.isRequired,
};

export default withMaster(RenderRoute);
