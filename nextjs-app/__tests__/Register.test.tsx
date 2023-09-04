import Register from '../app/(public)/account/register/page';
import { render, screen } from '@testing-library/react';

jest.mock('next/navigation', () => ({
...require('next-router-mock'),
useSearchParams: () => [[{ revalidate: '1' }]],
}));

it('Register page has Register button', () => {
    render(<Register />)
    const element = screen.getByRole('heading', {level: 4});

    expect(element).toHaveTextContent('Register');
});