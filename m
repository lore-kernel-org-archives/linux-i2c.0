From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
Date: Mon, 17 Dec 2018 10:12:14 +0100
Message-ID: <m3va3sh5zl.fsf@t19.piap.pl>
References: <m3o9a2hni5.fsf@t19.piap.pl>
        <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
        (Fabio Estevam's message of "Mon, 3 Dec 2018 09:21:32 -0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

90ad2cbe88c22d0215225ab9594eeead0eb24fde changed the i.MX I2C bus driver
to use a notifier whenever the base clock ("ipg" - 66 MHz peripheral
clock) rate changes.

Unfortunately one can't use the container_of() macro this way - the
first argument has to point to a member of the bigger struct (last
argument). Merely pointing to the same value isn't enough (the clk
variable which has its address passed to the macro is the clk in
notifier_block, not the one in imx_i2c_struct, even though both pointers
point to the same clk struct).

This bug causes kernel panic when the IPG clock rate changes (e.g. if
any clock derived from IPG changes).

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
