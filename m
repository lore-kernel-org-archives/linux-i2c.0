Return-Path: <SRS0=ZJhJ=DV=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE1C433DF
	for <linux-i2c@archiver.kernel.org>; Wed, 14 Oct 2020 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2D9221EB
	for <linux-i2c@archiver.kernel.org>; Wed, 14 Oct 2020 16:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgJNQSA (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:18:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50472 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731838AbgJNQR6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Oct 2020 12:17:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@nvidia.com)
        with SMTP; 14 Oct 2020 19:17:53 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 09EGHnjX007559;
        Wed, 14 Oct 2020 19:17:52 +0300
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH 3/6] i2c: mux: mlxcpld: Move header file out of x86 realm
Date:   Wed, 14 Oct 2020 19:17:44 +0300
Message-Id: <20201014161747.31926-4-vadimp@nvidia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201014161747.31926-1-vadimp@nvidia.com>
References: <20201014161747.31926-1-vadimp@nvidia.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Move out header file from include/linux/platform_data/x86/ to
include/linux/platform_data/, since it does not depend on x86
architecture.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Michael Shych <michaelsh@nvidia.com>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c             | 2 +-
 include/linux/platform_data/{x86 => }/mlxcpld.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/platform_data/{x86 => }/mlxcpld.h (100%)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index 53bce81cf5c9..3d894cfb19df 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/platform_data/x86/mlxcpld.h>
+#include <linux/platform_data/mlxcpld.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/include/linux/platform_data/x86/mlxcpld.h b/include/linux/platform_data/mlxcpld.h
similarity index 100%
rename from include/linux/platform_data/x86/mlxcpld.h
rename to include/linux/platform_data/mlxcpld.h
-- 
2.11.0

