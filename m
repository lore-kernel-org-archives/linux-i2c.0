From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Wed, 4 Jun 2008 13:51:35 +0200
Message-ID: <20080604115135.GA30363@pengutronix.de>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<200806021233.46781.david-b@pacbell.net>
	<20080602214823.15ca190b@hyperion.delvare>
	<200806031336.35678.david-b@pacbell.net>
	<20080603231927.61f9eb61@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3599324624490544805=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080603231927.61f9eb61-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============3599324624490544805==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2008 at 11:19:27PM +0200, Jean Delvare wrote:
> I agree that in theory something wrong could happen in the current
> state of things if the extra addresses of the 24C00 chip are not
> "protected" by the at24 driver, but in practice I very much doubt that
> it'll happen, and if it does, it would be easy to fix. So I reiterate
> that the at24 driver doesn't need to handle this.
After removing i2c_addr_mask, it turned out that it just needed one
if-case and anonther flag to handle the 24c00-quirk. Hoping that this
will be the only case needing such treatment ;), I think it is worth the
price.

Sidenote: I just finished hacking in all points from my to-do-list. Now,
I want to validate the implicit casts and give the driver some really
good testing as some parts had to be rewritten for v3.

All the best,

   Wolfram
--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIRoHHD27XaX1/VRsRAninAKDM0Ivc1cLJxiJwzIcYA0txcrpWWACcDX+x
7MGyWOWtwqYN1wYTWx+6D6Q=
=SrmH
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


--===============3599324624490544805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3599324624490544805==--
