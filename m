Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26592C4338F
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Jul 2021 13:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0473260240
	for <linux-i2c@archiver.kernel.org>; Fri, 30 Jul 2021 13:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhG3NHE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:07:04 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:53162 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhG3NHE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 30 Jul 2021 09:07:04 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 09:07:04 EDT
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6DFEE440A0A;
        Fri, 30 Jul 2021 15:58:05 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     linux-i2c@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.de>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH i2c-tools] Makefile: drop KERNELVERSION
Date:   Fri, 30 Jul 2021 15:58:00 +0300
Message-Id: <b04c0610e6b0c16c555a1578dee24b1b022bbd1c.1627649880.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

KERNELVERSION is unused since commit 4b89e48a1039f ("Delete the
decode-xeon script...").

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index e784921f9f98..5ac8a59dd390 100644
--- a/Makefile
+++ b/Makefile
@@ -50,8 +50,6 @@ USE_STATIC_LIB := 1
 endif
 endif
 
-KERNELVERSION	:= $(shell uname -r)
-
 .PHONY: all strip clean install uninstall
 
 all:
-- 
2.30.2

