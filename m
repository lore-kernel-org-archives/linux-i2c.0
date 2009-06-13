From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Sat, 13 Jun 2009 11:00:09 +0100
Message-ID: <E1MFQ1x-00050J-Kc@kira.home.fluff.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apkm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit f3ad116588151b3371ae4e092290e4f48e62=
b8bb:
  Linus Torvalds (1):
        Merge branch 'upstream-linus' of git://git.kernel.org/.../jlbec=
/configfs

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Aaro Koskinen (2):
      i2c: OMAP2/3: Fix scll/sclh calculations
      i2c: OMAP3: Better noise suppression for fast/standard modes

Ben Dooks (1):
      i2c-s3c2410: move to using platform idtable to match devices

=46rank Shew (1):
      i2c: Blackfin TWI: fix transfer errors with repeat start

Michael Hennerich (2):
      i2c: Blackfin TWI: make sure we don't end up with a CLKDIV=3D0
      i2c: Blackfin TWI: implement I2C_FUNC_SMBUS_I2C_BLOCK functionali=
ty

Richard R=C3=B6jfors (1):
      i2c-ocores: Can add I2C devices to the bus

Sonic Zhang (1):
      i2c: Blackfin TWI: fix REPEAT START mode doesn't repeat

 Documentation/i2c/busses/i2c-ocores |   17 ++++++++++
 drivers/i2c/busses/Kconfig          |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c   |   59 ++++++++++++++++++++++++---=
-------
 drivers/i2c/busses/i2c-ocores.c     |    5 +++
 drivers/i2c/busses/i2c-omap.c       |   39 ++++++++++++++++++-----
 drivers/i2c/busses/i2c-s3c2410.c    |   48 +++++++++++++--------------=
-
 include/linux/i2c-ocores.h          |    2 +
 7 files changed, 118 insertions(+), 54 deletions(-)
