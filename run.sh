#!/bin/bash

echo "Creating Flutter MVVM Register Module Structure..."

# Create directories
mkdir -p lib/core/api
mkdir -p lib/core/utils
mkdir -p lib/core/widgets
mkdir -p lib/core/storage

mkdir -p lib/models/register

mkdir -p lib/services

mkdir -p lib/repositories

mkdir -p lib/viewmodels

mkdir -p lib/views/auth

# Create API files
touch lib/core/api/api_constants.dart
touch lib/core/api/api_client.dart
touch lib/core/api/api_exception.dart

# Create Utility files
touch lib/core/utils/validators.dart

# Create Widget files
touch lib/core/widgets/custom_button.dart
touch lib/core/widgets/custom_textfield.dart
touch lib/core/widgets/custom_loader.dart
touch lib/core/widgets/custom_snackbar.dart

# Create Storage files
touch lib/core/storage/shared_pref.dart

# Create Model files
touch lib/models/register/register_request.dart
touch lib/models/register/register_response.dart

# Create Service
touch lib/services/register_service.dart

# Create Repository
touch lib/repositories/register_repository.dart

# Create ViewModel
touch lib/viewmodels/register_viewmodel.dart

# Create Screens
touch lib/views/auth/signup_screen.dart
touch lib/views/auth/verify_email_screen.dart

echo "=========================================="
echo "Flutter Register MVVM Structure Created!"
echo "=========================================="

tree lib