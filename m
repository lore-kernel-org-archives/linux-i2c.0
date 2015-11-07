From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v3 0/5] Support multiplexed main SMBus interface on SB800
Date: Sat,  7 Nov 2015 12:35:21 +0100
Message-ID: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38760 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbKGLfh (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 Nov 2015 06:35:37 -0500
Received: by wmec201 with SMTP id c201so36792166wme.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2015 03:35:36 -0800 (PST)
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

v3:
- Incorporated changes requested by Mika and Andy
    - main adapter name set to 'main'
    - defined constant idx address
    - block comment style, joined string literals, reworked for loops
      into while loops

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

 drivers/i2c/busses/i2c-piix4.c | 177 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 149 insertions(+), 28 deletions(-)

-- 
1.9.1
