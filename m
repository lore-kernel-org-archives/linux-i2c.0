From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: [PATCH] fix i2c_pca_pf_waitforcompletion() return value
Date: Mon, 20 Sep 2010 11:14:32 +0200
Message-ID: <4C9725F8.1080200@visionsystems.de>
Reply-To: yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ret is still -1, if during the polling read_byte() returns at once
with I2C_PCA_CON_SI set. So ret > 0 would lead 
i2c_pca_pf_waitforcompletion() to return 0, in spite of
the proper behavior. That's why only ret should be returned.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Index: b/drivers/i2c/busses/i2c-pca-platform.c
===================================================================
--- a/drivers/i2c/busses/i2c-pca-platform.c	2010-08-27 01:47:12.000000000 +0200
+++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-20 10:21:05.000000000 +0200
@@ -96,7 +96,7 @@
 			udelay(100);
 	}
 
-	return ret > 0;
+	return ret;
 }
 
 static void i2c_pca_pf_dummyreset(void *pd)
