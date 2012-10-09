From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] char/tpm: Convert struct i2c_msg initialization to C99 format
Date: Tue, 9 Oct 2012 17:12:31 +0530
Message-ID: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, tpmdd-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org, tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/char/tpm/tpm_i2c_infineon.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 5a831ae..01b07c7 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -90,8 +90,18 @@ static struct i2c_driver tpm_tis_i2c_driver;
 static int iic_tpm_read(u8 addr, u8 *buffer, size_t len)
 {
 
-	struct i2c_msg msg1 = { tpm_dev.client->addr, 0, 1, &addr };
-	struct i2c_msg msg2 = { tpm_dev.client->addr, I2C_M_RD, len, buffer };
+	struct i2c_msg msg1 = {
+		.addr = tpm_dev.client->addr,
+		.flags = 0,
+		.len = 1,
+		.buf = &addr
+	};
+	struct i2c_msg msg2 = {
+		.addr = tpm_dev.client->addr,
+		.flags = I2C_M_RD,
+		.len = len,
+		.buf = buffer
+	};
 
 	int rc;
 	int count;
@@ -138,7 +148,12 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 	int rc = -EIO;
 	int count;
 
-	struct i2c_msg msg1 = { tpm_dev.client->addr, 0, len + 1, tpm_dev.buf };
+	struct i2c_msg msg1 = {
+			.addr = tpm_dev.client->addr,
+			.flags = 0,
+			.len = len + 1,
+			.buf = tpm_dev.buf
+	};
 
 	if (len > TPM_BUFSIZE)
 		return -EINVAL;
-- 
1.7.5.4
