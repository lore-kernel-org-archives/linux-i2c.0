From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.39
Date: Sun, 20 Mar 2011 15:41:43 +0100
Message-ID: <20110320154143.2f0d6e4d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

Mostly core clean-ups this time.

 Documentation/feature-removal-schedule.txt |   19 ++++-----
 Documentation/i2c/busses/i2c-i801          |    3 +-
 Documentation/i2c/instantiating-devices    |    2 +-
 Documentation/i2c/upgrading-clients        |   18 ++++----
 Documentation/video4linux/Zoran            |    2 +-
 drivers/i2c/Makefile                       |    1 +
 drivers/i2c/busses/Kconfig                 |    3 +-
 drivers/i2c/busses/i2c-i801.c              |    4 +-
 drivers/i2c/i2c-boardinfo.c                |    2 +-
 drivers/i2c/i2c-core.c                     |   28 +++++++++----
 drivers/i2c/i2c-dev.c                      |   60 ++++++++++++++++++----------
 include/linux/i2c-id.h                     |   37 -----------------
 include/linux/i2c.h                        |   18 ++++----
 13 files changed, 97 insertions(+), 100 deletions(-)
 delete mode 100644 include/linux/i2c-id.h

---------------

Jean Delvare (7):
      i2c: make i2c_get_adapter prototype clearer
      i2c: Minor fixes to upgrading-clients document
      i2c: Get rid of <linux/i2c-id.h>
      i2c: Export i2c_for_each_dev
      i2c-dev: Use standard bus notification mechanism
      i2c: Deprecate i2c_driver.attach_adapter and .detach_adapter
      i2c: Drop i2c_adapter.id

Roman Fietze (1):
      i2c: Fix typo in instantiating-devices document

Seth Heasley (1):
      i2c-i801: SMBus patch for Intel DH89xxCC DeviceIDs

Wolfram Sang (1):
      i2c-boardinfo: Fix typo in comment

Thanks,
-- 
Jean Delvare
