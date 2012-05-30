From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.5
Date: Wed, 30 May 2012 11:06:41 +0200
Message-ID: <20120530110641.22d656da@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.5 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/functionality       |    9 ++++++---
 Documentation/i2c/i2c-protocol        |    9 ++++++++-
 drivers/base/regmap/regmap-i2c.c      |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c      |    2 +-
 drivers/i2c/busses/i2c-nuc900.c       |    3 ++-
 drivers/i2c/busses/i2c-s3c2410.c      |    3 ++-
 drivers/i2c/i2c-dev.c                 |   30 ++++++++++++++++++++++++++----
 drivers/input/joystick/as5011.c       |    1 +
 drivers/video/matrox/matroxfb_maven.c |    1 +
 include/linux/i2c.h                   |    5 +++--
 10 files changed, 51 insertions(+), 14 deletions(-)

---------------

Jean Delvare (1):
      i2c-dev: Add support for I2C_M_RECV_LEN

Mark Brown (1):
      i2c: Split I2C_M_NOSTART support out of I2C_FUNC_PROTOCOL_MANGLING

Thanks,
-- 
Jean Delvare
