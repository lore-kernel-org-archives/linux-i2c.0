From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.2
Date: Sun, 30 Oct 2011 18:10:18 +0100
Message-ID: <20111030181018.368d1614@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/smbus-protocol |    8 ++++++++
 drivers/i2c/algos/i2c-algo-bit.c |   24 +++++++++++++-----------
 drivers/i2c/algos/i2c-algo-pca.c |    6 ++++--
 drivers/i2c/busses/Kconfig       |    2 +-
 drivers/i2c/busses/scx200_acb.c  |    6 +++---
 include/linux/i2c.h              |   17 +++++++++++++++++
 6 files changed, 46 insertions(+), 17 deletions(-)

---------------

Geert Uytterhoeven (1):
      i2c: I2C_ELEKTOR should depend on HAS_IOPORT

Harvey Yang (1):
      i2c/scx200_acb: Fix section mismatch warning in scx200_pci_drv

Jean Delvare (4):
      i2c-algo-bit: Let user test buses without failing
      i2c-algo-bit: Be verbose on bus testing failure
      i2c-algo-bit: Return standard fault codes
      i2c-algo-pca: Return standard fault codes

Jonathan Cameron (1):
      i2c: Functions for byte-swapped smbus_write/read_word_data

Thanks,
-- 
Jean Delvare
