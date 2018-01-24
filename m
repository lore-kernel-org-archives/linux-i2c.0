From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH] i2c: meson: update doc description to fix build warnings
Date: Wed, 24 Jan 2018 15:05:14 +0800
Message-ID: <20180124070514.183119-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:55059 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbeAXHEz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Jan 2018 02:04:55 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Add description for 'data' parameter and drop unused 'irq' memeber.

Here is the warnings:
drivers/i2c/busses/i2c-meson.c:103: warning: No description found for
parameter 'data'
drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq'
description in 'meson_i2c'

Suggested-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/i2c/busses/i2c-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 37c4aa76f37a..90f5d0407d73 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -69,7 +69,6 @@ struct meson_i2c_data {
  * @dev:	Pointer to device structure
  * @regs:	Base address of the device memory mapped registers
  * @clk:	Pointer to clock structure
- * @irq:	IRQ number
  * @msg:	Pointer to the current I2C message
  * @state:	Current state in the driver state machine
  * @last:	Flag set for the last message in the transfer
@@ -80,6 +79,7 @@ struct meson_i2c_data {
  * @done:	Completion used to wait for transfer termination
  * @tokens:	Sequence of tokens to be written to the device
  * @num_tokens:	Number of tokens
+ * @data:	Pointer to the controlller's platform data
  */
 struct meson_i2c {
 	struct i2c_adapter	adap;
-- 
2.15.1
