From: Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] i2c: dev: prevent adapter retries being set as minus value
Date: Fri, 21 Dec 2018 17:32:06 +0800
Message-ID: <1545384726-12463-1-git-send-email-yizeng@asrmicro.com>
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
with no any error or information log print out.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/i2c/i2c-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 1aca742..c349f58 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -470,6 +470,14 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					  data_arg.data);
 	}
 	case I2C_RETRIES:
+		/*
+		 * The adapter->retries is defined as int type, and as
+		 * the upper limit for times of i2c transfer retry when
+		 * get -EAGAIN, it should not be set as minus value.
+		 */
+		if ((int)arg < 0)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-- 
1.9.1
