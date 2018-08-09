From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Date: Thu, 9 Aug 2018 18:26:52 +0200
Message-ID: <20180809162652.r34omvkctzxte422@pengutronix.de>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-4-esben.haabendal@gmail.com>
 <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
 <87k1ozzquk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1ozzquk.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 09, 2018 at 02:06:43PM +0200, Esben Haabendal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Mon, Jul 09, 2018 at 11:43:03AM +0200, Esben Haabendal wrote:
> >> From: Esben Haabendal <eha@deif.com>
> >> 
> >> Always update the stopped state when busy status have been checked.
> >> This is identical to what was done before, with the exception of error
> >> handling.
> >> Without this change, some errors cause the stopped state to be left in
> >> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
> >> i2c_imx_xfer().
> >> 
> >> Signed-off-by: Esben Haabendal <eha@deif.com>
> >> ---
> >>  drivers/i2c/busses/i2c-imx.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index d86f152176a4..1db8e6790afc 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
> >>  			return -EAGAIN;
> >>  		}
> >>  
> >> -		if (for_busy && (temp & I2SR_IBB))
> >> +		if (for_busy && (temp & I2SR_IBB)) {
> >> +			i2c_imx->stopped = 0;
> >>  			break;
> >> -		if (!for_busy && !(temp & I2SR_IBB))
> >> +		}
> >> +		if (!for_busy && !(temp & I2SR_IBB)) {
> >> +			i2c_imx->stopped = 1;
> >>  			break;
> >> +		}
> >
> > Would it make sense to assign to ->stopped independent of for_busy?
> 
> What do you mean?
> 
> Assigning to ->stopped on each check for I2SR_IBB in loop, independent
> of the for_busy argument?  I don't think so.  The additional assignments
> would be to the same value as it is set to already.

Currently you have:

	if (for_busy && (temp & I2SR_IBB)) {
		i2c_imx->stopped = 0;
		break;
	}

	if (!for_busy && !(temp & I2SR_IBB)) {
		i2c_imx->stopped = 1;
		break;
	}

The semantic of this is the same (apart from always updating .stopped)
but is imho easier:

	i2c_imx->stopped = !(temp & I2SR_IBB);

	if (for_busy != i2c_imx->stopped)
		break;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
