From: Joe Perches <joe@perches.com>
Subject: [PATCH 06/21] drivers/i2c/i2c-dev.c: Remove unnecessary kmalloc casts
Date: Mon, 31 May 2010 20:23:08 -0700
Message-ID: <ce6e7e3183f0756b14765076e63251e269e2c9f6.1275360951.git.joe@perches.com>
References: <cover.1275360951.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1275360951.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/i2c/i2c-dev.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e0694e4..b3fcb59 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -219,9 +219,7 @@ static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
 	if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
-	rdwr_pa = (struct i2c_msg *)
-		kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
-		GFP_KERNEL);
+	rdwr_pa = kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), GFP_KERNEL);
 	if (!rdwr_pa)
 		return -ENOMEM;
 
-- 
1.7.0.3.311.g6a6955
