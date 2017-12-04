From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: algo-bit: init the bus to a known state
Date: Mon,  4 Dec 2017 09:16:18 +0100
Message-ID: <20171204081618.5922-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43347 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdLDIQ1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 03:16:27 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Ensure the bus is free when we register the adapter. Before the SCL/SDA
wires were in an unknown state. It used to work because sending a byte
has a retry mechanism which was triggered if the bus was initially in a
not-free state. But the graceful way to do it is to initialize
correctly, of course.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Found while working with the I2C GPIO fault injector. SCL was initially low
before, so it only worked on the second try.

 drivers/i2c/algos/i2c-algo-bit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 1147bddb8b2c8a..3df0efd69ae336 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -649,6 +649,11 @@ static int __i2c_bit_add_bus(struct i2c_adapter *adap,
 	if (bit_adap->getscl == NULL)
 		adap->quirks = &i2c_bit_quirk_no_clk_stretch;
 
+	/* Bring bus to a known state. Looks like STOP if bus is not free yet */
+	setscl(bit_adap, 1);
+	udelay(bit_adap->udelay);
+	setsda(bit_adap, 1);
+
 	ret = add_adapter(adap);
 	if (ret < 0)
 		return ret;
-- 
2.11.0
