From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/2] i2c: imx: notify about real errors on dma
 i2c_imx_dma_request
Date: Mon, 7 Jan 2019 21:27:51 +0100
Message-ID: <20190107202751.odkfymuvbaljcmot@pengutronix.de>
References: <20190107084738.4130-1-o.rempel@pengutronix.de>
 <20190107084738.4130-2-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190107084738.4130-2-o.rempel@pengutronix.de>
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
Cc: Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, Jan 07, 2019 at 09:47:37AM +0100, Oleksij Rempel wrote:
> Current implementation will print "can't use DMA, using PIO instead",
> which is confusing and mostly interpreted as error. At least on i.MX5x,
> DMA event for I2C is muxed with SDHC. So it is project specific
> configuration. On other hand, real error have debug level.
> =

> With this patch real error should be printed and configuration specific
> state will become silent.

I'd write:

At least on i.MX5x, the DMA events for I2C and SDHC use the same channel
and there can only be a single user. So in this case there should be no
message emitted that looks like an error if the I2C device doesn't have
an assigned DMA channel. In contrast real problems that were only
emitted at debug level before should be described at a higher level
to be better visible and so understandable.

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

The patch is fine and can have my =


Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
