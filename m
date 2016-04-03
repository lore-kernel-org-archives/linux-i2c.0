From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 02/18] i2c: introduce helper function to get 8 bit address from a message
Date: Sun,  3 Apr 2016 20:44:45 +0200
Message-ID: <1459709101-24462-3-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51892 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbcDCSpP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:15 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Drivers do this in various ways, let's use one standard way of doing it.
Note: I2C_M_RD is bit 0, so the code could be simplified. To be extremly
robust and to advertise good coding practices, I still use the ternary
operator and let the compilers do the optimizing job.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 200cf13b00f620..c30833b7b0730d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -654,6 +654,11 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
 	return adap->nr;
 }
 
+static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
+{
+	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
+}
+
 /**
  * module_i2c_driver() - Helper macro for registering a modular I2C driver
  * @__i2c_driver: i2c_driver struct
-- 
2.7.0
