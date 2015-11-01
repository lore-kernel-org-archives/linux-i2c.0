From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 0/5] Support multiplexed main SMBus interface on SB80
Date: Sun,  1 Nov 2015 17:32:04 +0100
Message-ID: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34661 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKAQcr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:32:47 -0500
Received: by wikq8 with SMTP id q8so37833943wik.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:32:46 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

This is an attempt to upstream the patches created by Thomas Brandon and
Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757.html)

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

v2:
- Incorporated changes requested by Mika
    - remove adapter in reverse order
    - ERROR label
    - request base address index region only once

Christian Fetzer (5):
  i2c-piix4: Optionally release smba in piix4_adap_remove
  i2c-piix4: Convert piix4_main_adapter to array
  i2c-piix4: Request base address index region once for SB800
  i2c-piix4: Add support for multiplexed main adapter in SB800
  i2c-piix4: Add adapter port name support for SB800 chipset

 drivers/i2c/busses/i2c-piix4.c | 172 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 144 insertions(+), 28 deletions(-)

-- 
1.9.1
