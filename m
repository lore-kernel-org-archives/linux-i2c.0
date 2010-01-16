From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.33
Date: Sat, 16 Jan 2010 21:02:18 +0100
Message-ID: <20100116210218.35c9a21d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-=
for-linus

 drivers/i2c/busses/i2c-ali1563.c      |    8 ++++----
 drivers/i2c/busses/i2c-pca-isa.c      |    4 ++--
 drivers/i2c/busses/i2c-pca-platform.c |    4 ++--
 drivers/i2c/busses/i2c-piix4.c        |    4 ++--
 drivers/i2c/busses/i2c-viapro.c       |    4 ++--
 drivers/i2c/i2c-core.c                |    7 ++++---
 6 files changed, 16 insertions(+), 15 deletions(-)

---------------

M=C3=A1rton N=C3=A9meth (1):
      i2c-ali1563: Remove sparse warnings

Roel Kluin (1):
      i2c: Test off by one in {piix4,vt596}_transaction()

Thadeu Lima de Souza Cascardo (1):
      i2c: Do not use device name after device_unregister

Tobias Klauser (1):
      i2c-core: Storage class should be before const qualifier

Wolfram Sang (1):
      i2c/pca: Don't use *_interruptible

Thanks,
--=20
Jean Delvare
