From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 05/10] i2c: i801: use the BIT() macro for FEATURES_* also
Date: Wed, 28 Sep 2016 10:15:44 +0200
Message-ID: <1475050549-25542-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbcI1IQB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:16:01 -0400
In-Reply-To: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

no functional changes

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

new in v2
---
 drivers/i2c/busses/i2c-i801.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 05ce265..55fa6e1 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -270,15 +270,15 @@ struct i801_priv {
 	struct smbus_host_notify *host_notify;
 };
 
-#define FEATURE_SMBUS_PEC	(1 << 0)
-#define FEATURE_BLOCK_BUFFER	(1 << 1)
-#define FEATURE_BLOCK_PROC	(1 << 2)
-#define FEATURE_I2C_BLOCK_READ	(1 << 3)
-#define FEATURE_IRQ		(1 << 4)
-#define FEATURE_HOST_NOTIFY	(1 << 5)
+#define FEATURE_SMBUS_PEC	BIT(0)
+#define FEATURE_BLOCK_BUFFER	BIT(1)
+#define FEATURE_BLOCK_PROC	BIT(2)
+#define FEATURE_I2C_BLOCK_READ	BIT(3)
+#define FEATURE_IRQ		BIT(4)
+#define FEATURE_HOST_NOTIFY	BIT(5)
 /* Not really a feature, but it's convenient to handle it as such */
-#define FEATURE_IDF		(1 << 15)
-#define FEATURE_TCO		(1 << 16)
+#define FEATURE_IDF		BIT(15)
+#define FEATURE_TCO		BIT(16)
 
 static const char *i801_feature_names[] = {
 	"SMBus PEC",
-- 
2.7.4
