"""
Open a paper from Zotero using picker.

This script uses the local Zotero API. It requires:
- Zotero desktop app running
- Zotero API enabled in the settings

Only the user local database is accessed, so the options might not
always be synced with the remote Zotero library. For more information, see
https://www.zotero.org/support/dev/web_api/v3/local_api
"""

import subprocess
import sys
import webbrowser
import requests

API_URL = "http://localhost:23119/api/users/0/items"


# Fetch items from Zotero library
def fetch_items():
    try:
        params = {
            "limit": 200,
            "itemType": "journalArticle || book || conferencePaper || preprint",
        }
        response = requests.get(API_URL, params=params)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.ConnectionError:
        print("Error: Could not connect to Zotero. Ensure the desktop app is running.")
        sys.exit(1)


# Get PDF child key for some item key
def get_pdf_child_key(item_key):
    children_url = f"{API_URL}/{item_key}/children"
    try:
        response = requests.get(children_url)
        if response.status_code == 200:
            children = response.json()
            for child in children:
                data = child.get("data", {})
                if (
                    data.get("itemType") == "attachment"
                    and data.get("contentType") == "application/pdf"
                ):
                    return data.get("key")
    except Exception:
        pass
    return None


def main():
    items = fetch_items()

    option_to_key = {}
    options = []

    # Parse items and populate options for picking
    for item in items:
        data = item.get("data", {})
        title = data.get("title", "No Title").strip()
        date = data.get("date", "No Date")
        key = data.get("key", "")
        creators = data.get("creators", [])
        author = creators[0].get("lastName", "Unknown") if creators else "Unknown"

        display_str = f"{title} | {author} ({date}) [{key}]"
        option_to_key[display_str] = key
        options.append(display_str)

    if not options:
        return

    picker_process = subprocess.Popen(
        ["picker", "-prompt", "Select a paper:"],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        text=True,
    )

    selected_output, _ = picker_process.communicate(input="\n".join(options))

    # Open PDF
    if picker_process.returncode == 0 and selected_output.strip():
        selected_option = selected_output.strip()
        item_key = option_to_key.get(selected_option)

        if item_key:
            pdf_key = get_pdf_child_key(item_key)
            if pdf_key:
                webbrowser.open(f"zotero://open-pdf/library/items/{pdf_key}")


if __name__ == "__main__":
    main()
