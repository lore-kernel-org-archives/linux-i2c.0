From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.28
Date: Fri, 28 Nov 2008 15:33:13 +0100
Message-ID: <20081128153313.1341113f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.28 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/i2c/busses/i2c-parport.c |    4 +-
 drivers/i2c/chips/isp1301_omap.c |   65 +++++++++++++++++++++++++++----------
 drivers/i2c/i2c-core.c           |    2 +-
 3 files changed, 50 insertions(+), 21 deletions(-)

---------------

David Brownell (1):
      i2c/isp1301_omap: Build fixes

Jean Delvare (2):
      i2c: Remove i2c clients in reverse order
      i2c-parport: Fix misplaced parport_release call

Thanks,
-- 
Jean Delvare
