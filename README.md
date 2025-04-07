# OmniAuth for Rails 8 Default Authentication

[![Ruby](https://img.shields.io/badge/Ruby-3.3.6-CC342D.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0.2-CC0000.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14.0+-336791.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC.svg)](https://tailwindcss.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

<p align="center">  
  <img src="https://github.com/user-attachments/assets/04ae00d6-19e7-4cf1-8d30-fea2ee7a7dd3" alt="Rails + Google OAuth" width="300">
</p>

## 🚀 Overview

This project demonstrates how to integrate Google OAuth authentication with Rails 8's new built-in basic authentication system. It provides a seamless way for users to sign in using either traditional email/password authentication or their Google account.

## ✨ Features

- Rails 8's built-in authentication system
- Google OAuth integration
- Avatar retrieval from Google account
- Responsive design with Tailwind CSS 4
- PostgreSQL database backend
- Modern, clean UI with simple user flow

## 📋 Requirements

- Ruby 3.3.6
- Rails 8.0.2
- PostgreSQL
- Node.js & Yarn (for Tailwind CSS)

## 🔧 Installation

1. Clone the repository:

```bash
git clone https://github.com/secretpray/Google-auth-for-Rails-8-Basic-auth.git
cd Google-auth-for-Rails-8-Basic-auth
```

2. Run the setup script:

```bash
bin/setup
```

3. Configure Google OAuth credentials:

   - Create a project in the [Google Cloud Console](https://console.cloud.google.com/)
   - Set up OAuth credentials for a web application
   - Add authorized redirect URIs (e.g., `http://localhost:3000/auth/google_oauth2/callback`)
   - Store your credentials in Rails credentials:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Add the following to your credentials file:

```yaml
google:
  client_id: your_google_client_id
  client_secret: your_google_client_secret
github:
  client_id: your_github_client_id
  client_secret: your_github_client_secret
```

## 🚦 Usage

Start the Rails server:

```bash
bin/dev
```

Visit `http://localhost:3000` in your browser and you'll see the sign-in page with both traditional and Google authentication options.

## 🧩 How It Works

This application extends Rails 8's built-in authentication system by adding OAuth capabilities:

- OmniAuth is used to handle the Google/Github authentications flow
- User records are created or retrieved based on the Google account email
- Profile information and avatars are pulled from Google when available
- The existing Rails 8 session management is utilized for authenticated users

## 📚 Key Files

- `app/models/user.rb` - Enhanced User model with Google auth support
- `app/controllers/oauth_callbacks_controller.rb` - Handles OAuth callback processing
- `config/initializers/omniauth.rb` - OmniAuth configuration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👏 Acknowledgements

- [Rails Team](https://rubyonrails.org/) for the new authentication generator in Rails 8
- [OmniAuth](https://github.com/omniauth/omniauth) for the flexible authentication framework
- [Tailwind CSS](https://tailwindcss.com/) for the utility-first CSS framework

