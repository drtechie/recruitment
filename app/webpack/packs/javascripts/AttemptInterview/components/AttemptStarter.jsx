import React from 'react';
import { Button, TreeSelect } from 'antd';
import PropTypes from 'prop-types';

const { SHOW_PARENT } = TreeSelect;

class AttemptStarter extends React.Component {
  state = {
    selectedCategories: [],
  };

  onCategoryChange = (selectedCategories) => {
    this.setState({ selectedCategories });
  }

  render() {
    const {
      attempt, startAttempt, starting,
    } = this.props;

    const { selectedCategories } = this.state;

    const { interview_categories } = attempt;

    const tProps = {
      treeData: interview_categories,
      treeDefaultExpandAll: true,
      value: selectedCategories,
      onChange: this.onCategoryChange,
      treeCheckable: true,
      showCheckedStrategy: SHOW_PARENT,
      searchPlaceholder: 'Please select categories',
      style: {
        width: 300,
      },
    };

    return (
      <div>
        <h4>
          Starting <code>{ attempt.interview_name}</code> interivew
        </h4>
        <p>
          Select the categories of questions you wish to answer.
          You must select at least <code>2</code> categories.
          Remember that the more number of categories you answer,
          more the chances of proving your abilities. :)
        </p>
        <div>
          <TreeSelect { ...tProps } />
        </div>
        <div className='margin-top-1em '>
          <Button
            type='primary'
            loading={ starting }
            onClick={ () => startAttempt(selectedCategories) }
          >
            Go!
          </Button>
        </div>
      </div>
    );
  }
}

AttemptStarter.propTypes = {
  attempt: PropTypes.object.isRequired,
  startAttempt: PropTypes.func.isRequired,
  starting: PropTypes.bool.isRequired,
};

export default AttemptStarter;
