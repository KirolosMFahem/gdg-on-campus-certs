# Project Blueprint: Certificate Generator

## Overview

A React application to generate, verify, and manage digital certificates. The application will be secured with Google Authentication, ensuring that only authorized users can access the certificate generation features.

## Features

*   **Certificate Generation:** Users can generate PDF certificates with unique verification codes.
*   **Certificate Verification:** A public page allows anyone to verify the authenticity of a certificate using its ID.
*   **Google Authentication:** The application is protected, and only users logged in with their Google accounts can access the certificate generation functionality.
*   **Firebase Integration:** Firestore is used to store certificate data, and Firebase Authentication is used for user management.

## Current Plan

### Step 1: Initial Setup & Basic Structure

*   [x] Create `blueprint.md` file.
*   [ ] Install `firebase`, `react-router-dom`, `jspdf`, and `@mui/material`.
*   [ ] Configure Firebase and create `src/firebase.js`.
*   [ ] Set up basic routing in `src/App.jsx`.
*   [ ] Create placeholder components for `Login`, `Generate`, and `Verify`.
