From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2] i2c: algo-bit: add support for I2C_M_STOP
Date: Wed, 21 Jun 2017 09:24:02 +0200
Message-ID: <20170621092402.773a4b14@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38169 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751093AbdFUHYF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Jun 2017 03:24:05 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org

Support for enforced STOPs will allow us to use SCCB compatible devices.

Based on a preliminary patch by Wolfram Sang.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since v1:
 * Simplify logic

 drivers/i2c/algos/i2c-algo-bit.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- linux-4.11.orig/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 09:57:17.949074198 +0200
+++ linux-4.11/drivers/i2c/algos/i2c-algo-bit.c	2017-06-21 09:07:07.910049960 +0200
@@ -553,9 +553,18 @@ static int bit_xfer(struct i2c_adapter *
 		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
 			if (i) {
-				bit_dbg(3, &i2c_adap->dev, "emitting "
-					"repeated start condition\n");
-				i2c_repstart(adap);
+				if (msgs[i - 1].flags & I2C_M_STOP) {
+					bit_dbg(3, &i2c_adap->dev,
+						"emitting enforced stop condition\n");
+					i2c_stop(adap);
+					bit_dbg(3, &i2c_adap->dev,
+						"emitting start condition\n");
+					i2c_start(adap);
+				} else {
+					bit_dbg(3, &i2c_adap->dev,
+						"emitting repeated start condition\n");
+					i2c_repstart(adap);
+				}
 			}
 			ret = bit_doAddress(i2c_adap, pmsg);
 			if ((ret != 0) && !nak_ok) {


-- 
Jean Delvare
SUSE L3 Support
