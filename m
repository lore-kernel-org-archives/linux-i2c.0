From: Puneet Shenoy <puneet-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: ismt-bus completion wait timed out issue
Date: Thu, 12 Jun 2014 11:29:02 -0700
Message-ID: <98891F48-98F3-4E03-B4F7-1B366C602B85@cumulusnetworks.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shrijeet Mukherjee <shm-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey Bill,

I see that you are the author of the i2c-ismt driver so thought will ch=
eck with you on a issue that I have been seeing on my setup.

My setup has an Intel Atom S1220 Processor which has a PMBUS device on =
its SMBUS 2.0 controller (SMBus=97Bus 0:D19:F0-1).=20

Now while accessing(read/write) the PMBUS device, I see the following e=
rror messages:
[10799.333083] ismt_smbus 0000:00:13.1: completion wait timed out
[10800.337089] ismt_smbus 0000:00:13.1: completion wait timed out
[10801.341097] ismt_smbus 0000:00:13.1: completion wait timed out
[10802.345105] ismt_smbus 0000:00:13.1: completion wait timed out

All read/write access to the device fail when its in this state. The is=
sue is hard to reproduce and happens once in a while.

I tried rmmod/modprobe the driver, but that doesn't help. I dumped the =
relevant registers that are dev_dbg'ed in the driver and compared the d=
ata between the failed and working cases and I don't see any difference=
=2E=20
Once in a while when I am in the failed state, I see the In Progress Bi=
t (Bit 0) in the MSTS (Master Status Register) being set but its not al=
ways the case.

Have you seen this issue before ? Any pointers on how to debug this ?

Appreciate any help.
Thanks
Puneet--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
