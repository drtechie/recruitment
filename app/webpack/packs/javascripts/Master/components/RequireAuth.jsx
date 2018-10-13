import { Component } from 'react';
import PropTypes from 'prop-types';
import { withRouter } from 'react-router';

class RequireAuth extends Component {
  static propTypes = {
    children: PropTypes.object.isRequired,
  }

  constructor(props) {
    super(props);
    this.state = {};
  }

  static getDerivedStateFromProps(nextProps) {
    const {
      authenticated, history, location, updateNextPathName,
    } = nextProps;

    if (!authenticated) {
      updateNextPathName(location.pathname);
      history.push('/');
    }
    return null;
  }

  render() {
    const { children } = this.props;
    return children;
  }
}

export default withRouter(RequireAuth);
