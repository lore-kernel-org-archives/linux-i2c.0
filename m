From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/4] i2c: davinci: Add power management features
Date: Wed,  6 Jan 2010 14:54:56 +0530
Message-ID: <1262769900-2710-1-git-send-email-chaithrika@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add suspend/resume and cpufreq features to DaVinci I2C driver
All patches apply to Linus' kernel tree.
Testing of these features was done on DA850/OMAP-L138 EVM.

Chaithrika U S (4):
  i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
  i2c: davinci: Add helper functions
  i2c: davinci: Add suspend/resume support
  i2c: davinci: Add cpufreq support

 drivers/i2c/busses/i2c-davinci.c |  228 ++++++++++++++++++++++++++++---------
 1 files changed, 172 insertions(+), 56 deletions(-)

In this version, the suspend/resume support patch has been updated to
use dev_pm_ops.
