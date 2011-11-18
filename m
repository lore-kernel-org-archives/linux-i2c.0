From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v2] I2C: Make i2cdev_notifier_call static
Date: Fri, 18 Nov 2011 21:17:31 +0530
Message-ID: <1321631251-4438-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-i2c@vger.kernel.org

The function i2cdev_notifier_call is used only in i2c-dev file
making it static.
Also removes the following sparse warning

drivers/i2c/i2c-dev.c:582:5: warning: symbol 'i2cdev_notifier_call'
was not declared. Should it be static?

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index c90ce50..57a45ce 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -579,7 +579,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	return 0;
 }
 
-int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
+static int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
 			 void *data)
 {
 	struct device *dev = data;
-- 
1.7.1
