From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/i2c-2635 tree
Date: Thu, 20 May 2010 00:23:27 +0100
Message-ID: <20100519232327.GA5024@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Please pull the following tree:

The following changes since commit 024a6b95181f2df6090975c8a293499d24bf=
8b28:
  Linus Torvalds (1):
        Merge branch 'davinci-for-linus' of git://git.kernel.org/.../kh=
ilman/linux-davinci

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c-2635

Alexander Shishkin (2):
      omap: i2c: make errata 1.153 workaround a separate function
      omap: i2c: add a timeout to the busy waiting

Kalle Jokiniemi (1):
      i2c-omap: add mpu wake up latency constraint in i2c

Mark Brown (1):
      i2c-s3c2410: Remove unconditional 1ms delay on each transfer

Michael Hennerich (1):
      i2c-bfin-twi: add debug output for error status

Rabin Vincent (2):
      i2c-nomadik: release region when removed
      i2c-nomadik: fix operator precedence warning

Santosh Shilimkar (1):
      omap: i2c: Add i2c support on omap4 platform

Sonic Zhang (4):
      i2c-bfin-twi: integrate timeout timer with completion interface
      i2c-bfin-twi: fix lost interrupts at high speeds
      i2c-bfin-twi: remove redundant retry
      i2c-bfin-twi: return completion in interrupt for smbus quick tran=
sfers

Uwe Kleine-K=C3=B6nig (2):
      i2c-pxa: remove unused macro
      MAINTAINERS: add i2c tree for embedded platforms

Wolfram Sang (5):
      i2c-pxa: only define 'blue_murder'-function if DEBUG is #defined
      i2c-mpc: drop NO_IRQ
      i2c-cpm: drop NO_IRQ
      i2c-ibm-iic: drop NO_IRQ
      i2c-highlander: remover superflous variable

manjugk manjugk (2):
      OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
      OMAP3: I2C: Clean up Errata 1p153 handling

 MAINTAINERS                         |    1 +
 arch/arm/plat-omap/i2c.c            |   39 ++++--
 drivers/i2c/busses/i2c-bfin-twi.c   |  168 ++++++++++------------
 drivers/i2c/busses/i2c-cpm.c        |    2 +-
 drivers/i2c/busses/i2c-highlander.c |    5 +-
 drivers/i2c/busses/i2c-ibm_iic.c    |   14 +-
 drivers/i2c/busses/i2c-mpc.c        |    6 +-
 drivers/i2c/busses/i2c-nomadik.c    |    6 +-
 drivers/i2c/busses/i2c-omap.c       |  265 +++++++++++++++++++++++++++=
-------
 drivers/i2c/busses/i2c-pxa.c        |   26 ++--
 drivers/i2c/busses/i2c-s3c2410.c    |   19 +++-
 include/linux/i2c-omap.h            |    9 ++
 12 files changed, 374 insertions(+), 186 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

--=20
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
