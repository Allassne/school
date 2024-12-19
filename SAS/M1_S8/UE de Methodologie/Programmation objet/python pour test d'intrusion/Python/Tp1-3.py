import nmap
import time
import pandas as pd
import matplotlib.pyplot as plt
from openpyxl import Workbook

def perform_scan(addr, portrange):
    Portt = nmap.PortScanner()
    scan_args = '-sS'  # SYN Scan
    Portt.scan(addr, portrange, arguments=scan_args)
    open_ports = 0

    for host in Portt.all_hosts():
        for proto in Portt[host].all_protocols():
            lport = Portt[host][proto].keys()
            for port in lport:
                if Portt[host][proto][port]['state'] == 'open':
                    open_ports += 1

    return open_ports

def main():
    addr = "192.168.71.129"
    portrange = "20-500"
    scan_interval = 2 * 60  # 2 minutes in seconds
    total_duration = 10 * 60  # 10 minutes in seconds
    scan_count = total_duration // scan_interval

    open_ports_data = []

    for i in range(scan_count):
        open_ports = perform_scan(addr, portrange)
        print(f"Scan {i + 1}: {open_ports} open ports")
        open_ports_data.append(open_ports)
        if i < scan_count - 1:  # To avoid sleeping after the last scan
            time.sleep(scan_interval)

    # Save results to an Excel file
    df = pd.DataFrame({'Scan': list(range(1, scan_count + 1)), 'Open Ports': open_ports_data})
    df.to_excel("port_scan_results.xlsx", index=False)

    # Plot the data
    plt.plot(df['Scan'], df['Open Ports'], marker='o')
    plt.title('Number of Open Ports Over Time')
    plt.xlabel('Scan Number')
    plt.ylabel('Number of Open Ports')
    plt.grid(True)
    plt.savefig("port_scan_results.png")
    plt.show()

if __name__ == "__main__":
    main()
