From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: tegra: drop duplicated code for assigning algo
Date: Mon,  7 Sep 2015 03:08:55 +0000
Message-ID: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Donglin Peng <pengdonglin137-9Onoh4P/yGk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This code is repeated in probe:
i2c_dev->adapter.algo = &tegra_i2c_algo;

Cc: Donglin Peng <pengdonglin137-9Onoh4P/yGk@public.gmane.org>
Signed-off-by: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 78a3668..9ab720b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -825,7 +825,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->adapter.class = I2C_CLASS_DEPRECATED;
 	strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
 		sizeof(i2c_dev->adapter.name));
-	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.dev.parent = &pdev->dev;
 	i2c_dev->adapter.nr = pdev->id;
 	i2c_dev->adapter.dev.of_node = pdev->dev.of_node;
-- 
1.9.1
