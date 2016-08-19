From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 03/10] i2c: i801: minor formatting issues
Date: Fri, 19 Aug 2016 15:27:35 +0200
Message-ID: <1471613262-20682-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754305AbcHSN27 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Aug 2016 09:28:59 -0400
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

No functional changes, just typos and remove unused #define.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/i2c/busses/i2c-i801.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 179e387..64da594 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -186,10 +186,10 @@
 #define SMBHSTSTS_INTR		0x02
 #define SMBHSTSTS_HOST_BUSY	0x01
 
-/* Host Notify Status registers bits */
+/* Host Notify Status register bits */
 #define SMBSLVSTS_HST_NTFY_STS	1
 
-/* Host Notify Command registers bits */
+/* Host Notify Command register bits */
 #define SMBSLVCMD_HST_NTFY_INTREN	0x01
 
 #define STATUS_ERROR_FLAGS	(SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ERR | \
@@ -270,8 +270,6 @@ struct i801_priv {
 	struct smbus_host_notify *host_notify;
 };
 
-#define SMBHSTNTFY_SIZE		8
-
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
-- 
2.5.5
