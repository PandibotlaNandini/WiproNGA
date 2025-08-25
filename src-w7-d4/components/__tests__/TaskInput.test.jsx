// src/components/__tests__/TaskInput.test.jsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import TaskInput from '../taskInput';


describe('TaskInput', () => {
  test('updates input value as user types', async () => {
    render(<TaskInput onAdd={() => {}} />);
    const input = screen.getByPlaceholderText(/add a new task/i);
    await userEvent.type(input, 'Read book');
    expect(input.value).toBe('Read book');
  });

  test('calls onAdd when form is submitted', async () => {
    const onAdd = jest.fn();
    render(<TaskInput onAdd={onAdd} />);
    const input = screen.getByPlaceholderText(/add a new task/i);
    const button = screen.getByText(/add/i);

    await userEvent.type(input, 'Read book');
    await userEvent.click(button);

    expect(onAdd).toHaveBeenCalledWith('Read book');
  });
});