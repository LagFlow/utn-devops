import Login from '../app/(public)/account/login/page';
import { render, screen } from '@testing-library/react';

jest.mock('next/navigation', () => ({
...require('next-router-mock'),
useSearchParams: () => [[{ revalidate: '1' }]],
}));

it('Login page has Login title', () => {
    render(<Login />)
    const element = screen.getByRole('heading', {level: 4});

    expect(element).toHaveTextContent('Login');
});