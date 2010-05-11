From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: bjdooks' i2c-next
Date: Wed, 12 May 2010 00:20:39 +0100
Message-ID: <20100511232039.GA32733@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here's the current contents of my i2c-next. All branches are
on http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=summary

Let me know if there is anything that has been missed.

Sorry about the delay, adjusting to +8 timezone hasn't been easy.

The following changes since commit fc2a093e7ad23e935aa29e349bc27173c92f1a95:
  Linus Torvalds (1):
        Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Alexander Shishkin (2):
      omap: i2c: make errata 1.153 workaround a separate function
      omap: i2c: add a timeout to the busy waiting

Ben Dooks (3):
      ARM: Merge for-2635/i2c-nomadik
      ARM: Merge for-2635/i2c-omap
      ARM: Merge for-2635/i2c-samsung

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
      i2c-bfin-twi: return completion in interrupt for smbus quick transfers

manjugk manjugk (2):
      OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
      OMAP3: I2C: Clean up Errata 1p153 handling

 arch/arm/plat-omap/i2c.c          |   39 ++++--
 drivers/i2c/busses/i2c-bfin-twi.c |  168 +++++++++++-------------
 drivers/i2c/busses/i2c-nomadik.c  |    6 +-
 drivers/i2c/busses/i2c-omap.c     |  265 +++++++++++++++++++++++++++++--------
 drivers/i2c/busses/i2c-s3c2410.c  |   19 +++-
 include/linux/i2c-omap.h          |    9 ++
 6 files changed, 346 insertions(+), 160 deletions(-)
 create mode 100644 include/linux/i2c-omap.h


-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
