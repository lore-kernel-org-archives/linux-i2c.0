From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v4 0/3] i2c-mpc: add support for the Freescale MPC512x and other fixes
Date: Thu, 28 Jan 2010 14:25:38 +0100
Message-ID: <1264685141-26391-1-git-send-email-wg@grandegger.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

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

Wolfgang

Wolfgang Grandegger (3):
  i2c-mpc: use __devinit[data] for initialization functions and data
  i2c-mpc: add support for the MPC512x processors from Freescale
  powerpc: doc/dts-bindings: update doc of FSL I2C bindings

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++-
 drivers/i2c/busses/Kconfig                     |    7 +-
 drivers/i2c/busses/i2c-mpc.c                   |  194 +++++++++++++++---------
 3 files changed, 148 insertions(+), 83 deletions(-)
