From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
Date: Mon, 03 Dec 2018 12:13:06 +0100
Message-ID: <m3o9a2hni5.fsf@t19.piap.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -510,9 +510,9 @@ static int i2c_imx_clk_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
+	struct imx_i2c_struct *i2c_imx = container_of(nb,
 						      struct imx_i2c_struct,
-						      clk);
+						      clk_change_nb);
 
 	if (action & POST_RATE_CHANGE)
 		i2c_imx_set_clk(i2c_imx, ndata->new_rate);
