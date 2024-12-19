import nmap
from tqdm import tqdm
from colorama import Fore, Style, init
import time

# Initialize colorama
init(autoreset=True)

# Function to perform the scan based on user's choice
def perform_scan(addr, portrange, scan_type):
    Portt = nmap.PortScanner()
    scan_args = ''

    if scan_type == '1':
        scan_args = '-sS'
    elif scan_type == '2':
        scan_args = '-sU'
    elif scan_type == '3':
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
    addr = input("Enter Target Address: ")
    print("Port range Ex: 20-443, or Single Port")
    portrange = input("Enter Port Range: ")

    print("\nChoose scan type:")
    print("1) SYN Scan")
    print("2) UDP Scan")
    print("3) ACK Scan")
    print("4) Normal Scan")
    scan_type = input("Enter your choice (1/2/3/4): ")

    Portt = perform_scan(addr, portrange, scan_type)
    display_results(Portt)

if __name__ == "__main__":
    main()
