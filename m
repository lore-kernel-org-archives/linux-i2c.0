From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v4 04/11] i2c: pxa: Fix compile warning in 64bit mode
Date: Tue, 14 Jul 2015 13:06:43 +0530
Message-ID: <1436859410-28878-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, robert.jarzmik@free.fr, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Yipeng Yao <ypyao@marvell.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-i2c@vger.kernel.org

From: Yipeng Yao <ypyao@marvell.com>

Fix below warning message, coming from 64 bit toolchain.

drivers/i2c/busses/i2c-pxa.c:1237:15:
warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Yipeng Yao <ypyao@marvell.com>
[vaibhav.hiremath@linaro.org: Updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 632008f..d0cc058 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1116,7 +1116,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
-	*i2c_types = (u32)(of_id->data);
+
+	*i2c_types = (enum pxa_i2c_types)(of_id->data);
+
 	return 0;
 }
 
-- 
1.9.1
