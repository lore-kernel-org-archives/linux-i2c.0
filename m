From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.5
Date: Sun, 31 Jan 2016 01:06:02 +0100
Message-ID: <5b17b3b98683edd10719f474b68041b6@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59600 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162AbcAaAGF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 30 Jan 2016 19:06:05 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Linus,

here are two I2C driver regression fixes. piix4 gets a larger overhaul
fixing the latest refactoring and also an older known issue as well.
designware-pci gets a fix for a bad merge conflict resolution. Please
pull.

Thanks,

    Wolfram


The following changes since commit 
92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git 
i2c/for-current

for you to fetch changes up to 
52795f6fdeb8a2b98373108ac2838c674bb2cbc4:

   i2c: piix4: don't regress on bus names (2016-01-29 11:13:52 +0100)

----------------------------------------------------------------
Andy Shevchenko (1):
       i2c: designware-pci: use IRQF_COND_SUSPEND flag

Jean Delvare (3):
       i2c: piix4: Fix SB800 locking
       i2c: piix4: Fully initialize SB800 before it is registered
       i2c: piix4: don't regress on bus names

  drivers/i2c/busses/i2c-designware-core.c |  3 +-
  drivers/i2c/busses/i2c-piix4.c           | 50 
++++++++++++++------------------
  2 files changed, 23 insertions(+), 30 deletions(-)
