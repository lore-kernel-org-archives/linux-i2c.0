Return-Path: <SRS0=I2vO=DM=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC6C4741F
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FABA20848
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgJENEL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJENEK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Oct 2020 09:04:10 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3EC0613AD
        for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2020 05:54:54 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id cCpr2300d4C55Sk01CpsPl; Mon, 05 Oct 2020 14:49:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPw7-0006ZN-Tg; Mon, 05 Oct 2020 14:49:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPPw7-0006z9-RL; Mon, 05 Oct 2020 14:49:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Khalil Blaiech <kblaiech@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: mlxbf: I2C_MLXBF should depend on MELLANOX_PLATFORM
Date:   Mon,  5 Oct 2020 14:49:49 +0200
Message-Id: <20201005124949.26810-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The Mellanox BlueField I2C controller is only present on Mellanox
BlueField SoCs.  Hence add a dependency on MELLANOX_PLATFORM, to prevent
asking the user about this driver when configuring a kernel without
Mellanox platform support.

Fixes: b5b5b32081cd206b ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 96685b273f637176..424dee8b33600057 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -732,7 +732,7 @@ config I2C_LPC2K
 
 config I2C_MLXBF
         tristate "Mellanox BlueField I2C controller"
-        depends on ARM64
+        depends on MELLANOX_PLATFORM && ARM64
         help
           Enabling this option will add I2C SMBus support for Mellanox BlueField
           system.
-- 
2.17.1

