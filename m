From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v6] i2c: imx: support slave mode for imx I2C driver
Date: Fri, 6 Dec 2019 08:38:20 +0100
Message-ID: <20191206073819.lntjjxpcjm5yrb7y@pengutronix.de>
References: <20191203114809.21226-1-biwen.li@nxp.com>
 <20191204100005.r56huywxa7h3c6zr@pengutronix.de>
 <9a1a00c1-e9fa-36a1-0e79-3492d9b98d9f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9a1a00c1-e9fa-36a1-0e79-3492d9b98d9f@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: aisheng.dong@nxp.com, Biwen Li <biwen.li@nxp.com>, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de, shawnguo@kernel.org, xiaobo.xie@nxp.com, leoyang.li@nxp.com, xiaoning.wang@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, jiafei.pan@nxp.com, laurentiu.tudor@nxp.com, festevam@gmail.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 05, 2019 at 12:43:46PM +0100, Oleksij Rempel wrote:
> Hi,
> 
> On 04.12.19 11:00, Sascha Hauer wrote:
> > Hi,
> > 
> > The patch looks ok to me now, but I still do not like the #ifdeffery
> > around CONFIG_I2C_SLAVE. With the patch I just sent (You are on Cc:)
> > we could apply the following on your patch which makes it more readable
> > and increases compile coverage.
> > 
> > Wolfram, Biwen, what do you think?
> 
> 
> RCAR depends on slave:
> config I2C_RCAR
> 
>         tristate "Renesas R-Car I2C Controller"
> 
>         depends on ARCH_RENESAS || COMPILE_TEST
> 
>         select I2C_SLAVE
> see:
> drivers/i2c/busses/i2c-rcar.c
> 
> So, I would suggest to do the same in imx.

I suggested that to v1 of this patch. If we agree though that I2C slave
support deserves an extra Kconfig option we should also make the drivers
cope with that situation. Otherwise we would better make I2C slave
support non optional.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
