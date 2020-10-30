Return-Path: <SRS0=QIrR=EF=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91147C55178
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Oct 2020 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA432220B
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Oct 2020 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vivotek.com header.i=@vivotek.com header.b="LLqN5uo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJ3IFK (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 30 Oct 2020 04:05:10 -0400
Received: from mail.vivotek.com ([60.248.39.150]:48976 "EHLO mail.vivotek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgJ3IFJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 30 Oct 2020 04:05:09 -0400
Received: from pps.filterd (vivotekpps.vivotek.com [127.0.0.1])
        by vivotekpps.vivotek.com (8.16.0.42/8.16.0.42) with SMTP id 09U80pmG015590;
        Fri, 30 Oct 2020 16:04:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivotek.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dkim; bh=haBC6u549wV1SGx7x8NxZx0dE+7utpQPKnJQ1yGehDE=;
 b=LLqN5uo5N9bdd736Kjb7g2RgQrW+7Rf3aAoXtOQlDzWdSC30t4ok8t/agZ2bBAKVHCet
 WRs7/oFFzUt3sPv2mPIhPLNaPL6pFFMVlQ95vUeG2s7IQRMgxqRzOsiuHze13Omi6H5I
 7UgBotyxSPaZg3daGn5Sj5PrKM6kZAD9nWg= 
Received: from cas01.vivotek.tw ([192.168.0.58])
        by vivotekpps.vivotek.com with ESMTP id 34c6q166qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 16:04:56 +0800
Received: from localhost.localdomain (192.168.17.134) by CAS01.vivotek.tw
 (192.168.0.58) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 30 Oct
 2020 16:04:56 +0800
From:   Michael Wu <michael.wu@vatics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Morgan Chang <morgan.chang@vatics.com>,
        Michael Wu <michael.wu@vatics.com>
Subject: [PATCH 1/2] i2c: designware: call i2c_dw_read_clear_intrbits_slave() once
Date:   Fri, 30 Oct 2020 16:04:19 +0800
Message-ID: <20201030080420.28016-2-michael.wu@vatics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030080420.28016-1-michael.wu@vatics.com>
References: <20201030080420.28016-1-michael.wu@vatics.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.17.134]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

If some bits were cleared by i2c_dw_read_clear_intrbits_slave() in
i2c_dw_isr_slave() and not handled immediately, those cleared bits would
not be shown again by later i2c_dw_read_clear_intrbits_slave(). They
therefore were forgotten to be handled.

i2c_dw_read_clear_intrbits_slave() should be called once in an ISR and take
its returned state for all later handlings.

Signed-off-by: Michael Wu <michael.wu@vatics.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 44974b53a626..13de01a0f75f 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -159,7 +159,6 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 	u32 raw_stat, stat, enabled, tmp;
 	u8 val = 0, slave_activity;
 
-	regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
 	regmap_read(dev->map, DW_IC_ENABLE, &enabled);
 	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &raw_stat);
 	regmap_read(dev->map, DW_IC_STATUS, &tmp);
@@ -168,6 +167,7 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY) || !dev->slave)
 		return 0;
 
+	stat = i2c_dw_read_clear_intrbits_slave(dev);
 	dev_dbg(dev->dev,
 		"%#x STATUS SLAVE_ACTIVITY=%#x : RAW_INTR_STAT=%#x : INTR_STAT=%#x\n",
 		enabled, slave_activity, raw_stat, stat);
@@ -188,11 +188,9 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 						 val);
 				}
 				regmap_read(dev->map, DW_IC_CLR_RD_REQ, &tmp);
-				stat = i2c_dw_read_clear_intrbits_slave(dev);
 			} else {
 				regmap_read(dev->map, DW_IC_CLR_RD_REQ, &tmp);
 				regmap_read(dev->map, DW_IC_CLR_RX_UNDER, &tmp);
-				stat = i2c_dw_read_clear_intrbits_slave(dev);
 			}
 			if (!i2c_slave_event(dev->slave,
 					     I2C_SLAVE_READ_REQUESTED,
@@ -207,7 +205,6 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 			regmap_read(dev->map, DW_IC_CLR_RX_DONE, &tmp);
 
 		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
-		stat = i2c_dw_read_clear_intrbits_slave(dev);
 		return 1;
 	}
 
@@ -219,7 +216,6 @@ static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
 			dev_vdbg(dev->dev, "Byte %X acked!", val);
 	} else {
 		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &val);
-		stat = i2c_dw_read_clear_intrbits_slave(dev);
 	}
 
 	return 1;
@@ -230,7 +226,6 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
 	struct dw_i2c_dev *dev = dev_id;
 	int ret;
 
-	i2c_dw_read_clear_intrbits_slave(dev);
 	ret = i2c_dw_irq_handler_slave(dev);
 	if (ret > 0)
 		complete(&dev->cmd_complete);
-- 
2.17.1

