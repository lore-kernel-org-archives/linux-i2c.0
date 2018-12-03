From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
Date: Mon, 03 Dec 2018 14:28:18 +0100
Message-ID: <m3ftvehh8t.fsf@t19.piap.pl>
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

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Please provide a commit log, giving some context to your fix.

Well, I hope Lucas could add something here. I am uncertain how it was
supposed to work, the ndata->clk (the pointer, not the clk pointed by
it) can't be at the same time a member of imx_i2c_struct, and I believe
the macro only does simple arithmetics to get to the outer struct.

@@ -510,9 +510,9 @@ static int i2c_imx_clk_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
+	struct imx_i2c_struct *i2c_imx = container_of(nb,
 						      struct imx_i2c_struct,
-						      clk);
+						      clk_change_nb);

> Is this a regression?

Probably (it went in between 4.16 and 4.17, commit id is
90ad2cbe88c22d0215225ab9594eeead0eb24fde). However this part may be
unused on many boards (apparently it only fires up if the "IPG" clock
rate changes), so it may not manifest itself. I only hit it when I added
a custom driver (using/requesting a special clock derived from IPG).
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
