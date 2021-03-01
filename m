Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197CEC433E0
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Mar 2021 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59B364E0F
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Mar 2021 01:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCABmC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 28 Feb 2021 20:42:02 -0500
Received: from m12-18.163.com ([220.181.12.18]:54374 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhCABmC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 28 Feb 2021 20:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kDMTl
        tJV0UkmO4l0O+sT6gpKJ2xCsE6xjbiDuhCa/oU=; b=DFe8pIjrdmY3xptNuLZnm
        w2iz1sq8/G4t+5DpiTMUDFPL6FR1Bjia93XL8f8J6gp1HzMSVcqaY+/n1m5JtJry
        SjhrQzsdq98SS3/7/a9houJUzpnqGBcrFhwYqD339r+sjUaXCWkXNNL4yh0BHQmV
        JllAUjxsLSrzKmxB5ZO7hw=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAAnLgoARjxgrMeSWQ--.49191S2;
        Mon, 01 Mar 2021 09:40:19 +0800 (CST)
From:   zuoqilin1@163.com
To:     jdelvare@suse.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] i2c: sis630: fix spellint typo
Date:   Mon,  1 Mar 2021 09:40:26 +0800
Message-Id: <20210301014026.289-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAnLgoARjxgrMeSWQ--.49191S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUXFyDCw4kuw13Wr43trb_yoWxCrcEkw
        1kCa1xur18u3WkA3WFqF98ZrnY9r1rur18C3WIgay3Cry5Zw13GF1kCw4fXr4DW3WUKF1j
        9w4jgF4xCrnFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU04GQDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipQNIiVUMci6q0gAAsa
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

change 'adress' to 'address'

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/i2c/busses/i2c-sis630.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index cfb8e04..87d5625 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -97,7 +97,7 @@
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
 
-/* SMBus base adress */
+/* SMBus base address */
 static unsigned short smbus_base;
 
 /* supported chips */
-- 
1.9.1


