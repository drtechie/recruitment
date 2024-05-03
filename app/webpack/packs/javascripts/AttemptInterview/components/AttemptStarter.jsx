import React from 'react';
import { Button, TreeSelect, Alert } from 'antd';
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
          Starting <code>{ attempt.interview_name }</code>
        </h4>
        <p>
          Welcome to the assessment.
          Select the categories of questions you wish to answer.
        </p>
        {
          attempt.time_allowed && (
            <p>
              <Alert message={`You will have a total of ${attempt.time_allowed} minutes to complete the assessment. Once you start, the timer will begin, and you cannot pause or restart the timer. You can reload the page and come back to where you left off, but the timer will keep ticking once started.`} type="warning" />
            </p>
          )
        }
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
