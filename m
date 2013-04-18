From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/3] remove {get|put}_device from I2C drivers
Date: Thu, 18 Apr 2013 19:13:35 +0200
Message-ID: <1366305218-22817-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, manishv.b-l0cyMroinI0@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I can't see a reason why these drivers should have additional refcounting on
top of what the driver core already does. So, remove it.

These patches are compile tested only. Tested-by tags are thus much appreciated!
The patches are based on my i2c/for-next branch on kernel.org.

Wolfram Sang (3):
  i2c: davinci: drop superfluous {get|put}_device
  i2c: designware-plat: drop superfluous {get|put}_device
  i2c: designware-pci: drop superfluous {get|put}_device

 drivers/i2c/busses/i2c-davinci.c            |   19 ++++++-------------
 drivers/i2c/busses/i2c-designware-pcidrv.c  |    4 ----
 drivers/i2c/busses/i2c-designware-platdrv.c |    4 ----
 3 files changed, 6 insertions(+), 21 deletions(-)

-- 
1.7.10.4
