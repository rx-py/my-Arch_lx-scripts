#=======================================================
# ╔═╗╔╗╔╗     ╔══╗╔╗ ╔╗
# ║╔╝╚╬╬╝╔═══╗║╔╗║║║ ║║
# ║║ ╔╬╬╗╚═══╝║╚╝║║╚═╝║
# ╚╝ ╚╝╚╝     ║╔═╝╚═╗╔╝
#             ║║  ╔═╝║ 
#             ╚╝  ╚══╝ 
#
#  Author: rx-py
#  Github: github.com/rx-py
#
#=======================================================

# this script functions to display a simple network bandwith monitor showing 
# recieving and transmitting signals of a network.


import time
import psutil

def get_bytes(rx_old, tx_old):
    stats = psutil.net_io_counters()
    rx = stats.bytes_recv
    tx = stats.bytes_sent
    return rx - rx_old, tx - tx_old, rx, tx

def main():
    rx_old, tx_old, rx, tx = get_bytes(0, 0)
    
    print("Network Bandwidth Monitor")
    while True:
        time.sleep(1)  # Update every second
        rx_diff, tx_diff, rx, tx = get_bytes(rx, tx)
        
        rx_rate = round(rx_diff / 1024, 2)  # Receive rate in KB/s
        tx_rate = round(tx_diff / 1024, 2)  # Transmit rate in KB/s
        
        print(f"Received: {rx_rate} KB/s\tTransmitted: {tx_rate} KB/s")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nMonitoring stopped.")

