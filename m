Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACFC77B7E
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Jun 2023 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjFAVbK (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFAVbJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Jun 2023 17:31:09 -0400
X-Greylist: delayed 6593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 14:31:08 PDT
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3B195
        for <linux-i2c@vger.kernel.org>; Thu,  1 Jun 2023 14:31:08 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.138.56])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id DEB0024ADB
        for <linux-i2c@vger.kernel.org>; Thu,  1 Jun 2023 19:05:22 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-v64b8 (unknown [10.110.115.101])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0858F1FDB4;
        Thu,  1 Jun 2023 19:05:21 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
        by ghost-submission-6684bf9d7b-v64b8 with ESMTPSA
        id isruOfHreGRUAwAA/zevJg
        (envelope-from <andi@etezian.org>); Thu, 01 Jun 2023 19:05:21 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-98R002f027b0f7-cedf-4ad2-95e8-e13eec2dbd88,
                    AA272FFB3D993AA473C4810146CC99B0E2A08255) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as I2C host drivers maintainer
Date:   Thu,  1 Jun 2023 21:04:27 +0200
Message-Id: <20230601190427.21388-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17001651546801769179
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtgfevudejhffgleekffekvedukeehveeijefhleektdeiheelueffvdeufeejffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrddvudeipdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqihdvtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

I will help Wolfram out with the i2c controllers patches.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74aeae10a1516..668f83d514a25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9732,6 +9732,7 @@ F:	include/uapi/linux/i2c-*.h
 F:	include/uapi/linux/i2c.h
 
 I2C SUBSYSTEM HOST DRIVERS
+M:	Andi Shyti <andi.shyti@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Odd Fixes
 W:	https://i2c.wiki.kernel.org/
-- 
2.40.1

