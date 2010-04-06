From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Tue,  6 Apr 2010 10:42:12 -0700
Message-ID: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This series of davinci I2C driver updates and fixes is targetted for
2.6.35.  It has been tested in davinci git on multiple davinci SoCs.

Ben, since these changes are isolated to the davinci driver only, if
you prefer I can merge them upstream along with my davinci changes for
2.6.35.  

This series is based on v2.6.34-rc3

Chaithrika U S (4):
  i2c: davinci: misc. cleanups: remove MOD_REG_BIT and IO_ADDRESS usage
  i2c: davinci: Add helper functions for power management
  i2c: davinci: Add suspend/resume support
  i2c: davinci: Add cpufreq support

Dirk Behme (1):
  i2c: davinci: Fix smbus Oops with AIC33 usage

Philby John (1):
  i2c: davinci: bus recovery procedure to clear the bus

 drivers/i2c/busses/i2c-davinci.c |  314 ++++++++++++++++++++++++++++++--------
 1 files changed, 251 insertions(+), 63 deletions(-)
