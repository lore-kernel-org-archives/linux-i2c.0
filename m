From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
Date: Fri, 14 Mar 2008 11:51:51 +0100
Message-ID: <20080314105151.GA32766@pengutronix.de>
References: <200803101002.52153.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6949850448804865577=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803101002.52153.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============6949850448804865577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2008 at 09:02:51AM -0800, David Brownell wrote:

> You should #include <linux/gpio.h> now and avoid a lot
> of this #ifdeffery ... which is something I think you'd
> be told by running checkpatch.pl on 2.6.25-rc5, as well
> as most RC4 kernels.
Last time I changed my #includes from asm/foo.h to linux/foo.h, it was
also wrong :) But now I researched that for irq.h checkpatch.pl had a
bug (patch sent), for io.h it is unknown and uncommon to replace it
(still recommended according to lkml) and for gpio.h it is probably the
right thing to do.

Still, using <linux/gpio.h> does not really avoid the #ifdefs if the
priority is to produce less code in the driver. It does avoid them if
the priority is simply to remove them (for the price of having an
integer and two small blocks of code as unused overhead). May I assume
that it getting rid of #ifdefs has priority?

> > +	/* Use NO_GPIO when this macro is in mainline */
> I hope you mean gpio_is_valid() instead... that's in MM,
> but not yet mainline (except when <linux/gpio.h> is all
> stubs).
Will change the comment.

I also realized that I should register/deregister the gpio-pin in the
driver; used to have this in the boardsetup, sigh. Will send an updated
version later today.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2ljHD27XaX1/VRsRApDrAJ99r1ql8ZxCC5Vk5nUKm8dYuWwCygCggUfz
SCBdIzC6Yo1YrFRWVuJ50f4=
=4buQ
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============6949850448804865577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6949850448804865577==--
