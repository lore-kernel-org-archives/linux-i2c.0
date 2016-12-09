From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/4] i2c octeon & thunderx bug fixes
Date: Fri,  9 Dec 2016 10:31:54 +0100
Message-ID: <20161209093158.3161-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32976 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932360AbcLIJc2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Dec 2016 04:32:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so2763959wmu.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Dec 2016 01:32:27 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

Patches #1 & #2 contain the fixes that didn't make 4.9.
We've double-checked that they are working on Octeon MIPS cn71xx,
so I hope there are no surprises this time.

Patch #3 is my original attempt on limiting the number of
retries for the i2c device register access. As I found out we
need to keep this simple, because these functions are called
very early in the i2c driver and also from all types of context.

Patch #4 addresses a bug report I got. I haven't seen this myself,
but apparently depending on probing method and/or hardware type
ipmi_ssif can fail to detect the IPMI device. Setting the class
in the adapter solves the problem and seems harmless.

Tested on MIPS Octeon CN71xx and ARM64 ThunderX on 4.9-rc8.

thanks,
Jan

-----------------------

Jan Glauber (4):
  i2c: octeon: thunderx: TWSI software reset in recovery
  i2c: octeon: thunderx: Remove double-check after interrupt
  i2c: octeon: thunderx: Limit register access retries
  i2c: octeon: thunderx: Add I2C_CLASS_HWMON

 drivers/i2c/busses/i2c-octeon-core.c     | 50 +++++---------------------------
 drivers/i2c/busses/i2c-octeon-core.h     | 21 ++++++++++----
 drivers/i2c/busses/i2c-octeon-platdrv.c  |  1 +
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |  1 +
 4 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.9.0.rc0.21.g7777322
