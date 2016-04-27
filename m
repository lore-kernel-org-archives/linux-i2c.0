From: Michele Curti <michele.curti@gmail.com>
Subject: [PATCH] i2c-algo-bit: declare i2c_bit_quirk_no_clk_stretch as static
Date: Wed, 27 Apr 2016 21:37:51 +0200
Message-ID: <1461785871-22530-1-git-send-email-michele.curti@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36390 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbcD0TiS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 15:38:18 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Michele Curti <michele.curti@gmail.com>

i2c_bit_quirk_no_clk_stretch is used in i2c-algo-bit.c only, so
declare it as static.

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 drivers/i2c/algos/i2c-algo-bit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 9d233bb..a8e89df 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -617,7 +617,7 @@ const struct i2c_algorithm i2c_bit_algo = {
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
-const struct i2c_adapter_quirks i2c_bit_quirk_no_clk_stretch = {
+static const struct i2c_adapter_quirks i2c_bit_quirk_no_clk_stretch = {
 	.flags = I2C_AQ_NO_CLK_STRETCH,
 };
 
-- 
2.8.0
