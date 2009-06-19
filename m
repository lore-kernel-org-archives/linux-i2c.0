From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.31, part 2
Date: Fri, 19 Jun 2009 17:56:55 +0200
Message-ID: <20090619175655.4723aef2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a second set of i2c subsystem updates for Linux 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

The most important part is the removal of the legacy i2c binding model
support, together with all the cleanups it allowed.

 Documentation/feature-removal-schedule.txt |   10 -
 Documentation/i2c/instantiating-devices    |   44 +++
 Documentation/i2c/writing-clients          |   16 +-
 drivers/i2c/i2c-boardinfo.c                |    7 +-
 drivers/i2c/i2c-core.c                     |  557 ++++++++++------------------
 drivers/i2c/i2c-core.h                     |    4 +-
 include/linux/i2c.h                        |   72 ++---
 7 files changed, 275 insertions(+), 435 deletions(-)

---------------

Hans Verkuil (1):
      i2c: New macro to initialize i2c address lists on the fly

Jean Delvare (9):
      i2c: Kill client_register and client_unregister methods
      i2c: Get rid of the legacy binding model
      i2c: Drop i2c_probe function
      i2c: Merge i2c_attach_client into i2c_new_device
      i2c: Kill is_newstyle_driver
      i2c: Kill the redundant client list
      i2c: Limit core locking to the necessary sections
      i2c: Add a sysfs interface to instantiate devices
      i2c: Don't advertise i2c functions when not available

Rodolfo Giometti (1):
      i2c: Use rwsem instead of mutex for board info

Thanks,
-- 
Jean Delvare
