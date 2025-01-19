import { useState } from 'react';

function Notification() {
  const [type, setType] = useState<'success' | 'error' | 'warning' | 'info'>('success');
  const [message, setMessage] = useState('Your changes have been saved!');

  const typeStyles: { [key in 'success' | 'error' | 'warning' | 'info']: string } = {
    success: 'bg-white-600 text-black-700 border-black-400',
    error: 'bg-red-100 text-red-700 border-red-400',
    warning: 'bg-yellow-100 text-yellow-700 border-yellow-400',
    info: 'bg-blue-100 text-blue-700 border-blue-400',
  };

  return (
    <div
      className={`p-4 overflow-y-scroll scrollbar-custom mb-4 mt-8 text-sm border rounded-lg ${typeStyles[type]}`}
      role="alert"
    >
        <h2 className='text-2xl text-center text-black'>Notification</h2>
      {message}
    </div>
  );
}

export default Notification;
