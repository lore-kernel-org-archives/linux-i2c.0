Return-Path: <SRS0=nYWz=77=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A7C433E1
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C540B20B1F
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Jun 2020 02:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445932;
	bh=vISulG17zn1hnsebsxv/42UOPuhkUap0AVaKQ55VhEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QgAj1frr7nKmo7IQsUhxurIwIWWZ42icbLAS4zYDPMRZscryqt5uQ+22aKJtdL6bT
	 hS6UvzoGhHR2kZPcc7O0GUdGj1CF6W7YZKe8z7kfyWE6pJQJfOhoyyZo0h7gMIcnBw
	 0JiYVHmjNzvSSusBDWFcLKm9FAdJ5z2ldCwXL61Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgFRCF2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbgFRBWp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A789020CC7;
        Thu, 18 Jun 2020 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443365;
        bh=vISulG17zn1hnsebsxv/42UOPuhkUap0AVaKQ55VhEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt9ONg1vFLhYUjVJ1rBALk8XVeeP+L6Wz3v44aoIElwRdGvvZ225Z2f3rcKOfkUJr
         osFZTnhio3lilP9yDkpqk6e9R/SjABzLii7l6rKi1thIxKU0xYYNTXq93pRjwDefN8
         4M0ryLDFOOZBrgdGdmqjjxX0BMStHfMb1VvHmbKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 021/172] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Wed, 17 Jun 2020 21:19:47 -0400
Message-Id: <20200618012218.607130-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
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
index fbf91d383b40..7248ba6763e4 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -709,11 +709,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
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

