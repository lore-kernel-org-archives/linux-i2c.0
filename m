Return-Path: <SRS0=9WpY=7X=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685DC433DF
	for <linux-i2c@archiver.kernel.org>; Wed, 10 Jun 2020 07:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97302064C
	for <linux-i2c@archiver.kernel.org>; Wed, 10 Jun 2020 07:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFJH0G (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:26:06 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:50664 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgFJH0G (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 10 Jun 2020 03:26:06 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 05A7P6iA020956;
        Wed, 10 Jun 2020 10:25:07 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 55631639BF; Wed, 10 Jun 2020 10:25:06 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2] MAINTAINERS: npcm7xx: Add maintainer for Nuvoton NPCM BMC
Date:   Wed, 10 Jun 2020 10:24:51 +0300
Message-Id: <20200610072451.76495-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add maintainer for Nuvoton NPCM BMC
I2C controller driver.

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..c2cfe1ef20c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2142,6 +2142,7 @@ F:	Documentation/devicetree/bindings/*/*npcm*
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
+F:	drivers/*/*/*npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT

base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
-- 
2.22.0

