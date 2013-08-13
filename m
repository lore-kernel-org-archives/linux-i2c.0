From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] i2c: sirf: retry 3 times as sometimes we get random noack and timeout
Date: Tue, 13 Aug 2013 17:11:31 +0800
Message-ID: <1376385091-30597-6-git-send-email-Baohua.Song@csr.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376385091-30597-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>

let i2c core retry 3 times as sometimes we get random noack and timeout
even when we access an existing i2c client.

Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index d2b7913..90adc2d 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -230,7 +230,7 @@ static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
 		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
 			cpu_relax();
 	}
-	return siic->err_status ? -EIO : 0;
+	return siic->err_status ? -EAGAIN : 0;
 }
 
 static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
@@ -334,6 +334,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 
 	adap->algo = &i2c_sirfsoc_algo;
 	adap->algo_data = siic;
+	adap->retries = 3;
 
 	adap->dev.of_node = pdev->dev.of_node;
 	adap->dev.parent = &pdev->dev;
-- 
1.8.2.3
