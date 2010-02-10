From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v6 0/4] i2c-mpc: add support for the Freescale MPC512x and other fixes
Date: Wed, 10 Feb 2010 11:05:26 +0100
Message-ID: <1265796330-15976-1-git-send-email-wg@grandegger.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

This patch series adds support for the MPC512x from Freescale to the
i2c-mpc driver. At that occasion, issues with  __devinit[data] have
been fixed and the doc of the FSL I2C dts bindings updated. It has
been tested on a MPC5121ADS, TQM5200 and TQM8560 board

Changes since v1:

- use macro MPC_I2C_CLOCK_PRESERVE/SAFE for the special clock settings.
- document the special DTS node "fsl,mpc5121-i2c-ctrl".
- update and correct the Kconfig help.
- some other minor fixes as suggested by Wolfram.

Changes since v2:

- use __init[data] instead of __devinit[data] for this driver.

Changes since v3:

- switch back to __devinit[data] as pointed out by Ben.

Changes since v4:

- check MPC_I2C_CLOCK_SAFE instead of "!clock" as suggested by Wolfram.
- update MODULE_DESCRIPTION().

Changes since v5 (suggested by Grant Likely):

- various correctings for labling initialization functions and data
  (this is tricky because section mismatches are not always obvious).
- add a separate patch for renaming the setclock into setup functions.
- correct the doc of the I2C bindings, e.g. don't mention the legacy
  clock setting and remove obsolte parts.

Wolfgang

Wolfgang Grandegger (4):
  i2c-mpc: use __devinit[data] for initialization functions and data
  i2c-mpc: rename "setclock" initialization functions to "setup"
  i2c-mpc: add support for the MPC512x processors from Freescale
  powerpc: doc/dts-bindings: update doc of FSL I2C bindings

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++-
 drivers/i2c/busses/Kconfig                     |    7 +-
 drivers/i2c/busses/i2c-mpc.c                   |  194 +++++++++++++++---------
 3 files changed, 146 insertions(+), 85 deletions(-)
