From: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Subject: [RESEND PATCH 1/3] i2c: added FUNC flag for unsupported clock stretching
Date: Wed, 16 Sep 2015 15:32:01 +0200
Message-ID: <1442410323-9833-1-git-send-email-nicola@corna.info>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added I2C_FUNC_NO_CLK_STRETCH, to be used when clock stretching is not
supported.

Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
---
 Documentation/i2c/functionality | 1 +
 include/uapi/linux/i2c.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index 4aae8ed..f53807e 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -21,6 +21,7 @@ For the most up-to-date list of functionality constants, please check
                                   I2C_M_REV_DIR_ADDR and I2C_M_NO_RD_ACK
                                   flags (which modify the I2C protocol!)
   I2C_FUNC_NOSTART                Can skip repeated start sequence
+  I2C_FUNC_NO_CLK_STRETCH         Does NOT support clock stretching
   I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
   I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
   I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index b0a7dd6..59e4b43 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -88,6 +88,7 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_PEC		0x00000008
 #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
 #define I2C_FUNC_SLAVE			0x00000020
+#define I2C_FUNC_NO_CLK_STRETCH		0x00000040 /* No check for SCL low */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
-- 
2.5.1
