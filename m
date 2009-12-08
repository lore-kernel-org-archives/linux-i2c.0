From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] i2c: davinci: Add power management features
Date: Tue,  8 Dec 2009 15:43:34 +0530
Message-ID: <1260267218-19406-1-git-send-email-chaithrika@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add suspend/resume and cpufreq features to DaVinci I2C driver
All patches apply to Linus' kernel tree.
Testing of these features was done on DA850/OMAP-L138 EVM.

Chaithrika U S (4):
  i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
  i2c: davinci: Add helper functions
  i2c: davinci: Add suspend/resume support
  i2c: davinci: Add cpufreq support

 drivers/i2c/busses/i2c-davinci.c |  224 ++++++++++++++++++++++++++++----------
 1 files changed, 168 insertions(+), 56 deletions(-)
