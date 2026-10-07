-- ==============================================================================
-- National Identity Document Issuing System (NIDIS)
-- Database Setup and Mock Seed Script for Microsoft SQL Server
-- ==============================================================================

-- 1. Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'NIDIS_DB')
BEGIN
    CREATE DATABASE NIDIS_DB;
    PRINT 'Database NIDIS_DB created successfully.';
END
GO

USE NIDIS_DB;
GO

-- 2. Drop Tables if they exist (in proper reverse dependency order)
IF OBJECT_ID('dbo.audit_logs', 'U') IS NOT NULL DROP TABLE dbo.audit_logs;
IF OBJECT_ID('dbo.notifications', 'U') IS NOT NULL DROP TABLE dbo.notifications;
IF OBJECT_ID('dbo.payment_transactions', 'U') IS NOT NULL DROP TABLE dbo.payment_transactions;
IF OBJECT_ID('dbo.application_documents', 'U') IS NOT NULL DROP TABLE dbo.application_documents;
IF OBJECT_ID('dbo.passport_applications', 'U') IS NOT NULL DROP TABLE dbo.passport_applications;
IF OBJECT_ID('dbo.license_applications', 'U') IS NOT NULL DROP TABLE dbo.license_applications;
IF OBJECT_ID('dbo.nic_applications', 'U') IS NOT NULL DROP TABLE dbo.nic_applications;
IF OBJECT_ID('dbo.otp_tokens', 'U') IS NOT NULL DROP TABLE dbo.otp_tokens;
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL DROP TABLE dbo.users;
IF OBJECT_ID('dbo.roles', 'U') IS NOT NULL DROP TABLE dbo.roles;
GO

-- 3. Create Roles Table
CREATE TABLE dbo.roles (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE,
    description NVARCHAR(255) NULL
);
GO

-- 4. Create Users Table
CREATE TABLE dbo.users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(150) NOT NULL,
    phone_number NVARCHAR(20) NULL,
    role_id BIGINT NOT NULL,
    is_enabled BIT NOT NULL DEFAULT 1,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2 NULL,
    CONSTRAINT FK_Users_Role FOREIGN KEY (role_id) REFERENCES dbo.roles(id)
);
GO

-- 5. Create OTP Tokens Table
CREATE TABLE dbo.otp_tokens (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    token NVARCHAR(10) NOT NULL,
    user_id BIGINT NOT NULL,
    otp_type NVARCHAR(50) NOT NULL,
    expiration_time DATETIME2 NOT NULL,
    is_used BIT NOT NULL DEFAULT 0,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_OtpTokens_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 6. Create NIC Applications Table
CREATE TABLE dbo.nic_applications (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    application_number NVARCHAR(64) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    application_type NVARCHAR(50) NOT NULL,
    application_category NVARCHAR(50) NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
    full_name NVARCHAR(150) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender NVARCHAR(20) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    occupation NVARCHAR(100) NULL,
    remarks NVARCHAR(500) NULL,
    document_number NVARCHAR(50) NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2 NULL,
    CONSTRAINT FK_NicApplications_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 7. Create License Applications Table
CREATE TABLE dbo.license_applications (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    application_number NVARCHAR(64) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    application_type NVARCHAR(50) NOT NULL,
    application_category NVARCHAR(50) NOT NULL,
    vehicle_classes NVARCHAR(100) NOT NULL,
    blood_group NVARCHAR(10) NULL,
    current_license_no NVARCHAR(50) NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
    full_name NVARCHAR(150) NOT NULL,
    remarks NVARCHAR(500) NULL,
    document_number NVARCHAR(50) NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2 NULL,
    CONSTRAINT FK_LicenseApplications_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 8. Create Passport Applications Table
CREATE TABLE dbo.passport_applications (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    application_number NVARCHAR(64) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    application_type NVARCHAR(50) NOT NULL,
    application_category NVARCHAR(50) NOT NULL,
    travel_document_type NVARCHAR(50) NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
    full_name NVARCHAR(150) NOT NULL,
    date_of_birth DATE NOT NULL,
    nationality NVARCHAR(50) NOT NULL,
    remarks NVARCHAR(500) NULL,
    document_number NVARCHAR(50) NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2 NULL,
    CONSTRAINT FK_PassportApplications_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 9. Create Application Documents Table
CREATE TABLE dbo.application_documents (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    document_type NVARCHAR(100) NOT NULL,
    file_name NVARCHAR(255) NOT NULL,
    file_path NVARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    content_type NVARCHAR(100) NOT NULL,
    application_type NVARCHAR(50) NOT NULL,
    application_id BIGINT NOT NULL,
    uploaded_at DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO

-- 10. Create Payment Transactions Table
CREATE TABLE dbo.payment_transactions (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    transaction_ref NVARCHAR(64) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    application_type NVARCHAR(50) NOT NULL,
    application_id BIGINT NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    currency NVARCHAR(10) NOT NULL DEFAULT 'LKR',
    payment_status NVARCHAR(50) NOT NULL DEFAULT 'PENDING',
    payment_method NVARCHAR(50) NOT NULL,
    paid_at DATETIME2 NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 11. Create Notifications Table
CREATE TABLE dbo.notifications (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title NVARCHAR(150) NOT NULL,
    message NVARCHAR(1000) NOT NULL,
    is_read BIT NOT NULL DEFAULT 0,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Notifications_User FOREIGN KEY (user_id) REFERENCES dbo.users(id)
);
GO

-- 12. Create Audit Logs Table
CREATE TABLE dbo.audit_logs (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NULL,
    action NVARCHAR(100) NOT NULL,
    entity_name NVARCHAR(100) NOT NULL,
    entity_id BIGINT NULL,
    details NVARCHAR(1000) NULL,
    ip_address NVARCHAR(50) NULL,
    timestamp DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO

-- 13. Seed Mock Data
-- Roles
INSERT INTO dbo.roles (name, description) VALUES
('ROLE_ADMIN', 'System Administrator with full access'),
('ROLE_OFFICER', 'Verification Officer for document application review'),
('ROLE_CITIZEN', 'Citizen user applying for identity documents');

-- Default Users (Password: Admin@123 / Officer@123 / Citizen@123 - bcrypt hash placeholder: $2a$10$wK1m... or standard)
INSERT INTO dbo.users (username, email, password, full_name, phone_number, role_id, is_enabled) VALUES
('admin', 'admin@nidis.gov', '$2a$10$7EqJtq98hPqEX7fNZaFWoO.8H7H7OQv1jJ1dF6S9Z2cW7IeX3mK.C', 'NIDIS System Administrator', '+94112000001', 1, 1),
('officer', 'officer@nidis.gov', '$2a$10$7EqJtq98hPqEX7fNZaFWoO.8H7H7OQv1jJ1dF6S9Z2cW7IeX3mK.C', 'Senior Verification Officer', '+94112000002', 2, 1),
('citizen', 'citizen@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoO.8H7H7OQv1jJ1dF6S9Z2cW7IeX3mK.C', 'Johnathan Doe', '+94771234567', 3, 1);

PRINT 'Database setup and initial seed data inserted successfully.';
GO
