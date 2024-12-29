
from configparser import ConfigParser
import os
import requests
import shutil
import sys
from zipfile import ZipFile

class DownloadError(Exception):
    def __init__(self, message, code=None):
        super().__init__(message)
        self.code = code

def _download_and_extract(file_url: str, extract_dir: str) -> bool:
    response = requests.get(file_url)
    LOCAL_FILE = "download.zip"

    if response.status_code == 200:
        with open(LOCAL_FILE, "wb") as f:
            f.write(response.content)
            print(f"{LOCAL_FILE} downloaded from {file_url}.")

        with ZipFile(LOCAL_FILE, "r") as z:
            z.extractall(extract_dir)
            print(f"{LOCAL_FILE} extracted to {extract_dir}.")

        os.remove(LOCAL_FILE)
    else:
        raise DownloadError(f"Failed to download {file_url}.", code=response.status_code)

def _failed(code: int):
    if (gh_env := os.getenv("GITHUB_OUTPUT")):
        with open(gh_env, "a") as f:
            f.write(f"exit_code={code}\n")

    sys.exit(code)

def download_shapefiles(selected_year=None):
    """
    Downloads shapefiles for a given year.

    Parameters:
    selected_year (optional): The year for which to download shapefiles.
        If None, uses the next year according to config.ini.
    """

    # get script directory
    script_dir = os.path.abspath(os.path.dirname(__file__))

    # get current configuration
    config_file = os.path.join(script_dir, "config.ini")
    config = ConfigParser()
    config.read(config_file)
    SECTION = "shapefiles"

    url_template = config.get(SECTION, "url")
    current_year = config.getint(SECTION, "current_year")
    entities = config.get(SECTION, "entities").split(",")
    res = config.get(SECTION, "res")

    if selected_year is None:
        year = current_year + 1
    else:
        year = selected_year
        
    if (gh_env := os.getenv("GITHUB_ENV")):
        with open(gh_env, "a") as f:
            f.write(f"shp_year={year}\n") 

    # create output directory
    extract_dir = os.path.join(script_dir, "..", "shapefiles", str(year))

    if os.path.exists(extract_dir):
        shutil.rmtree(extract_dir)
        shutil.os.makedirs(extract_dir)

    try:
        # attempt shapefile downloads
        for entity in entities:
            url = url_template.format(year=year, entity=entity, res=res)
            _download_and_extract(url, extract_dir)

            if (gh_env := os.getenv("GITHUB_ENV")):
                with open(gh_env, "a") as f:
                    f.write(f"{entity}_shp=cb_{year}_us_{entity}_{res}.shp\n")

        # update current year
        if selected_year is None:
            config.set(SECTION, "current_year", f"{year}")
            with open(config_file, "w") as f:
                config.write(f)
    except DownloadError as e:
        if e.code == 404:   # i.e. shapefiles not found
            print(f"The shapefiles for {year} were not found. Better luck next time!")
        else:               # other download errors
            print(e)

        _failed(e.code)
    except Exception as e:
        print(e)
        _failed(e.code)


if __name__ == "__main__":
    selected_year = sys.argv[1] if len(sys.argv) > 1 else None
    download_shapefiles(selected_year)
