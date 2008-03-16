From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the
	new	pca-algorithm
Date: Sun, 16 Mar 2008 15:28:34 +0100
Message-ID: <20080316142834.GA4485@pengutronix.de>
References: <20080308111337.440a7c83@hyperion.delvare>
	<20080310112640.GB12128@pengutronix.de>
	<20080310223116.73277c4f@hyperion.delvare>
	<20080314145010.GA28612@pengutronix.de>
	<20080314194628.07630698@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8623732016049463801=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080314194628.07630698-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8623732016049463801==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2008 at 07:46:28PM +0100, Jean Delvare wrote:

> > +	/* Use gpio_is_valid() when in mainline */
> > +	if (i2c->gpio > -1)
> > +		ret =3D gpio_request(i2c->gpio, i2c->adap.name);
> > +		if (ret =3D=3D 0) {
> > +			gpio_direction_output(i2c->gpio, 1);
> > +			i2c->algo_data.reset_chip =3D i2c_pca_pf_resetchip;
> > +		} else {
> > +			printk(KERN_WARNING "%s: Registering gpio failed!\n",
> > +				i2c->adap.name);
> > +			i2c->gpio =3D ret;
> > +		}
>=20
> You're missing curly braces around this block, aren't you?
Holy ..., yes, you are right. This is why I used to have braces even
around single instructions after if. This is, where CodingStyle gives me
most trouble.

> The rest looks OK, so I can fix this myself and queue up your patch for
> 2.6.26.
Ah, finally! \o/ Thanks a _lot_ for your help, I learnt a lot and this
will hopefully show in my next submission :)

Best wishes,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH3S6SD27XaX1/VRsRAj9bAKCx8KiPXFSM3SOkYnRE8PMONQNPbgCfZouT
IAP02iKwd8a04+qoN9div6g=
=N0VK
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


--===============8623732016049463801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8623732016049463801==--
