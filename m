Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40717C4338F
	for <linux-i2c@archiver.kernel.org>; Tue, 27 Jul 2021 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B420619E5
	for <linux-i2c@archiver.kernel.org>; Tue, 27 Jul 2021 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhG0LQM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 27 Jul 2021 07:16:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:41871 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhG0LQM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Jul 2021 07:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627384572; x=1658920572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmOuN2SVEtSgfrh3uY3qWbumcwZ7+Y6c5mA+/uQGPx4=;
  b=Z+dsao88OVp5CYDgMgmq7BiLVqlsD6kUqnQU4428ERKebM5xMqBkFrP3
   RnmETo49Rmg/9adt3RHDYxtZApUTyWvMBI1hyEcQsHcMusHiOsYh1uhGZ
   +fL9T9rAndwas+tXEiSKj9DHHLFmYn13y+T1tVpT5AvM71V9qGkEVyZ0y
   zz2dkTYLfyDzVzA1gg875Xm40JletZb64jvUL7kMbNlaOvLnLWCFfg6la
   3QZqFQJ9dUhSb2RSJn1j7UuVTBUQEC6evjzoNc8WRb8aVVUrGrSxmi52x
   G3uLZRDFnEb3WQF92E6uf1NPvlNqTecfB3cMdcEtRsrqvX/v7ODfRddsq
   w==;
IronPort-SDR: okGvVLCzbmU3BhDmS3Fi/GveNvMwePKJVkXXSMG3FK9SkdeXKXitFXLuoXC6Yvixex2gyJwz6s
 /ltff842MnPKvs+BmhRxbpUCyKbnLj1xONtWnjtJ4o4hzH6wa40E8M55NEgT3IxsMI+UJgcn3c
 6k7WqQswwY7zZOs1AKLt9OvucO9aRiGeUgaxjJF6XGGUPOrlrw1tQ8OVZY/yM0B1iKhzU89rj/
 XgxnnNXX4SXG4l1KG0GTf8kxgxQgwAJ/Plh9rNfXeGmI1rkZaz/q3oAPSBjglr0OOOaVLkAevi
 I8C8YS7APRmWeIUqFUB5gKeK
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="126088286"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 04:16:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 04:16:11 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 04:16:08 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <andrew@sanpeople.com>,
        <mhoffman@lightlink.com>, <khali@linux-fr.org>, <wsa@kernel.org>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/3] i2c: at91: move i2c_recover_bus() outside of at91_do_twi_transfer()
Date:   Tue, 27 Jul 2021 14:15:52 +0300
Message-ID: <20210727111554.1338832-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727111554.1338832-1-codrin.ciubotariu@microchip.com>
References: <20210727111554.1338832-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This patch doesn't add a functional change, it just separates the recovery
from the transfer itself.

Fixes: d3d3fdcc4c90 ("i2c: at91: implement i2c bus recovery")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/i2c/busses/i2c-at91-master.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 1cceb6866689..0352dc09d697 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -639,13 +639,6 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
 	}
 
-	/*
-	 * some faulty I2C slave devices might hold SDA down;
-	 * we can send a bus clear command, hoping that the pins will be
-	 * released
-	 */
-	i2c_recover_bus(&dev->adapter);
-
 	return ret;
 }
 
@@ -705,7 +698,17 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 
 	ret = at91_do_twi_transfer(dev);
 
-	ret = (ret < 0) ? ret : num;
+	if (ret < 0) {
+		/*
+		 * some faulty I2C slave devices might hold SDA down;
+		 * we can send a bus clear command, hoping that the pins will be
+		 * released
+		 */
+		i2c_recover_bus(&dev->adapter);
+	} else {
+		ret = num;
+	}
+
 out:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.30.2

