From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: hix5hd2: remove some dead code
Date: Wed,  9 May 2018 21:46:03 +0200
Message-ID: <20180509194603.28986-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The else branch cannot be taken as i will always equal num.
Get rid of the whole construct.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..190b250e6834 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -377,17 +377,7 @@ static int hix5hd2_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 	}
 
-	if (i == num) {
-		ret = num;
-	} else {
-		/* Only one message, cannot access the device */
-		if (i == 1)
-			ret = -EREMOTEIO;
-		else
-			ret = i;
-
-		dev_warn(priv->dev, "xfer message failed\n");
-	}
+	ret = num;
 
 out:
 	pm_runtime_mark_last_busy(priv->dev);
-- 
2.11.0
