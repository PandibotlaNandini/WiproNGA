import React, { useState } from 'react';

const TaskInput = ({ onAdd }) => {
  const [value, setValue] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (value.trim()) {
      onAdd(value);
      setValue('');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        placeholder="Add a new task"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <button type="submit">Add</button>
    </form>
  );
};

export default TaskInput;