From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Date: Fri, 10 Aug 2018 14:25:11 +0200
Message-ID: <20180810122511.2xnelcn6tguirfbp@pengutronix.de>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-4-esben.haabendal@gmail.com>
 <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
 <87k1ozzquk.fsf@gmail.com>
 <20180809162652.r34omvkctzxte422@pengutronix.de>
 <87zhxuo9o1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhxuo9o1.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Esben,

On Fri, Aug 10, 2018 at 11:25:34AM +0200, Esben Haabendal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > Currently you have:
> >
> > 	if (for_busy && (temp & I2SR_IBB)) {
> > 		i2c_imx->stopped = 0;
> > 		break;
> > 	}
> >
> > 	if (!for_busy && !(temp & I2SR_IBB)) {
> > 		i2c_imx->stopped = 1;
> > 		break;
> > 	}
> >
> > The semantic of this is the same (apart from always updating .stopped)
> > but is imho easier:
> >
> > 	i2c_imx->stopped = !(temp & I2SR_IBB);
> >
> > 	if (for_busy != i2c_imx->stopped)
> > 		break;
> 
> Yes, that should work also.
> Shorter, but IMHO a bit more convoluted to read.
> Let me know if I should send a new version with this change.

unless someone else chimes in I'd say keep it as is. I'd prefer my
variant, but I accept that this is something subjective.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
