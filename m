From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.34, round 1
Date: Tue, 2 Mar 2010 13:41:20 +0100
Message-ID: <20100302134120.3f22c927@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a first round of i2c subsystem updates for Linux 2.6.34
from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-=
for-linus

The main change here is the added support for the SMBus alert
protocols. And then come the usual random driver cleanups.

 Documentation/i2c/busses/i2c-i801          |    3 +-
 Documentation/i2c/busses/i2c-parport       |    3 +
 Documentation/i2c/busses/i2c-parport-light |   11 ++
 Documentation/i2c/smbus-protocol           |   16 ++
 Documentation/i2c/writing-clients          |    5 +-
 drivers/i2c/Kconfig                        |   10 +
 drivers/i2c/Makefile                       |    1 +
 drivers/i2c/algos/i2c-algo-pca.c           |    2 -
 drivers/i2c/busses/Kconfig                 |    7 +-
 drivers/i2c/busses/i2c-ali1535.c           |    2 +-
 drivers/i2c/busses/i2c-ali1563.c           |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c           |    2 +-
 drivers/i2c/busses/i2c-amd756.c            |    2 +-
 drivers/i2c/busses/i2c-amd8111.c           |    2 +-
 drivers/i2c/busses/i2c-hydra.c             |    2 +-
 drivers/i2c/busses/i2c-i801.c              |    7 +-
 drivers/i2c/busses/i2c-isch.c              |    2 +-
 drivers/i2c/busses/i2c-nforce2.c           |    2 +-
 drivers/i2c/busses/i2c-parport-light.c     |   48 +++++-
 drivers/i2c/busses/i2c-parport.c           |   43 +++++-
 drivers/i2c/busses/i2c-parport.h           |    4 +-
 drivers/i2c/busses/i2c-pasemi.c            |    2 +-
 drivers/i2c/busses/i2c-piix4.c             |    2 +-
 drivers/i2c/busses/i2c-sis5595.c           |    2 +-
 drivers/i2c/busses/i2c-sis630.c            |    2 +-
 drivers/i2c/busses/i2c-sis96x.c            |    2 +-
 drivers/i2c/busses/i2c-tiny-usb.c          |   10 +-
 drivers/i2c/busses/i2c-via.c               |    2 +-
 drivers/i2c/busses/i2c-viapro.c            |    2 +-
 drivers/i2c/i2c-core.c                     |   54 ++++++-
 drivers/i2c/i2c-smbus.c                    |  263 ++++++++++++++++++++=
++++++++
 include/linux/i2c-smbus.h                  |   50 ++++++
 include/linux/i2c.h                        |    8 +
 33 files changed, 537 insertions(+), 38 deletions(-)
 create mode 100644 drivers/i2c/i2c-smbus.c
 create mode 100644 include/linux/i2c-smbus.h

---------------

Jean Delvare (7):
      i2c-tiny-usb: Fix a comment on bus frequency
      i2c-parport: Give powered devices some time to settle
      i2c: Add SMBus alert support
      i2c: Separate Kconfig option for i2c-smbus
      i2c-parport: Add SMBus alert support
      i2c-parport-light: Add SMBus alert support
      i2c-algo-pca: Drop duplicate variable

Mark Brown (1):
      i2c: Hook up runtime PM support

M=C3=A1rton N=C3=A9meth (1):
      i2c: Make PCI device ids constant

Seth Heasley (1):
      i2c-i801: Add Intel Cougar Point device IDs

Zhangfei Gao (1):
      i2c: Document the message size limit

Thanks,
--=20
Jean Delvare
