From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sat, 17 Jan 2015 17:01:13 +0100
Message-ID: <20150117160113.GA22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
 <54B98C18.4080807@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B98C18.4080807-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jan 16, 2015 at 02:09:28PM -0800, Ray Jui wrote:
> On 1/15/2015 12:41 AM, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 14, 2015 at 02:23:32PM -0800, Ray Jui wrote:
> >> +	 */
> >> +	val =3D 1 << M_CMD_START_BUSY_SHIFT;
> >> +	if (msg->flags & I2C_M_RD) {
> >> +		val |=3D (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
> >> +		       (msg->len << M_CMD_RD_CNT_SHIFT);
> >> +	} else {
> >> +		val |=3D (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
> >> +	}
> >> +	writel(val, iproc_i2c->base + M_CMD_OFFSET);
> >> +
> >> +	time_left =3D wait_for_completion_timeout(&iproc_i2c->done, time=
_left);
> >=20
> > When the interrupt fires here after the complete timed out and befo=
re
> > you disable the irq you still throw the result away.
> Yes, but then this comes down to the fact that if it has reached the
> point that is determined to be a timeout condition in the driver, one
> should really treat it as timeout error. In a normal condition,
> time_left should never reach zero.
I don't agree here. I'm not sure there is a real technical reason,
though. But still if you're in a "success after timeout already over"
situation it's IMHO better to interpret it as success, not timeout.

> >> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> >> +{
> >> +	struct bcm_iproc_i2c_dev *iproc_i2c =3D platform_get_drvdata(pde=
v);
> >> +
> >> +	i2c_del_adapter(&iproc_i2c->adapter);
> > You need to free the irq before i2c_del_adapter.
> >=20
> Yes. Thanks. Change back to use devm_request_irq, and use disable_irq
> here before removing the adapter.
The more lightweight approach is to set your device's irq-enable
register to zero and call synchronize_irq. (For a shared irq calling
disable_irq is even wrong here.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
