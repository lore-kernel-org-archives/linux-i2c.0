From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH 1/4] i2c: mpc: get MPC8xxx I2C clock prescaler before using it in calculations
Date: Fri, 10 Nov 2017 14:50:12 +0700
Message-ID: <20171110075015.23906-2-asolokha@kb.kras.ru>
References: <20171110075015.23906-1-asolokha@kb.kras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ispman.iskranet.ru ([62.213.33.10]:41399 "EHLO
        ispman.iskranet.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755499AbdKJH6T (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Nov 2017 02:58:19 -0500
In-Reply-To: <20171110075015.23906-1-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>

Obtaining the actual I2C clock prescaler value in mpc_i2c_setup_8xxx() only
happens when the clock parameter is set to something other than
MPC_I2C_CLOCK_LEGACY. When the clock parameter is exactly
MPC_I2C_CLOCK_LEGACY, the prescaler parameter is used in arithmetic
division as provided by the caller, resulting in a division by zero
for the majority of processors supported by the module.

Avoid division by zero by obtaining the actual I2C clock prescaler
in mpc_i2c_setup_8xxx() unconditionally regardless of the passed clock
value.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 drivers/i2c/busses/i2c-mpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 96caf378b1dc..bf0c86d41f1a 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -382,18 +382,18 @@ static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	u32 divider;
 	int i;
 
-	if (clock == MPC_I2C_CLOCK_LEGACY) {
-		/* see below - default fdr = 0x1031 -> div = 16 * 3072 */
-		*real_clk = fsl_get_sys_freq() / prescaler / (16 * 3072);
-		return -EINVAL;
-	}
-
 	/* Determine proper divider value */
 	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
 		prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
 	if (!prescaler)
 		prescaler = mpc_i2c_get_prescaler_8xxx();
 
+	if (clock == MPC_I2C_CLOCK_LEGACY) {
+		/* see below - default fdr = 0x1031 -> div = 16 * 3072 */
+		*real_clk = fsl_get_sys_freq() / prescaler / (16 * 3072);
+		return -EINVAL;
+	}
+
 	divider = fsl_get_sys_freq() / clock / prescaler;
 
 	pr_debug("I2C: src_clock=%d clock=%d divider=%d\n",
-- 
2.15.0
