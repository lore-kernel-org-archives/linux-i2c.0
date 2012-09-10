From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for Linux 3.6
Date: Mon, 10 Sep 2012 10:16:27 +0200
Message-ID: <20120910101627.2a7ca310@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.6 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/busses/i2c-i801        |    1 +
 drivers/i2c/busses/Kconfig               |    6 ++++++
 drivers/i2c/busses/Makefile              |    5 +++--
 drivers/i2c/busses/i2c-designware-core.c |   11 +++++++++++
 drivers/i2c/busses/i2c-i801.c            |    3 +++
 drivers/i2c/i2c-core.c                   |   22 ++++++++++++++++++++--
 6 files changed, 44 insertions(+), 4 deletions(-)

---------------

Axel Lin (1):
      i2c-designware: Fix build error if CONFIG_I2C_DESIGNWARE_PLATFORM=y && CONFIG_I2C_DESIGNWARE_PCI=y

James Ralston (1):
      i2c-i801: Add Device IDs for Intel Lynx Point-LP PCH

Jean Delvare (1):
      i2c-core: Fix for lockdep validator

Thanks,
-- 
Jean Delvare
