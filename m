From: Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/12] i2c-algo-pca: Fix typo in comment.
Date: Mon, 18 May 2015 22:37:54 +0530
Message-ID: <1431968874-3418-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 580dbf0..e370804 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -521,7 +521,7 @@ static int pca_init(struct i2c_adapter *adap)
 
 		pca_set_con(pca_data, I2C_PCA_CON_ENSIO);
 	}
-	udelay(500); /* 500 us for oscilator to stabilise */
+	udelay(500); /* 500 us for oscillator to stabilise */
 
 	return 0;
 }
-- 
1.7.9.5
