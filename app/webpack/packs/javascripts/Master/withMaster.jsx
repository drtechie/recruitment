import React from 'react';
import { MasterAppConsumer } from './MasterAppProvider';

export function withMaster(ChildComponent) {
  // ...and returns another component...
  return function MasterComponent(props) {
    // ... and renders the wrapped component with the context theme!
    // Notice that we pass through any additional props as well
    return (
      <MasterAppConsumer>
        {
          ({
            updateNextPathName, updateLoginCredentials, handleLogin, ...rest
          }) => {
            return (
              <ChildComponent
                { ...props }
                { ...rest }
                handleLogin={ handleLogin }
                updateLoginCredentials={ updateLoginCredentials }
                updateNextPathName={ updateNextPathName }
              />
            );
          }
        }
      </MasterAppConsumer>
    );
  };
}
