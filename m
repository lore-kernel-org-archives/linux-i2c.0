From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] i2c-davinci: issue timeout warning only once
Date: Thu, 8 Jan 2009 11:48:30 +0200
Message-ID: <20090108094829.GB3824@diamond.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

When timeout occurs the i2c_davinci_wait_bus_not_busy() issues a warning. No 
need to do this twice.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5d77898..fbddc50 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -349,10 +349,8 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
 	ret = i2c_davinci_wait_bus_not_busy(dev, 1);
-	if (ret < 0) {
-		dev_warn(dev->dev, "timeout waiting for bus ready\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < num; i++) {
 		ret = i2c_davinci_xfer_msg(adap, &msgs[i], (i == (num - 1)));

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
