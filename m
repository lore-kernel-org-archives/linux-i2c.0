From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 0/6] davinci i2c updates for 2.6.34
Date: Tue, 26 Jan 2010 15:41:27 -0800
Message-ID: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This series ia a set of proposed I2C updates for the DaVinci platform
for 2.6.34.  These have been tested and approved as part of the
DaVinci tree.

Note that patch 6 has a dependency on changes to the DaVinci core so
is has been agreed to be merged it via davinci git.

Ben, upon successful review, please let me know if you'd like
me to merge the others via davinci git as well.

Thanks,

Kevin

Chaithrika U S (4):
  i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
  i2c: davinci: Add helper functions
  i2c: davinci: Add suspend/resume support
  i2c: davinci: Add cpufreq support

Dirk Behme (1):
  i2c: davinci: Fix smbus Oops with AIC33 usage

Philby John (1):
  i2c: davinci: bus recovery procedure to clear the bus

 drivers/i2c/busses/i2c-davinci.c |  312 ++++++++++++++++++++++++++++++--------
 1 files changed, 249 insertions(+), 63 deletions(-)
