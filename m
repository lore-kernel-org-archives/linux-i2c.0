Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12CC6FA89
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Sep 2022 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIHRgC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 8 Sep 2022 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiIHRgA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Sep 2022 13:36:00 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6795BBADAC
        for <linux-i2c@vger.kernel.org>; Thu,  8 Sep 2022 10:35:56 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 8 Sep 2022 20:35:54 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 288HZrVF026077;
        Thu, 8 Sep 2022 13:35:53 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 288HZroT032719;
        Thu, 8 Sep 2022 13:35:53 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Khalil Blaiech <kblaiech@nvidia.com>
Subject: [PATCH v3 6/9] i2c-mlxbf.c: Update SPDX license
Date:   Thu,  8 Sep 2022 13:35:41 -0400
Message-Id: <20220908173544.32615-7-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220908173544.32615-1-asmaa@nvidia.com>
References: <20220908173544.32615-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Update the SPDX license to GPL-2.0 or BSD-3-Clause and
update the copyright to NVIDIA CORPORATION.

Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index b54019b4b01b..1982286b9b22 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -1,9 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Mellanox BlueField I2C bus driver
- *
- *  Copyright (C) 2020 Mellanox Technologies, Ltd.
- */
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*  Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved. */
 
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
@@ -2487,4 +2483,4 @@ module_exit(mlxbf_i2c_exit);
 
 MODULE_DESCRIPTION("Mellanox BlueField I2C bus driver");
 MODULE_AUTHOR("Khalil Blaiech <kblaiech@nvidia.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

