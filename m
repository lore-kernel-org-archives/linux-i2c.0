From: Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Tue, 25 Aug 2015 13:05:01 +0200
Message-ID: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org, galandilias-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an attempt to upstream the patches created by Thomas Brandon and
Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
chipset. (https://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg06757.html)

I have mainly rebased the latest patch version and tested the driver on a
HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor data
from a w83795adg).

The patched driver is running stable on the machine, given that ic2_piix4 is
loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
sensors triggers some errors:
    ERROR: Can't get value of subfeature temp1_min_alarm: Can't read

While the kernel log shows:
    i2c i2c-1: Transaction (pre): CNT=0c, CMD=05, ADD=31, DAT0=03, DAT1=c0
    i2c i2c-1: Error: no response!
    i2c i2c-1: Transaction (post): CNT=0c, CMD=05, ADD=31, DAT0=ff, DAT1=ff
Unfortunately I don't know how to tackle this specific issue.

Please review and let me know required changes in order to get this upstream
finally.

Eddi, Thomas, it would be great if you could verify the changes on your
machines.

Regards,
Christian

Christian Fetzer (4):
  i2c-piix4: Optionally release smba in piix4_adap_remove
  i2c-piix4: Convert piix4_main_adapter to array
  i2c-piix4: Add support for multiplexed main adapter in SB800
  i2c-piix4: Add adapter port name support for SB800 chipset

 drivers/i2c/busses/i2c-piix4.c | 151 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 134 insertions(+), 17 deletions(-)

-- 
1.9.1
