From: Alexander Popov <alex.popov@linux.com>
Subject: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()
Date: Thu, 19 Apr 2018 15:29:22 +0300
Message-ID: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com, Alexander Popov <alex.popov@linux.com>
List-Id: linux-i2c@vger.kernel.org

i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
returns ZERO_SIZE_PTR if i2c_msg.len is zero.

Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
case of zero len.

Let's check the len against zero before dereferencing buf pointer.

This issue was triggered by syzkaller.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/i2c/i2c-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 036a03f..5790bc8 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		 */
 		if (msgs[i].flags & I2C_M_RECV_LEN) {
 			if (!(msgs[i].flags & I2C_M_RD) ||
+			    !msgs[i].len ||
 			    msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
-- 
2.7.4
