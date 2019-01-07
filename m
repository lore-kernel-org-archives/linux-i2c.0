From: Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] i2c: dev: prevent adapter retries and timeout being set as minus value
Date: Mon, 7 Jan 2019 20:37:41 +0800
Message-ID: <1546864661-19407-1-git-send-email-yizeng@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yi Zeng <yizeng@asrmicro.com>
List-Id: linux-i2c@vger.kernel.org

If set adapter->retries to minus value from user space via ioctl,
will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
adapter->algo->master_xfer and adapter->algo->smbus_xfer that
registered by the underlying bus drivers, and return value 0 to
all the callers. The bus driver will never be accessed anymore by
all users, besides, the users may still get successful return value
without any error or information log print out.

If set adapter->timeout to minus value from user space via ioctl,
will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
always break after the the first try, due to the time_after always
returns true.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/i2c/i2c-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 1aca742..14d01f5 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -470,9 +470,15 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					  data_arg.data);
 	}
 	case I2C_RETRIES:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
+		if (arg > INT_MAX)
+                        return -EINVAL;
+
 		/* For historical reasons, user-space sets the timeout
 		 * value in units of 10 ms.
 		 */
-- 
1.9.1
