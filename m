From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c cleanups for 2.6.30
Date: Mon, 6 Apr 2009 18:15:08 +0200
Message-ID: <20090406181508.4a372d74@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem cleanups for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 Documentation/feature-removal-schedule.txt |    3 +-
 drivers/i2c/algos/Kconfig                  |    4 -
 drivers/i2c/algos/Makefile                 |    1 -
 drivers/i2c/algos/i2c-algo-sgi.c           |  179 ----------------------------
 include/linux/i2c-algo-sgi.h               |   26 ----
 include/linux/i2c-id.h                     |   37 ------
 include/linux/i2c.h                        |    4 +-
 7 files changed, 4 insertions(+), 250 deletions(-)
 delete mode 100644 drivers/i2c/algos/i2c-algo-sgi.c
 delete mode 100644 include/linux/i2c-algo-sgi.h

---------------

Jean Delvare (3):
      i2c: Deprecate client_register and client_unregister methods
      i2c: Delete many unused driver IDs
      i2c: Delete unused i2c-algo-sgi helper module

Thanks,
-- 
Jean Delvare
