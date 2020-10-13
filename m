Return-Path: <SRS0=VWDi=DU=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1895C43467
	for <linux-i2c@archiver.kernel.org>; Tue, 13 Oct 2020 12:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758D0222E7
	for <linux-i2c@archiver.kernel.org>; Tue, 13 Oct 2020 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602591379;
	bh=GiA/YK+LRhCnfgr+mmOKXZFT0B03NQNNFawIJNWdA6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w4PlMydEbIAUYjjyYgsHX5/jE18GEOOzR9igpB9jbp36x5sJjF1mULjezPn4t/G5p
	 i7uel2WC8g004bBzXGFfQlnwNcfyPv64wswk7soEKZzFjmmlvr9fkCEFuCSXJDcogQ
	 B2b9Fkf6UuJvP53q3+U9Q2d1A81N9OT0LrStbtM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJMMO5 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgJMMO4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:56 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D4F22251;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=GiA/YK+LRhCnfgr+mmOKXZFT0B03NQNNFawIJNWdA6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bxs+qOye1CX7hx51E+7Uzhg1J7AwTzRNMW4OJkUlSZFFw/LjqWoDxzp/oTVopO2dt
         uITOc8WxWEyubN1EmPU2vnE42OYRAzB+12ReA0Rhls7FBR1Uwzn5fimHLpg45FGyyP
         niBHbhbDoecYxtl7foW3rQM2fxR0t4IdItAecrBc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCf-006CoI-1N; Tue, 13 Oct 2020 14:14:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] docs: i2c: index.rst: add slave-testunit-backend.rst
Date:   Tue, 13 Oct 2020 14:14:40 +0200
Message-Id: <8b46f6d001962e7b562c3542eb4449bd905f448a.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

As warned by Sphinx:

	.../Documentation/i2c/slave-testunit-backend.rst: WARNING: document isn't included in any toctree

This document is not included anywhere.

Fixes: a8335c64c5f0 ("i2c: add slave testunit driver")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 3 +--
 Documentation/i2c/index.rst                     | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
index adc4ecc72361..f794e2b1096c 100644
--- a/Documentation/admin-guide/hw-vuln/l1d_flush.rst
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -22,8 +22,7 @@ mechanism
 Usage Guidelines
 ----------------
 
-Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst` for
-details.
+Please see document: :doc:`/userspace-api/spec_ctrl` for details.
 
 **NOTE**: The feature is disabled by default, applications need to
 specifically opt into the feature to enable it.
diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
index 8b76217e370a..c8bf6f7d5286 100644
--- a/Documentation/i2c/index.rst
+++ b/Documentation/i2c/index.rst
@@ -38,6 +38,7 @@ Debugging
 
    gpio-fault-injection
    i2c-stub
+   slave-testunit-backend
 
 Slave I2C
 =========
-- 
2.26.2

