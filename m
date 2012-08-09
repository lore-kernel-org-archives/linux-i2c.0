From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6] I2C cleanup
Date: Thu, 9 Aug 2012 19:07:41 +0530
Message-ID: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Prevent possible NULL pointer access. 

Only the omap patch is tested.
I would be grateful if anone having the platform
helps me test it.

Shubhrajyoti D (6):
  i2c: omap: Prevent NULL pointer dereference in remove
  i2c-xiic:  Fix a possible NULL pointer access
  i2c: designware: Fix a possible NULL pointer access
  i2c: at91: Fix a possible NULL pointer access
  i2c-puv3: Fix a possible NULL pointer access
  i2c: davinci: Fix a possible NULL pointer access

 drivers/i2c/busses/i2c-at91.c               |    2 +-
 drivers/i2c/busses/i2c-davinci.c            |    2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |    2 +-
 drivers/i2c/busses/i2c-omap.c               |    4 ++--
 drivers/i2c/busses/i2c-puv3.c               |    2 +-
 drivers/i2c/busses/i2c-xiic.c               |    3 +--
 6 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.7.5.4
