Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EEC43461
	for <linux-i2c@archiver.kernel.org>; Wed,  5 May 2021 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CE5613F6
	for <linux-i2c@archiver.kernel.org>; Wed,  5 May 2021 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhEEQ4B (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 5 May 2021 12:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236721AbhEEQue (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 5 May 2021 12:50:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E39E26195B;
        Wed,  5 May 2021 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232658;
        bh=IMJ8hZyHaeaxYIxJ3ChM/Z56gbfXgXe0IxNM/jf0ZWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcVGfc0Wvqzx5wicB3+b7jajui2CP4AqDnujnsAF5iHZXHNxLU2Fib+S9XPBsn1Hl
         Dz26mSPPxIDogftwK5KLpUXMFyC5GfTizcH24idSmAgnmNkFAnrZVuz15KXII5wZQP
         qL0tXd/d2LNRADoMYFDX/ACIpl3HsRKNI2RwRHRSB+nLFjAJNeZaQFc0/OkEBlhT6S
         Kx15sdvTzGdNtRAlwPARYHnT8DFMd3ll6+lXoDh+qFyhiTAO1a7jX+2A6o4feXI6rt
         6n/tsEg11M81JOoHJNY/nIRbawFIj4IyxU0F4JdqTlqBRGFtOetzQXupEKYqrpsOST
         exej3t7hkqiIw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 34/85] i2c: Add I2C_AQ_NO_REP_START adapter quirk
Date:   Wed,  5 May 2021 12:35:57 -0400
Message-Id: <20210505163648.3462507-34-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Bence Csókás <bence98@sch.bme.hu>

[ Upstream commit aca01415e076aa96cca0f801f4420ee5c10c660d ]

This quirk signifies that the adapter cannot do a repeated
START, it always issues a STOP condition after transfers.

Suggested-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/i2c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 56622658b215..a670ae129f4b 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -687,6 +687,8 @@ struct i2c_adapter_quirks {
 #define I2C_AQ_NO_ZERO_LEN_READ		BIT(5)
 #define I2C_AQ_NO_ZERO_LEN_WRITE	BIT(6)
 #define I2C_AQ_NO_ZERO_LEN		(I2C_AQ_NO_ZERO_LEN_READ | I2C_AQ_NO_ZERO_LEN_WRITE)
+/* adapter cannot do repeated START */
+#define I2C_AQ_NO_REP_START		BIT(7)
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
-- 
2.30.2

