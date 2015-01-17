From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sat, 17 Jan 2015 22:10:17 +0100
Message-ID: <20150117211017.GD22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
 <54B98C18.4080807@broadcom.com>
 <20150117160113.GA22880@pengutronix.de>
 <54BABEE9.8070801@broadcom.com>
 <20150117201849.GC22880@pengutronix.de>
 <54BACB66.6040909@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54BACB66.6040909-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Sat, Jan 17, 2015 at 12:51:50PM -0800, Ray Jui wrote:
> On 1/17/2015 12:18 PM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Sat, Jan 17, 2015 at 11:58:33AM -0800, Ray Jui wrote:
> >> On 1/17/2015 8:01 AM, Uwe Kleine-K=F6nig wrote:
> >>> On Fri, Jan 16, 2015 at 02:09:28PM -0800, Ray Jui wrote:
> >>>> On 1/15/2015 12:41 AM, Uwe Kleine-K=F6nig wrote:
> >>>>> On Wed, Jan 14, 2015 at 02:23:32PM -0800, Ray Jui wrote:
> >>>>>> +	 */
> >>>>>> +	val =3D 1 << M_CMD_START_BUSY_SHIFT;
> >>>>>> +	if (msg->flags & I2C_M_RD) {
> >>>>>> +		val |=3D (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
> >>>>>> +		       (msg->len << M_CMD_RD_CNT_SHIFT);
> >>>>>> +	} else {
> >>>>>> +		val |=3D (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
> >>>>>> +	}
> >>>>>> +	writel(val, iproc_i2c->base + M_CMD_OFFSET);
> >>>>>> +
> >>>>>> +	time_left =3D wait_for_completion_timeout(&iproc_i2c->done, =
time_left);
> >>>>>
> >>>>> When the interrupt fires here after the complete timed out and =
before
> >>>>> you disable the irq you still throw the result away.
> >>>> Yes, but then this comes down to the fact that if it has reached=
 the
> >>>> point that is determined to be a timeout condition in the driver=
, one
> >>>> should really treat it as timeout error. In a normal condition,
> >>>> time_left should never reach zero.
> >>> I don't agree here. I'm not sure there is a real technical reason=
,
> >>> though. But still if you're in a "success after timeout already o=
ver"
> >>> situation it's IMHO better to interpret it as success, not timeou=
t.
> >>>
> >> The thing is, the interrupt should never fire after
> >> wait_for_completion_timeout returns zero here. If it does, then th=
e
> >> issue is really that the timeout value set in the driver is probab=
ly not
> >> long enough. I just checked other I2C drivers. I think the way how
> >> timeout is handled here is consistent with other I2C drivers.
> > In the presence of Clock stretching there is no (theorethical) uppe=
r
> > limit for the time needed to transfer a given message, is there? So
> > (theoretically) you can never be sure not to interrupt an ongoing
> > transfer.
> >=20
> Yes. No theoretical upper limit in the case when clock is stretched b=
y
> the slave. But how would adding an additional interrupt completion ch=
eck
> below help? I assume you want the the check to be like the following?
>=20
> 	time_left =3D wait_for_completion_timeout(&iproc_i2c->done, time_lef=
t);
>=20
> 	/* disable all interrupts */
> 	writel(0, iproc_i2c->base + IE_OFFSET);
>=20
> 	if (!time_left && !completion_done()) {
> 		dev_err(iproc_i2c->device, "transaction timed out\n");
>=20
> 		/* flush FIFOs */
> 		val =3D (1 << M_FIFO_RX_FLUSH_SHIFT) |
> 		      (1 << M_FIFO_TX_FLUSH_SHIFT);
> 		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> 		return -ETIMEDOUT;
> 	}
No, I want:

	time_left =3D wait_for_completion_timeout(&iproc_i2c->done, time_left)=
;

	if (!transfer_was_complete) {
		handle_error();
		...

	}

	handle_successful_transfer();

and time_left =3D=3D 0 is not a reliable indicator that the transfer fa=
iled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
