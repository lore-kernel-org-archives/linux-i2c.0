From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: viperboard: return message count on master_xfer success
Date: Wed,  9 May 2018 21:47:48 +0200
Message-ID: <20180509194748.29222-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Returning zero is wrong in this case.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-viperboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index e4be86b3de9a..7235c7302bb7 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -337,7 +337,7 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 		}
 		mutex_unlock(&vb->lock);
 	}
-	return 0;
+	return num;
 error:
 	mutex_unlock(&vb->lock);
 	return error;
-- 
2.11.0
