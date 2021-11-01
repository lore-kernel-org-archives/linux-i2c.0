Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F2C433F5
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Nov 2021 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DBB610CF
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Nov 2021 09:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhKAJHJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 1 Nov 2021 05:07:09 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:44110 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKAJHI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 1 Nov 2021 05:07:08 -0400
Received: by codeconstruct.com.au (Postfix, from userid 10001)
        id DB5BC202B9; Mon,  1 Nov 2021 17:04:33 +0800 (AWST)
From:   Matt Johnston <matt@codeconstruct.com.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, Wolfram Sang <wsa@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 3/6] i2c: aspeed: Allow 255 byte block transfers
Date:   Mon,  1 Nov 2021 17:04:02 +0800
Message-Id: <20211101090405.1405987-4-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101090405.1405987-1-matt@codeconstruct.com.au>
References: <20211101090405.1405987-1-matt@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

255 byte transfers have been tested on an AST2500 board

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..7395f3702fae 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -533,7 +533,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		msg->buf[bus->buf_index++] = recv_byte;
 
 		if (msg->flags & I2C_M_RECV_LEN) {
-			if (unlikely(recv_byte > I2C_SMBUS_BLOCK_MAX)) {
+			if (unlikely(recv_byte > I2C_SMBUS_V3_BLOCK_MAX)) {
 				bus->cmd_err = -EPROTO;
 				aspeed_i2c_do_stop(bus);
 				goto out_no_complete;
@@ -718,7 +718,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 
 static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_V3_BLOCK;
 }
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-- 
2.32.0

