
import pandas as pd

# Load the banking datasets
customers = pd.read_csv("dataset/customers.csv")
accounts = pd.read_csv("dataset/accounts.csv")
transactions = pd.read_csv("dataset/transactions.csv")
loans = pd.read_csv("dataset/loans.csv")
branches = pd.read_csv("dataset/branches.csv")

# Check the size of each dataset
datasets = {
    "Customers": customers,
    "Accounts": accounts,
    "Transactions": transactions,
    "Loans": loans,
    "Branches": branches
}

for name, df in datasets.items():
    print(f"\n{name} Dataset")
    print("-" * 40)
    print("Rows and Columns:", df.shape)
    print("Column Names:", list(df.columns))
    print("Missing Values:", df.isnull().sum().sum())

# Display a sample of customer records
print("\nCustomer Data Sample")
print(customers.head())

# Check transaction details
print("\nTransaction Data Sample")
print(transactions.head())

# Basic information about the datasets
print("\nCustomer Dataset Information")
customers.info()

print("\nTransaction Dataset Information")
transactions.info()
