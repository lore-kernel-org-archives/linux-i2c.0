From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] pull request for bjdooks' for-linus/i2c tree
Date: Sun, 7 Mar 2010 22:36:36 +0000
Message-ID: <20100307223636.GA27170@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 08b8499bdd26822df16f962db88215d02e40=
850a:
  Linus Torvalds (1):
        Merge branch 'next' of git://git.kernel.org/.../davej/cpufreq

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c

Ben Dooks (3):
      Merge branch 'next-i2c-mpc-v8' into next-i2c
      Merge branch 'next-i2c-omap' into next-i2c
      Merge branch 'next-i2c-xilinx' into next-i2c

Cory Maccarrone (1):
      i2c: omap: Add support for 16-bit registers

Luotao Fu (1):
      i2c-pnx: fix setting start/stop condition

Richard R=F6jfors (1):
      i2c: Add support for Xilinx XPS IIC Bus Interface

Uwe Kleine-K=F6nig (1):
      i2c/imx: don't add probe function to the driver struct

Wolfgang Grandegger (4):
      i2c-mpc: use __devinit[data] for initialization functions and dat=
a
      i2c-mpc: rename "setclock" initialization functions to "setup"
      i2c-mpc: add support for the MPC512x processors from Freescale
      powerpc: doc/dts-bindings: update doc of FSL I2C bindings

srinidhi kasagar (1):
      i2c: Add support for Ux500/Nomadik I2C controller

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +-
 drivers/i2c/busses/Kconfig                     |   24 +-
 drivers/i2c/busses/Makefile                    |    2 +
 drivers/i2c/busses/i2c-imx.c                   |    1 -
 drivers/i2c/busses/i2c-mpc.c                   |  194 +++--
 drivers/i2c/busses/i2c-nomadik.c               |  959 ++++++++++++++++=
++++++++
 drivers/i2c/busses/i2c-omap.c                  |   44 +-
 drivers/i2c/busses/i2c-pnx.c                   |   11 -
 drivers/i2c/busses/i2c-xiic.c                  |  824 ++++++++++++++++=
++++
 9 files changed, 1973 insertions(+), 116 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-nomadik.c
 create mode 100644 drivers/i2c/busses/i2c-xiic.c

--=20
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
