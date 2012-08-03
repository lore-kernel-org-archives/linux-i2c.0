From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme@gmail.com>
Subject: [PATCH v2 0/2] I2C: SIS964: Bus driver
Date: Fri,  3 Aug 2012 17:35:43 +0200
Message-ID: <1344008145-14579-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net
Cc: jeffrey.t.kirsher@intel.com, akpm@linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, joe@perches.com, ralf@linux-mips.org, dirk.brandewie@gmail.com, jayachandranc@netlogicmicro.com, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This series of patches are a I2C bus driver for the SIS964.


The SIS964 is nearly the same as SIS630 for the SMBUS :
	- Most of the SMBus registers (Status, Enable, Control,
	  Host Control, etc.) are at the same adresses + 0x60
	- The register count is 21 instead of 20

The SIS964 name is ambiguous as this chip isn't part of the SIS96X
family and behaves differently.

The datasheets have been used to develop the driver based on the
exsiting driver for I2C SIS630 .=20


Content of the patches:
	- 1/2 The driver itself
	- 2/2 Documentation, Kconfig, Makefile, Maintainers


Changes:
	V2
	- Remove of the insertion on include/linux/pci_ids.h
	and no quirk needed
	- Cosmetics on the source code + patch split

Amaury Decr=C3=AAme (2):
  I2C: SIS964: Bus driver - Driver
  I2C: SIS964: Bus driver - other files

 Documentation/i2c/busses/i2c-sis964 |   36 +++
 MAINTAINERS                         |    7 +
 drivers/i2c/busses/Kconfig          |   12 +-
 drivers/i2c/busses/Makefile         |    1 +
 drivers/i2c/busses/i2c-sis964.c     |  578 +++++++++++++++++++++++++++=
++++++++
 5 files changed, 633 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-sis964
 create mode 100644 drivers/i2c/busses/i2c-sis964.c

--=20
1.7.8.6

