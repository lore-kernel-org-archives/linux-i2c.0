From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
Date: Fri, 19 Oct 2018 11:21:45 +0200
Message-ID: <20181019092145.6zihrnduyypzo5x2@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-3-o.rempel@pengutronix.de>
 <20181019071243.t5bwcmnnlqrgtajj@pengutronix.de>
 <20181019090100.6vcergf6txgxt7fo@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181019090100.6vcergf6txgxt7fo@pengutronix.de>
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

On Fri, Oct 19, 2018 at 11:01:00AM +0200, Oleksij Rempel wrote:
> On Fri, Oct 19, 2018 at 09:12:43AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Oleksij,
> > =

> > On Thu, Oct 18, 2018 at 01:26:14PM +0200, Oleksij Rempel wrote:
> > > The DMA support for I2C was introduced on i.MX50. So,
> > > avoid of DMA probing on not supported versions.
> > =

> > What is the obvious downside of trying to use DMA on i.MX21? If the
> > purpose is just to suppress the message
> > =

> > 	can't request DMA tx channel
> > =

> > , that goes away with patch 3, too.
> > =

> > Note that if we agree that i.MX50 (and later) isn't compatible to
> > i.MX21, all device trees should be fixed accordingly. IMHO the
> > difference "There is a DMA engine connected only on some
> > implementations" doesn't give enough incentive to claim that i.MX21 and
> > i.MX50 must not share the compatible.
> =

> I don't see any sense to do allocation and add extra probes just to find
> what we already know from compatible.

I think it's perfectly fine to only notice that there is no DMA support
when trying to set it up. It has slight runtime overhead, yes, but being
able to handle imx21 and imx50 in the same way is a nice advantage that
I don't want to throw away easily.

If you care about the allocation, you can do do the calls to
dma_request_chan first and assign to local variables before the
allocation of *dma.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
