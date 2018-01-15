From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH i2c-tools] i2c-dev.h: copy over typo fix from kernel include
Date: Mon, 15 Jan 2018 21:40:30 +0100
Message-ID: <20180115204030.26400-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41572 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeAOUkf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 15:40:35 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>

We had a typo in a define which got fixed in the kernel. Fix it here,
too!

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/i2c-dev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/i2c-dev.h b/include/linux/i2c-dev.h
index 839d25a..bbb50e8 100644
--- a/include/linux/i2c-dev.h
+++ b/include/linux/i2c-dev.h
@@ -66,7 +66,9 @@ struct i2c_rdwr_ioctl_data {
 	__u32 nmsgs;			/* number of i2c_msgs */
 };
 
-#define  I2C_RDRW_IOCTL_MAX_MSGS	42
+#define  I2C_RDWR_IOCTL_MAX_MSGS	42
+/* Originally defined with a typo, keep it for compatibility */
+#define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS
 
 
 #endif /* _LINUX_I2C_DEV_H */
-- 
2.11.0
