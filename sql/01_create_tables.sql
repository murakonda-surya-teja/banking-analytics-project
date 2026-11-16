
IF DB_ID('BankingAnalyticsDB') IS NULL
BEGIN
    CREATE DATABASE BankingAnalyticsDB;
END;
GO

USE BankingAnalyticsDB;
GO

-- Customers
CREATE TABLE dbo.Customers (
    customer_id VARCHAR(20) NOT NULL PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender NVARCHAR(30),
    city NVARCHAR(100),
    state NVARCHAR(100),
    customer_segment NVARCHAR(50),
    occupation NVARCHAR(50),
    annual_income_inr DECIMAL(18,2),
    customer_since DATE,
    kyc_status NVARCHAR(30)
);
GO

-- Branches
CREATE TABLE dbo.Branches (
    branch_id VARCHAR(20) NOT NULL PRIMARY KEY,
    branch_name NVARCHAR(100) NOT NULL,
    city NVARCHAR(100),
    state NVARCHAR(100),
    branch_type NVARCHAR(30),
    opened_date DATE
);
GO

-- Accounts
CREATE TABLE dbo.Accounts (
    account_id VARCHAR(20) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(20) NOT NULL,
    account_type NVARCHAR(50),
    account_open_date DATE,
    account_status NVARCHAR(30),
    available_balance_inr DECIMAL(18,2),

    CONSTRAINT FK_Accounts_Customers
        FOREIGN KEY (customer_id)
        REFERENCES dbo.Customers(customer_id),

    CONSTRAINT FK_Accounts_Branches
        FOREIGN KEY (branch_id)
        REFERENCES dbo.Branches(branch_id),

    CONSTRAINT UQ_Accounts_Account_Customer
        UNIQUE (account_id, customer_id)
);
GO

-- Loans
CREATE TABLE dbo.Loans (
    loan_id VARCHAR(20) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    branch_id VARCHAR(20) NOT NULL,
    loan_type NVARCHAR(50),
    loan_amount_inr DECIMAL(18,2),
    interest_rate_pct DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    outstanding_amount_inr DECIMAL(18,2),
    days_past_due INT,
    loan_status NVARCHAR(30),

    CONSTRAINT FK_Loans_Customers
        FOREIGN KEY (customer_id)
        REFERENCES dbo.Customers(customer_id),

    CONSTRAINT FK_Loans_Branches
        FOREIGN KEY (branch_id)
        REFERENCES dbo.Branches(branch_id),

    CONSTRAINT CK_Loans_Amount
        CHECK (loan_amount_inr > 0),

    CONSTRAINT CK_Loans_Tenure
        CHECK (tenure_months > 0),

    CONSTRAINT CK_Loans_DaysPastDue
        CHECK (days_past_due >= 0)
);
GO

-- Transactions
CREATE TABLE dbo.Transactions (
    transaction_id VARCHAR(30) NOT NULL PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    transaction_date DATETIME2(0),
    transaction_type NVARCHAR(50),
    channel NVARCHAR(50),
    amount_inr DECIMAL(18,2),
    merchant_category NVARCHAR(100),
    transaction_status NVARCHAR(30),
    is_suspicious_flag BIT,

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (account_id, customer_id)
        REFERENCES dbo.Accounts(account_id, customer_id),

    CONSTRAINT CK_Transactions_Amount
        CHECK (amount_inr >= 0)
);
GO
