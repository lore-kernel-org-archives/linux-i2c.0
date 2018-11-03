From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
Date: Sat, 3 Nov 2018 21:59:32 +0100
Message-ID: <20181103205932.hxqhwclb2jo6wo5n@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
 <20181028221123.GE1882@kunai>
 <9a3fc087-2fe5-6d57-9b65-a05e176bf53d@pengutronix.de>
 <20181029085408.GB4101@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181029085408.GB4101@kunai>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram, hello Oleksij,

On Mon, Oct 29, 2018 at 08:54:08AM +0000, Wolfram Sang wrote:
> On Mon, Oct 29, 2018 at 09:07:56AM +0100, Oleksij Rempel wrote:
> > On 28.10.18 23:11, Wolfram Sang wrote:
> > > On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
> > > > At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
> > > > it is project specific configuration and not an error.
> > > > =

> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > =

> > > So, the first patch is not I2C realm, and the second is dropped. No
> > > comment about the third one?
> > > =

> > > And is maybe someone from Pengutronix interested in maintaining this
> > > driver? Uwe maybe? That would speed up things for it...
> > =

> > Should i resend it as single patch?
> =

> I am fine with an ack here.

With patch 1 dropped this patch needs adaption I think.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
