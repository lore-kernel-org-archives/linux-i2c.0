From: David Lechner <david@lechnology.com>
Subject: [PATCH 1/3] i2c: Add class for LEGO MINDSTORMS sensors
Date: Mon,  5 Sep 2016 15:40:12 -0500
Message-ID: <1473108014-30787-2-git-send-email-david@lechnology.com>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473108014-30787-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Lechner <david@lechnology.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

LEGO MINDSTORMS (robotics system from LEGO) has a number of sensors
that use I2C communications. These sensors have a well-know register
layout, so they are easily detected.

This class is being added so that future drivers for these sensors can
be automatically detected.

Signed-off-by: David Lechner <david@lechnology.com>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fffdc27..3eab858 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -638,6 +638,7 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
 #define I2C_CLASS_SPD		(1<<7)	/* Memory modules */
 #define I2C_CLASS_DEPRECATED	(1<<8)	/* Warn users that adapter will stop using classes */
+#define I2C_CLASS_LEGO		(1<<9)	/* LEGO MINDSTORMS sensors */
 
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU
-- 
2.7.4
