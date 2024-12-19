import argparse
import nmap
from colorama import Fore, Style, init

# Initialisation de colorama
init(autoreset=True)

def perform_scan(target, port_range, scan_type):
    nm = nmap.PortScanner()

    scan_methods = {
        "1": "-sS",  # SYN Scan
        "2": "-sU",  # UDP Scan
        "3": "-sA",  # ACK Scan
        "4": "-sT"   # Normal Scan (TCP Connect)
    }

    scan_option = scan_methods.get(scan_type, "")
    
    print(f"Running {scan_option} scan on {target} for ports {port_range}")
    nm.scan(target, port_range, arguments=scan_option)
    
    results = []
    for proto in nm[target].all_protocols():
        lport = nm[target][proto].keys()
        for port in lport:
            state = nm[target][proto][port]['state']
            results.append((port, state, proto.upper()))

    return results

def main():
    parser = argparse.ArgumentParser(description="Port Scanner using nmap")
    parser.add_argument("target", help="Target IP address")
    parser.add_argument("start_port", type=int, help="Start of port range")
    parser.add_argument("end_port", type=int, help="End of port range")
    parser.add_argument("scan_type", choices=["1", "2", "3", "4"], help="Type of scan: 1) SYN Scan; 2) UDP Scan; 3) ACK Scan; 4) Normal Scan")

    args = parser.parse_args()

    target = args.target
    port_range = f"{args.start_port}-{args.end_port}"
    scan_type = args.scan_type

    results = perform_scan(target, port_range, scan_type)

    if not results:
        print("No open ports found.")
    for port, status, proto in results:
        color = Fore.GREEN if status == "open" else Fore.RED
        print(f"{color}Port {port} ({proto}) : {status}")

if __name__ == "__main__":
    main()
