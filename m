From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 01/18] i2c: guarantee that I2C_M_RD will be 0x0001 forever
Date: Sun,  3 Apr 2016 20:44:44 +0200
Message-ID: <1459709101-24462-2-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51890 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbcDCSpO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:14 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

There is code out there in user space and kernel space which relies on
I2C_M_RD being bit 0 to simplify their bit operations. Add a comment to
make sure this will never break. Do proper sorting of the defines while
we are here.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/uapi/linux/i2c.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index b0a7dd61eb353a..adcbef4bff610a 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -68,14 +68,15 @@
 struct i2c_msg {
 	__u16 addr;	/* slave address			*/
 	__u16 flags;
-#define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
 #define I2C_M_RD		0x0001	/* read data, from slave to master */
-#define I2C_M_STOP		0x8000	/* if I2C_FUNC_PROTOCOL_MANGLING */
-#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_NOSTART */
-#define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
-#define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
-#define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
+					/* I2C_M_RD is guaranteed to be 0x0001! */
+#define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
 #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
+#define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
+#define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
+#define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
+#define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_NOSTART */
+#define I2C_M_STOP		0x8000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 	__u16 len;		/* msg length				*/
 	__u8 *buf;		/* pointer to msg data			*/
 };
-- 
2.7.0
