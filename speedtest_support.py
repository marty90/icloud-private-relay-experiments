import pyspeedtest
from datetime import datetime
import os
import csv
import json


def run_speedtest(is_pr):
    is_speedtest = False
    for i in range(5):
        try:
            speedtest_results = pyspeedtest.run_speedtest(browser="safari")
            is_speedtest = True
            break
        except:
            pass
    if not is_speedtest:
        print("Cannot run speedtest")
        exit(1)

    pr_str = "pr" if is_pr else "no_pr"
    RESULT_FILEPATH = os.path.join("speedtest_results", pr_str)
    if not os.path.exists(RESULT_FILEPATH):
            os.makedirs(RESULT_FILEPATH)
    filename = f"{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.csv"

    with open(os.path.join(RESULT_FILEPATH, filename), mode='w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=["ping_ms", "download_mbps", "upload_mbps", "organization", "server_ip", "sponsor", "city"])
            writer.writeheader()
            writer.writerow(speedtest_results)

    print(f"Run results saved in {os.path.join(RESULT_FILEPATH, filename)}")