From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.30
Date: Mon, 13 Apr 2009 17:12:30 +0200
Message-ID: <20090413171230.73078c3e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/i2c/algos/i2c-algo-pca.c           |    2 +-
 drivers/i2c/busses/Kconfig                 |    6 ++++--
 drivers/i2c/i2c-core.c                     |    3 +--
 include/linux/i2c.h                        |    2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

---------------

Ben Hutchings (1):
      i2c: Fix sparse warnings for I2C_BOARD_INFO()

Jean Delvare (3):
      i2c-algo-pca: Fix use of uninitialized variable in debug message
      i2c-voodoo3: Deprecate in favor of tdfxfb
      i2c: Let new-style drivers implement attach_adapter

Thanks,
-- 
Jean Delvare
