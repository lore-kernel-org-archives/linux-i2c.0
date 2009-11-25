From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.32
Date: Wed, 25 Nov 2009 13:46:07 +0100
Message-ID: <20091125134607.5dc83117@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the last i2c subsystem updates for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 MAINTAINERS                 |    3 +-
 drivers/i2c/chips/tsl2550.c |    3 ++
 drivers/i2c/i2c-core.c      |   11 ++++++
 drivers/misc/eeprom/at24.c  |   76 +++++++++++++++++++++++++-----------------
 4 files changed, 60 insertions(+), 33 deletions(-)

---------------

Jean Delvare (2):
      MAINTAINERS: Add missing i2c files
      i2c: Fix userspace_device list corruption

Michele Jr De Candia (1):
      i2c/tsl2550: Fix lux value in extended mode

Wolfram Sang (1):
      at24: Use timeout also for read

Thanks,
-- 
Jean Delvare
