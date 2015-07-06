From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
Date: Tue,  7 Jul 2015 00:54:48 +0530
Message-ID: <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, robh+dt@kernel.org, Yipeng Yao <ypyao@marvell.com>, robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Yipeng Yao <ypyao@marvell.com>

Fix below warning message, coming from 64 bit toolchain.

drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Yipeng Yao <ypyao@marvell.com>
[vaibhav.hiremath@linaro.org: Updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 632008f..4c92694 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1116,7 +1116,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
-	*i2c_types = (u32)(of_id->data);
+
+	*i2c_types = (long)(of_id->data);
+
 	return 0;
 }
 
-- 
1.9.1
