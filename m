Return-Path: <SRS0=vGIj=DJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D4C4363D
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Oct 2020 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B2E20719
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Oct 2020 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ae3uTnKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBMpI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:45:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:42856 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387749AbgJBMpH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Oct 2020 08:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=EPCTi5rHIoFDjL/r1UZ6qUhIGuK
        JTv8SCNCKelJa6IY=; b=Ae3uTnKFWJ9G5tlVHPx08dw1uRS5fdXMhZJg17MMMNB
        QOskNFE6je3kg6VCnhnE9QxgrVIQmF92KNV9FWNzdq6lArnAB6Lx7g0cCElAULVq
        U+Z8xS2w611/642tmGu1ZmL1GgIWNrhJ5iselEvnHDHJ0xvTNjVLm9AHbyIaSP/E
        =
Received: (qmail 1384133 invoked from network); 2 Oct 2020 14:45:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Oct 2020 14:45:04 +0200
X-UD-Smtp-Session: l3s3148p1@vKN7gK+wIsQgAwDPXwkAADD+YGrDqBUE
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] Documentation: i2c: add testunit docs to index
Date:   Fri,  2 Oct 2020 14:44:58 +0200
Message-Id: <20201002124458.3059-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Fixes: a8335c64c5f0 ("i2c: add slave testunit driver")
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
index 8a2ad3845191..8b76217e370a 100644
--- a/Documentation/i2c/index.rst
+++ b/Documentation/i2c/index.rst
@@ -47,6 +47,7 @@ Slave I2C
 
    slave-interface
    slave-eeprom-backend
+   slave-testunit-backend
 
 Advanced topics
 ===============
-- 
2.28.0

