From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
Date: Mon, 17 Dec 2018 10:26:16 +0100
Message-ID: <20181217092616.sd4yv4ezu72xzlxb@pengutronix.de>
References: <m3o9a2hni5.fsf@t19.piap.pl>
 <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
 <m3va3sh5zl.fsf@t19.piap.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m3va3sh5zl.fsf@t19.piap.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 17, 2018 at 10:12:14AM +0100, Krzysztof Hałasa wrote:
> 90ad2cbe88c22d0215225ab9594eeead0eb24fde changed the i.MX I2C bus driver
> to use a notifier whenever the base clock ("ipg" - 66 MHz peripheral
> clock) rate changes.
> 
> Unfortunately one can't use the container_of() macro this way - the
> first argument has to point to a member of the bigger struct (last
> argument). Merely pointing to the same value isn't enough (the clk
> variable which has its address passed to the macro is the clk in
> notifier_block, not the one in imx_i2c_struct, even though both pointers
> point to the same clk struct).
> 
> This bug causes kernel panic when the IPG clock rate changes (e.g. if
> any clock derived from IPG changes).
> 
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

I didn't look at the patch, but I suggest a Fixes: line here à la:

Fixes: 90ad2cbe88c2 ("i2c: imx: use clk notifier for rate changes")

Best regards
Uwe
 
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
