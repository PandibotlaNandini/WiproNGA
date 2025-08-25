// src/components/__tests__/TaskItem.test.jsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import TaskItem from '../TaskItem';

const sampleTask = { id: 1, text: 'Read book', completed: false };

describe('TaskItem', () => {
  test('can mark task as completed', async () => {
    const onToggle = jest.fn();
    render(<TaskItem task={sampleTask} onToggle={onToggle} onRemove={() => {}} />);
    const checkbox = screen.getByRole('checkbox');
    await userEvent.click(checkbox);
    expect(onToggle).toHaveBeenCalledWith(sampleTask.id);
  });

  test('can remove task', async () => {
    const onRemove = jest.fn();
    render(<TaskItem task={sampleTask} onToggle={() => {}} onRemove={onRemove} />);
    const button = screen.getByText(/remove/i);
    await userEvent.click(button);
    expect(onRemove).toHaveBeenCalledWith(sampleTask.id);
  });
});