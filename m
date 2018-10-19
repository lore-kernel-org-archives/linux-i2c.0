From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
Date: Fri, 19 Oct 2018 09:12:43 +0200
Message-ID: <20181019071243.t5bwcmnnlqrgtajj@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-3-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181018112615.29362-3-o.rempel@pengutronix.de>
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

Hello Oleksij,

On Thu, Oct 18, 2018 at 01:26:14PM +0200, Oleksij Rempel wrote:
> The DMA support for I2C was introduced on i.MX50. So,
> avoid of DMA probing on not supported versions.

What is the obvious downside of trying to use DMA on i.MX21? If the
purpose is just to suppress the message

	can't request DMA tx channel

, that goes away with patch 3, too.

Note that if we agree that i.MX50 (and later) isn't compatible to
i.MX21, all device trees should be fixed accordingly. IMHO the
difference "There is a DMA engine connected only on some
implementations" doesn't give enough incentive to claim that i.MX21 and
i.MX50 must not share the compatible.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
