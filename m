From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.37
Date: Mon, 15 Nov 2010 22:58:30 +0100
Message-ID: <20101115225830.3d2b0994@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/feature-removal-schedule.txt |   10 ++++++++++
 drivers/i2c/i2c-core.c                     |   12 ++++++++++++
 drivers/i2c/i2c-mux.c                      |    1 -
 drivers/media/common/saa7146_i2c.c         |    1 -
 drivers/media/video/imx074.c               |    2 --
 drivers/media/video/ir-kbd-i2c.c           |    1 -
 drivers/media/video/ov6650.c               |    2 --
 drivers/misc/apds9802als.c                 |    1 -
 drivers/staging/olpc_dcon/olpc_dcon.c      |    4 ----
 drivers/video/riva/rivafb-i2c.c            |    1 -
 include/linux/i2c-id.h                     |   22 ----------------------
 include/linux/i2c.h                        |    2 +-
 12 files changed, 23 insertions(+), 36 deletions(-)

---------------

Jean Delvare (4):
      i2c: Delete unused adapter IDs
      i2c: Drivers shouldn't include <linux/i2c-id.h>
      i2c: Mark i2c_adapter.id as deprecated
      i2c: Sanity checks on adapter registration

Wolfram Sang (1):
      i2c: Remove obsolete cleanup for clientdata

Thanks,
-- 
Jean Delvare
