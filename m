From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] i2c: i2c-core-base: tiny indention cleanup
Date: Thu, 21 Nov 2019 16:35:41 +0100
Message-ID: <20191121153541.26402-1-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5f6a4985f2bc..68be4e89d16a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2326,7 +2326,7 @@ struct i2c_adapter *i2c_get_adapter(int nr)
 	else
 		adapter = NULL;
 
- exit:
+exit:
 	mutex_unlock(&core_lock);
 	return adapter;
 }
-- 
2.11.0
