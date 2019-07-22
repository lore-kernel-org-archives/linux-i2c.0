From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] media: ir-kbd-i2c: remove outdated comments
Date: Mon, 22 Jul 2019 19:26:32 +0200
Message-ID: <20190722172632.4402-3-wsa+renesas@sang-engineering.com>
References: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The "free memory" comment is obsolete since 2013 and the other ones
explain the obvious. Just remove the comments.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/i2c/ir-kbd-i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
index f46717052efc..30fde0e025c9 100644
--- a/drivers/media/i2c/ir-kbd-i2c.c
+++ b/drivers/media/i2c/ir-kbd-i2c.c
@@ -916,13 +916,9 @@ static int ir_remove(struct i2c_client *client)
 {
 	struct IR_i2c *ir = i2c_get_clientdata(client);
 
-	/* kill outstanding polls */
 	cancel_delayed_work_sync(&ir->work);
-
-	/* unregister device */
 	rc_unregister_device(ir->rc);
 
-	/* free memory */
 	return 0;
 }
 
-- 
2.20.1
