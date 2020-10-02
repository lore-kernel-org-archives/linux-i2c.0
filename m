Return-Path: <SRS0=vGIj=DJ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E4C4363D
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Oct 2020 05:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BD8208A9
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Oct 2020 05:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601617820;
	bh=erD5Z14zGvV3vkBYk2EuYkPYBxMtW1Zib+FfBt1zqFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tpa5umCFtVanaj2CDMgjCRxSgzrzyA81WOXop35vnRXiQFtsiEOyI+pnDzrklGTq6
	 atblo0IO97PAelktQaKBQGqbtnKBgDx6mY58eiqLVRLUmf2L7kehM1FIJlsBx6ZYJA
	 oUFhg0I6bZ35W9J0OxT8gbaAN+HxJqQfFgAZ7Ozg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJBFt7 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 2 Oct 2020 01:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgJBFt7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Oct 2020 01:49:59 -0400
Received: from mail.kernel.org (ip5f5ad59f.dynamic.kabel-deutschland.de [95.90.213.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808EE208A9;
        Fri,  2 Oct 2020 05:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601617798;
        bh=erD5Z14zGvV3vkBYk2EuYkPYBxMtW1Zib+FfBt1zqFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcyzQkTA2UsBq9CMHMDFFtYqeeOaGGxXrtM23Bs7QkiMxyWKbc1tUTcGFhdAXIYPy
         N3ZlIB6NKJ8omnqmXxTq5Jn5eoa/Xwh5caK9wQp9zl5Tyk/zp5wfy2yimtnzjbjxRn
         8fRszpDRbeBL5FzAHS3Sf13nSM/J0bSf6yIBjrwI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kODx6-006hir-BD; Fri, 02 Oct 2020 07:49:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] docs: i2c: index.rst: add slave-testunit-backend.rst
Date:   Fri,  2 Oct 2020 07:49:48 +0200
Message-Id: <2ac6bd9d96cc4ff248d1c2e26a99f51a785eb271.1601616399.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601616399.git.mchehab+huawei@kernel.org>
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
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
index 8a2ad3845191..9b8df313902c 100644
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

