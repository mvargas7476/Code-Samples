# Database Fill

Bulk-loads a MySQL database with realistic fake data — people, addresses, and jobs — so that queries can be run against a large, populated dataset for performance testing. Uses `Faker` and `names` to generate the data.

## Setup
```bash
python3 -m venv dbFill
source dbFill/bin/activate    # Windows: dbFill\Scripts\activate
pip3 install -r requirements.txt
```

## Configuration
Set your own MySQL connection details (host, user, password, database) at the top of each script before running — the committed values are blank placeholders. Then run `personFill.py`, `addressFill.py`, and `jobFill.py`.

## Libraries
PyMySQL · Faker · names
