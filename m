From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] i2c-eg20t: Change-company-name-OKI-SEMICONDUCTOR to LAPIS Semiconductor
Date: Fri, 28 Oct 2011 09:40:11 +0900
Message-ID: <1319762411-7174-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>
References: <1319762411-7174-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319762411-7174-1-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On October 1 in 2011,
OKI SEMICONDUCTOR Co., Ltd. changed the company name in to LAPIS Semiconductor Co., Ltd.

Signed-off-by: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 62135bc..e81e838 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010 OKI SEMICONDUCTOR CO., LTD.
+ * Copyright (C) 2011 LAPIS Semiconductor Co., Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -135,8 +135,8 @@
 /*
 Set the number of I2C instance max
 Intel EG20T PCH :		1ch
-OKI SEMICONDUCTOR ML7213 IOH :	2ch
-OKI SEMICONDUCTOR ML7831 IOH :	1ch
+LAPIS Semiconductor ML7213 IOH :	2ch
+LAPIS Semiconductor ML7831 IOH :	1ch
 */
 #define PCH_I2C_MAX_DEV			2
 
@@ -180,7 +180,7 @@ static int pch_clk = 50000;	/* specifies I2C clock speed in KHz */
 static wait_queue_head_t pch_event;
 static DEFINE_MUTEX(pch_mutex);
 
-/* Definition for ML7213 by OKI SEMICONDUCTOR */
+/* Definition for ML7213 by LAPIS Semiconductor */
 #define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_I2C	0x802D
 #define PCI_DEVICE_ID_ML7223_I2C	0x8010
@@ -937,8 +937,8 @@ static void __exit pch_pci_exit(void)
 }
 module_exit(pch_pci_exit);
 
-MODULE_DESCRIPTION("Intel EG20T PCH/OKI SEMICONDUCTOR ML7213 IOH I2C Driver");
+MODULE_DESCRIPTION("Intel EG20T PCH/LAPIS Semico ML7213/ML7223/ML7831 IOH I2C");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tomoya MORINAGA. <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>");
+MODULE_AUTHOR("Tomoya MORINAGA. <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>");
 module_param(pch_i2c_speed, int, (S_IRUSR | S_IWUSR));
 module_param(pch_clk, int, (S_IRUSR | S_IWUSR));
-- 
1.7.4.4
