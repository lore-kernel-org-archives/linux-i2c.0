From: John de la Garza <john-RXdYNANpVgkAvxtiuMwx3w@public.gmane.org>
Subject: i2c-dev not showing up on MacBookPro6,2
Date: Wed, 22 Oct 2014 13:35:18 -0400
Message-ID: <20141022173513.GA3140@vega.jjdev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I have my kernel built with dev-i2c and i2c_i801 but do not have
a /dev entry.

kernel ver:
Linux vega 3.18.0-rc1+ #71 SMP Wed Oct 22 00:49:21 EDT 2014 x86_64 GNU/Linux

lspci -nn  shows this:
00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset SMBus Controller [8086:3b30] (rev 06)

dmesg shows this:
[    1.566003] i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)

ls /sys/bus/i2c/devices/ shows nothing...

on running this on a MacBookPro6,2


What am I missing?  Shouldn't I see a i2c device?  I think SMBus is
a subset of i2c and I should be able to use that subset, right?
