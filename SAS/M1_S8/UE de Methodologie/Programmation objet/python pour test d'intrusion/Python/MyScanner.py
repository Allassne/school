import nmap

addr = input("Enter Target Adresse : ")
print("port range Ex: 20-443, or Single Port")
portrange = input("Enter port Range: ")

Portt = nmap.PortScanner()
Portt.scan(addr, portrange)
print(Portt.command_line())

for host in Portt.all_hosts():
    print("")
    print('Scanning in progress')
    print('Target Host : {} ({})'.format(host, Portt[host].hostname()))
    print('State : {}'.format(Portt[host].state()))
    for proto in Portt[host].all_protocols():
        print("")
        print('************')
        print('protocol : {}'.format(proto))

        lport = Portt[host][proto].keys()
        for port in lport:
            print('port : {}\tstate : {}'.format(port, Portt[host][proto][port]['state']))