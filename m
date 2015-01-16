From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
Date: Fri, 16 Jan 2015 20:48:31 +0100
Message-ID: <20150116194831.GV22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-4-git-send-email-rjui@broadcom.com>
 <20150115084456.GO22880@pengutronix.de>
 <54B96559.1010007@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B96559.1010007-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jan 16, 2015 at 11:24:09AM -0800, Ray Jui wrote:
> >> +	i2c0: i2c@18008000 {
> >> +		compatible =3D "brcm,iproc-i2c";
> > in patch 2 you wrote the driver is for a family of SoCs, right? The=
n I'd
> > make this:
> >=20
> > 	compatible =3D "brcm,$mysoc-iproc-i2c", "brcm,iproc-i2c";
> >=20
> Sorry could you please help to explain the intention here? Note the
> iProc I2C IP can be found in various iProc family of SoCs, but to my
> best knowledge, there hasn't been any changes of the IP in any of tho=
se
> SoCs.
This is just for making the device tree stable in the future. Consider
your gentle hardware engineers "fix" a small issue for the next
generation iproc SoC "pony" that needs an incompatible software change.

Then you can fix the driver without updating the device trees by
switching to the SoC specific compatible string for "pony". And in case
the hardware engineers didn't tell you that there is a change and the
need for the software change is only detected when the machines are
already shipped, you're happy if you can fix your kernel without needin=
g
to change the bootloader that provides the dtb.
So start already today to add the (for now unused) compatible string.

> Is the compatible ID "brcm,$mysoc-iproc-i2c" only to clarify that it'=
s
> for a specific SoC? If so, what should the compatible ID array look
> like? Should it be changed to the following?
>=20
> static const struct of_device_id bcm_iproc_i2c_of_match[] =3D {
> 	{ .compatible =3D "brcm,iproc-i2c" },
> 	{ .compatible =3D "brcm,$mysoc-iproc-i2c" },
> 	{},
> };
No, there is no need, see above.

If something is still unclear, don't hesitate to ask.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
