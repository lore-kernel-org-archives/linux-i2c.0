From: Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH 2/2] i2c: Fix a potential use after free
Date: Fri, 27 Dec 2019 09:34:32 +0000
Message-ID: <1577439272-10362-1-git-send-email-vulab@iscas.ac.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Free the adap structure only after we are done using it.
This patch just moves the put_device() down a bit to avoid the
use after free.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9f8dcd3..160d43e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2301,8 +2301,8 @@ void i2c_put_adapter(struct i2c_adapter *adap)
 	if (!adap)
 		return;
 
-	put_device(&adap->dev);
 	module_put(adap->owner);
+	put_device(&adap->dev);
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
-- 
2.7.4
