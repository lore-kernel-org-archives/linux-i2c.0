From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.40 (or whatever)
Date: Tue, 24 May 2011 23:25:38 +0200
Message-ID: <20110524232538.4b2f4b8c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

Most changes are cleanups and improvements to the Intel 82801 SMBus
controller driver.

 Documentation/i2c/busses/i2c-i801      |    1 +
 Documentation/i2c/writing-clients      |    2 +-
 drivers/i2c/busses/Kconfig             |    2 +
 drivers/i2c/busses/i2c-i801.c          |   61 ++++++++++++++++----------
 drivers/i2c/busses/i2c-parport-light.c |   10 ++--
 drivers/i2c/busses/i2c-parport.c       |   30 ++++++------
 drivers/i2c/busses/i2c-parport.h       |   74 +++++++++++++++-----------------
 7 files changed, 97 insertions(+), 83 deletions(-)

---------------

Jean Delvare (4):
      i2c-i801: Don't probe for slaves on IDF channels
      i2c-i801: Check for vendor Fujitsu before probing for apanel
      i2c-i801: Don't depend on other kernel driver config options
      i2c-parport: Various cleanups

Seth Heasley (1):
      i2c-i801: SMBus patch for Intel Panther Point DeviceIDs

Vikram Narayanan (1):
      i2c/writing-clients: Fix foo_driver.id_table

Thanks,
-- 
Jean Delvare
