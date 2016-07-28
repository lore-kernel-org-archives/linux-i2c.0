From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/5] i2c: i801: minor formatting issues
Date: Thu, 28 Jul 2016 11:50:40 +0200
Message-ID: <1469699443-22129-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No functional changes, just typos and remove unused #define.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index cde9a7c..80d67b8 100644
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
@@ -269,8 +269,6 @@ struct i801_priv {
 	struct smbus_host_notify *host_notify;
 };
 
-#define SMBHSTNTFY_SIZE		8
-
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
-- 
2.5.5
