Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D570C433F5
	for <linux-i2c@archiver.kernel.org>; Tue, 31 May 2022 09:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiEaJcn (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 31 May 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiEaJcm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 May 2022 05:32:42 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA422B0C
        for <linux-i2c@vger.kernel.org>; Tue, 31 May 2022 02:32:40 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 24V9HLNb095917;
        Tue, 31 May 2022 17:17:21 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 May
 2022 17:31:46 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     <brendanhiggins@google.com>, <benh@kernel.crashing.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <linux-i2c@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c: aspeed: Fix slave mode unexpected irq handler
Date:   Tue, 31 May 2022 17:31:40 +0800
Message-ID: <20220531093140.28770-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 24V9HLNb095917
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

When i2c master send the new i2c transfer immediately
after stop. the i2c slave will see the stop and new
address match stage together. And it needs handle the
stop first. otherwise will occur unexpected handle
isr.

Fixes: f327c686d3ba ("i2c: aspeed: added drover for Aspeed I2C)
Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 771e53d3d197..9f21e090ce47 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -252,6 +252,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
+		if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP &&
+			bus->slave_state == ASPEED_I2C_SLAVE_WRITE_RECEIVED) {
+			irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+			irq_status &= ~ASPEED_I2CD_INTR_NORMAL_STOP;
+			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		}
 		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
-- 
2.17.1

