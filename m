From: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Subject: Decode dimms on dual socket machines
Date: Tue, 12 Apr 2011 12:10:18 +0200
Message-ID: <4DA4250A.3060907@fuckner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I have a Dual-Socket Machine with Supermicro Motherboard (X8DTH-iF) and 
I'd like to use decode-dimms, but it just decodes the modules on one 
socket (dmidecode -t 17 and ipmitool sdr show all 6 modules on both 
sockets).


Does anybody have a clue how to access those other 3 modules?

Regards,
  Michael!


this is what I can see right now:
test24:/media/i2c-tools # ./tools/i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- UU -- UU -- UU -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e 2f
30: 30 -- 32 -- 34 -- -- -- -- -- -- -- -- -- 3e --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: UU -- UU -- UU -- -- -- -- -- -- -- -- -- -- --
60: -- 61 62 -- -- -- -- -- -- 69 -- -- -- -- -- --
70: 70 -- -- -- -- -- -- --

18,1a,1c: jc42 temperature sensors
50,52,54: eeproms


test24:~ # ll /sys/bus/i2c/devices/
total 0
lrwxrwxrwx 1 root root 0 Apr 10 13:45 0-0018 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0018
lrwxrwxrwx 1 root root 0 Apr 10 13:45 0-001a -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-001a
lrwxrwxrwx 1 root root 0 Apr 10 13:45 0-001c -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-001c
lrwxrwxrwx 1 root root 0 Apr 10 13:48 0-0050 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050
lrwxrwxrwx 1 root root 0 Apr 10 13:48 0-0052 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0052
lrwxrwxrwx 1 root root 0 Apr 10 13:48 0-0054 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0054
lrwxrwxrwx 1 root root 0 Apr  7 17:12 i2c-0 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0
