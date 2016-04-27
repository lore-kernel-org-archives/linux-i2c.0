From: Thomas Zimmermann <tdz@users.sourceforge.net>
Subject: [PATCH] i2c: Raise SDA for each received bit, if necessary
Date: Wed, 27 Apr 2016 20:11:54 +0200
Message-ID: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34642 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbcD0SMt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 14:12:49 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Zimmermann <tdz@users.sourceforge.net>

Some I2C adapters don't raise SDA by themselves when sending a bit. This
behavior can be seen with the DDC channel of SiS 300 graphics cards.

This patch adds the flag |set_sdahi| to |struct i2c_algo_bit_data|. With
the flags set to true, the I2C bit algo will raise SDA before reading each
bit from the bus. With the flag set to false, the bit algo will keep its
current behavior of raising SDA only once before receiving a full byte.

The flag also ensures that |acknak| is always called with SDA raised.

Signed-off-by: Thomas Zimmermann <tdz@users.sourceforge.net>
---
 drivers/i2c/algos/i2c-algo-bit.c | 2 ++
 include/linux/i2c-algo-bit.h     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 9d233bb..aa8cf33 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -224,6 +224,8 @@ static int i2c_inb(struct i2c_adapter *i2c_adap)
 			indata |= 0x01;
 		setscl(adap, 0);
 		udelay(i == 7 ? adap->udelay / 2 : adap->udelay);
+		if (adap->set_sdahi)
+			sdahi(adap);
 	}
 	/* assert: scl is low */
 	return indata;
diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index 63904ba..e9f0a59 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -46,6 +46,11 @@ struct i2c_algo_bit_data {
 				   minimum 5 us for standard-mode I2C and SMBus,
 				   maximum 50 us for SMBus */
 	int timeout;		/* in jiffies */
+
+	/* Some adapters do not raise SDA by themselves when sending. Set
+	 * this flag to raise SDA before reading each bit.
+	 */
+	bool set_sdahi;
 };
 
 int i2c_bit_add_bus(struct i2c_adapter *);
-- 
2.1.4
