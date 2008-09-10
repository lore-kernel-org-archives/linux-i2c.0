From: Sven Wegener <sven.wegener@stealer.net>
Subject: [PATCH] i2c-dev: Return correct error code on class_create()
 failure
Date: Wed, 10 Sep 2008 21:30:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0809102128110.19109@titan.stealer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752307AbYIJTaz@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We need to convert the error pointer from class_create(), else we'll return the
successful return code from register_chrdev() on failure.

Signed-off-by: Sven Wegener <sven.wegener@stealer.net>
---
 drivers/i2c/i2c-dev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index af4491f..307d976 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -583,8 +583,10 @@ static int __init i2c_dev_init(void)
 		goto out;
 
 	i2c_dev_class = class_create(THIS_MODULE, "i2c-dev");
-	if (IS_ERR(i2c_dev_class))
+	if (IS_ERR(i2c_dev_class)) {
+		res = PTR_ERR(i2c_dev_class);
 		goto out_unreg_chrdev;
+	}
 
 	res = i2c_add_driver(&i2cdev_driver);
 	if (res)
