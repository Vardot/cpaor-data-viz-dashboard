import os
from typing import Any, Dict, Union

from data_sources_processing.utils import _get_hdx_data


def _get_acaps_inform_severity_data(
    datasets_metadata: Dict[str, Any], data_output_path: os.PathLike
) -> Union[Dict[str, Any], None]:
    """ACAPS Inform Severity data preparation function, calls the HDX API."""

    return _get_hdx_data(datasets_metadata, data_output_path, "acaps_inform_severity")
