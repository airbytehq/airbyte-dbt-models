def extract_connector_name(file_path):
    connector_names = set()
    with open(file_path, "r") as file:
        for line in file:
            line = line.strip()
            if line.startswith("connectors/"):
                parts = line.split("/")
                if len(parts) > 1:
                    connector_names.add(parts[1])
    if len(connector_names) == 0:
        raise ValueError("No connector name found in the file.")
    elif len(connector_names) > 1:
        raise ValueError("Multiple connector names found in the file.")

    return connector_names


# Example usage:
file_path = "changed_files.txt"
try:
    connector_name = extract_connector_name(file_path)
    print(f"::set-output name=connector::{next(iter(connector_name))}")
except Exception as e:
    print(e)
    print("::set-output name=connector::not-found")
