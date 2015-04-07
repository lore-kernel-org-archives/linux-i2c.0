From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/1] i2c-designware setup & hold time fix
Date: Mon,  6 Apr 2015 19:40:27 -0700
Message-ID: <cover.1428374207.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch fixes hold & setup time failures in dw i2c driver.

Please let me know your review comments.

v1:

Added the fix.

Kuppuswamy Sathyanarayanan (1):
  i2c: designware: Fix hold and setup time issue

 drivers/i2c/busses/i2c-designware-core.c    | 37 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c |  4 ++++
 3 files changed, 43 insertions(+)

-- 
1.9.1
