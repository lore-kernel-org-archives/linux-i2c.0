Return-Path: <SRS0=nYWz=77=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77DC433E0
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C33E20776
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448698;
	bh=rs5tw5dIQlpsvjlC1Io34WSHTvkyHWjgZTfHxcbFBhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzaGfIJCdlss8k9/112Eh1JZ4ORKDRGKLIYdnSd8bquEi5Hby+q7J50vKcb4QDGdj
	 c1TNQ3N/U3BTl5Up2deE1G2SoYeB3dgndnmk3R3m1axT67iV7D9ztcxyUsRU3U7q6B
	 JjVnQ7gVzZU/Zmvp55BrRY1/Dr6ve5cLA3uzMbiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgFRBI4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgFRBIz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A29021D7E;
        Thu, 18 Jun 2020 01:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442534;
        bh=rs5tw5dIQlpsvjlC1Io34WSHTvkyHWjgZTfHxcbFBhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivBDjBDbqy+4HGP/VbhO1Q95cGYsdVft8QnLO5zXVVvcLX8JnXQ3p29FwdP1o/Dcj
         KSuIdwYwFuJG7VD2OyOyj4aw93V3Vz2Nx4uN5sdxSryzbLiL1w/NUcZHbWlnDMv4te
         KOocuDFeUtpW1zqW0c6PO/8612N0dAyZIFIVXdSg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 037/388] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Wed, 17 Jun 2020 21:02:14 -0400
Message-Id: <20200618010805.600873-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit e81c979f4e071d516aa27cf5a0c3939da00dc1ca ]

If we timeout during a message transfer, the control register may
contain bits that cause an action to be set. Read-modify-writing the
register leaving these bits set may trigger the hardware to attempt
one of these actions unintentionally.

Always clear these bits when cleaning up after a message or after
a timeout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 466e4f681d7a..30a6e07212a4 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -747,11 +747,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
 {
 	u32 icr;
 
-	/*
-	 * Clear the STOP and ACK flags
-	 */
+	/* Clear the START, STOP, ACK, TB and MA flags */
 	icr = readl(_ICR(i2c));
-	icr &= ~(ICR_STOP | ICR_ACKNAK);
+	icr &= ~(ICR_START | ICR_STOP | ICR_ACKNAK | ICR_TB | ICR_MA);
 	writel(icr, _ICR(i2c));
 }
 
-- 
2.25.1

