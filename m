From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH RESEND 3/4] i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
Date: Thu,  7 Dec 2017 17:20:02 +0700
Message-ID: <20171207102003.23496-4-asolokha@kb.kras.ru>
References: <20171110075015.23906-1-asolokha@kb.kras.ru>
 <20171207102003.23496-1-asolokha@kb.kras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ispman.iskranet.ru ([62.213.33.10]:58118 "EHLO
        ispman.iskranet.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdLGKUX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 05:20:23 -0500
In-Reply-To: <20171207102003.23496-1-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>

According to the reference manuals for the corresponding SoCs, SEC
frequency ratio configuration is indicated by bit 26 of the POR Device
Status Register 2. Consequently, SEC_CFG bit should be tested by mask 0x20,
not 0x80. Testing the wrong bit leads to selection of wrong I2C clock
prescaler on those SoCs.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 drivers/i2c/busses/i2c-mpc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 648a5afded64..aac0ec6dc5fc 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -332,14 +332,18 @@ static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 		if (prop) {
 			/*
 			 * Map and check POR Device Status Register 2
-			 * (PORDEVSR2) at 0xE0014
+			 * (PORDEVSR2) at 0xE0014. Note than while MPC8533
+			 * and MPC8544 indicate SEC frequency ratio
+			 * configuration as bit 26 in PORDEVSR2, other MPC8xxx
+			 * parts may store it differently or may not have it
+			 * at all.
 			 */
 			reg = ioremap(get_immrbase() + *prop + 0x14, 0x4);
 			if (!reg)
 				printk(KERN_ERR
 				       "Error: couldn't map PORDEVSR2\n");
 			else
-				val = in_be32(reg) & 0x00000080; /* sec-cfg */
+				val = in_be32(reg) & 0x00000020; /* sec-cfg */
 			iounmap(reg);
 		}
 	}
-- 
2.15.1
