import nmap
from tqdm import tqdm
from colorama import Fore, Style, init
import time
import argparse

# Initialize colorama
init(autoreset=True)

def perform_scan(addr, portrange, scan_type):
    Portt = nmap.PortScanner()
    scan_args = ''

    if scan_type == 'syn':
        scan_args = '-sS'
    elif scan_type == 'udp':
        scan_args = '-sU'
    elif scan_type == 'ack':
        scan_args = '-sA'
    else:
        scan_args = ''

    print(f"{Fore.CYAN}Scanning in progress...{Style.RESET_ALL}")
    Portt.scan(addr, portrange, arguments=scan_args)

    # Simulate progress bar
    for _ in tqdm(range(100), desc="Scanning Progress", ascii=False, ncols=75):
        time.sleep(0.05)  # This is just for simulation

    print(f"{Fore.GREEN}Scan complete!{Style.RESET_ALL}")
    return Portt

def display_results(Portt):
    for host in Portt.all_hosts():
        print(f"\n{Fore.YELLOW}Target Host : {host} ({Portt[host].hostname()}){Style.RESET_ALL}")
        print(f"{Fore.YELLOW}State : {Portt[host].state()}{Style.RESET_ALL}")
        for proto in Portt[host].all_protocols():
            print(f"\n{Fore.CYAN}Protocol : {proto}{Style.RESET_ALL}")

            lport = Portt[host][proto].keys()
            for port in lport:
                state = Portt[host][proto][port]['state']
                color = Fore.GREEN if state == 'open' else Fore.RED if state == 'closed' else Fore.YELLOW
                print(f"Port : {port}\tState : {color}{state}{Style.RESET_ALL}")

def main():
    parser = argparse.ArgumentParser(description="Network Port Scanner")
    parser.add_argument("addr", help="Target address (IP or domain)")
    parser.add_argument("portrange", help="Port range (e.g., 20-443 or single port)")
    parser.add_argument("scan_type", choices=['1', '2', '3', '4'], help="Type of scan: 1 (syn), 2 (udp), 3 (ack), 4 (normal)")

    args = parser.parse_args()

    scan_types = {'1': 'syn', '2': 'udp', '3': 'ack', '4': 'normal'}
    scan_type = scan_types[args.scan_type]

    Portt = perform_scan(args.addr, args.portrange, scan_type)
    display_results(Portt)

if __name__ == "__main__":
    main()
