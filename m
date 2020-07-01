Return-Path: <SRS0=34xP=AM=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D2C433E0
	for <linux-i2c@archiver.kernel.org>; Wed,  1 Jul 2020 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAAE20775
	for <linux-i2c@archiver.kernel.org>; Wed,  1 Jul 2020 08:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ClM1GuWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGAIXY (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:23:24 -0400
Received: from www.zeus03.de ([194.117.254.33]:57940 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgGAIXY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Jul 2020 04:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=VMejF4y6Vc0djRDb4MWJtalBr3x
        lXhV5o+8dnxN2I10=; b=ClM1GuWugpD6rfZ/6tVIFYECiS8gUgbT8HmO/WY0hMc
        sr3UgR4D1o/5W7n+2I70E+Oj7lmb8f4Z9o5eMfrqm3M0lWg7WAXCH57i4SgXs3vI
        PAy4vzejU+UMKQQcS8wd73jVLi8YwLYCUC06JIeppYC3Hs5qg0KqP+5g48TkN0gI
        =
Received: (qmail 465500 invoked from network); 1 Jul 2020 10:23:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2020 10:23:22 +0200
X-UD-Smtp-Session: l3s3148p1@749QAV2pcNkgAwDPXwRGALjtBlSZf+V/
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Alain Volmat <alain.volmat@st.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: core: do not use logical device when creating irq domain
Date:   Wed,  1 Jul 2020 10:23:18 +0200
Message-Id: <20200701082318.11174-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Let's rather use its physical parent device to give proper namings and
connections in debugfs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This turns the name from "unknown-1" to ":soc:i2c@e6540000" in debugfs
for my use case.

@Benjamin: I am not aware of any other side effects or regression
possibilites. Do you see any?

 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index dc43242a85ba..69217d2193da 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1227,7 +1227,7 @@ static int i2c_setup_host_notify_irq_domain(struct i2c_adapter *adap)
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_HOST_NOTIFY))
 		return 0;
 
-	domain = irq_domain_create_linear(adap->dev.fwnode,
+	domain = irq_domain_create_linear(adap->dev.parent->fwnode,
 					  I2C_ADDR_7BITS_COUNT,
 					  &i2c_host_notify_irq_ops, adap);
 	if (!domain)
-- 
2.20.1

