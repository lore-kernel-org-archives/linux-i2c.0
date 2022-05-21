Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2CC43217
	for <linux-i2c@archiver.kernel.org>; Sat, 21 May 2022 11:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354955AbiEULNR (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 21 May 2022 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354828AbiEULMl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 21 May 2022 07:12:41 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE13EA85;
        Sat, 21 May 2022 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9wrNYIqEvyrnG9iiMAt+K7orQjSJi1d7S7pYQrFwucI=;
  b=EfF0aOKSs4g3wIIaklisoXUwQF+siyCP+iLoqh8+Ts2ANXeSXtlxpOEA
   8bv0ot52CkAASAgnLiwGstKTOL4eDALptGDX26OB47+hXzgWv8zq39RdM
   PWFAHHjMxXGD9P9el3K+BOta4etD1Bg8i2WNj1vcy5Rg/50IzYrWSLOmy
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727955"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:01 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: meson: fix typo in comment
Date:   Sat, 21 May 2022 13:11:03 +0200
Message-Id: <20220521111145.81697-53-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/i2c/busses/i2c-meson.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 195a9716da31..61cc5b2462c6 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -82,7 +82,7 @@ enum {
  * @done:	Completion used to wait for transfer termination
  * @tokens:	Sequence of tokens to be written to the device
  * @num_tokens:	Number of tokens
- * @data:	Pointer to the controlller's platform data
+ * @data:	Pointer to the controller's platform data
  */
 struct meson_i2c {
 	struct i2c_adapter	adap;

