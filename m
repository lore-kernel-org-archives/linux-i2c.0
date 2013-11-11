From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] tree-wide: add missing clk_disable_unprepare() on error
 in wmt_i2c_reset_hardware()
Date: Mon, 11 Nov 2013 22:23:50 +0800
Message-ID: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Add the missing clk_disable_unprepare() before return
from wmt_i2c_reset_hardware() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/i2c/busses/i2c-wmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 31395fa..2c8a3e4 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -349,6 +349,7 @@ static int wmt_i2c_reset_hardware(struct wmt_i2c_dev *i2c_dev)
 	err = clk_set_rate(i2c_dev->clk, 20000000);
 	if (err) {
 		dev_err(i2c_dev->dev, "failed to set clock = 20Mhz\n");
+		clk_disable_unprepare(i2c_dev->clk);
 		return err;
 	}
 
