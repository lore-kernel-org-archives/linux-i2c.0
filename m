From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH 3/4] i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
Date: Fri, 10 Nov 2017 14:50:14 +0700
Message-ID: <20171110075015.23906-4-asolokha@kb.kras.ru>
References: <20171110075015.23906-1-asolokha@kb.kras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110075015.23906-1-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>
List-Id: linux-i2c@vger.kernel.org

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
index f47916466b82..8d60db0080f6 100644
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
2.15.0
