From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: bjdooks' git - current state of i2c-next
Date: Wed, 3 Feb 2010 02:39:02 +0000
Message-ID: <20100203023902.GA2794@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Current state of next-i2c branch, which should be the start
of the next merge window pull as long as there are no objections

The following changes since commit 1a45dcfe2525e9432cb4aba461d4994fc2be=
fe42:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Jean-Hugues Deschenes (3):
      i2c-designware: Use local version of readl & writel
      i2c-designware: Check component type register
      i2c-designware: Allow mixed endianness accesses

Richard R=F6jfors (1):
      i2c: Add support for Xilinx XPS IIC Bus Interface

Uwe Kleine-K=F6nig (1):
      i2c/imx: don't add probe function to the driver struct

Wolfgang Grandegger (3):
      i2c-mpc: use __devinit[data] for initialization functions and dat=
a
      i2c-mpc: add support for the MPC512x processors from Freescale
      powerpc: doc/dts-bindings: update doc of FSL I2C bindings

srinidhi kasagar (1):
      i2c: Add support for Ux500/Nomadik I2C controller

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +-
 drivers/i2c/busses/Kconfig                     |   24 +-
 drivers/i2c/busses/Makefile                    |    2 +
 drivers/i2c/busses/i2c-designware.c            |  116 ++-
 drivers/i2c/busses/i2c-imx.c                   |    1 -
 drivers/i2c/busses/i2c-mpc.c                   |  198 +++--
 drivers/i2c/busses/i2c-nomadik.c               |  959 ++++++++++++++++=
++++++++
 drivers/i2c/busses/i2c-xiic.c                  |  823 ++++++++++++++++=
++++
 include/linux/i2c-xiic.h                       |   43 ++
 9 files changed, 2068 insertions(+), 128 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-nomadik.c
 create mode 100644 drivers/i2c/busses/i2c-xiic.c
 create mode 100644 include/linux/i2c-xiic.h

--=20
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
