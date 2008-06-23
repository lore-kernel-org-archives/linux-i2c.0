From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Mon, 23 Jun 2008 17:07:10 +0200
Message-ID: <20080623150710.GH3926@pengutronix.de>
References: <20080620084155.GA17701@pengutronix.de>
	<20080623124425.GE3926@pengutronix.de>
	<20080623155909.525f5095@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3032269909761486543=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080623155909.525f5095-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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


--===============3032269909761486543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 03:59:09PM +0200, Jean Delvare wrote:

> I was away for the week-end and am now processing the stacked e-mail
> and other real-life tasks (takes time.)
This was more addressed to Jochen; should have pointed out, that I was
waiting for his ACK.

> I fail to see how there would be a regression here given that the
> i2c-cpm driver is new and is not in kernel 2.6.26.
Ups, sigh, I remembered you added it to your tree and mistook it that
you also already pushed it. Point taken, not that urgent. Sorry!

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIX7weD27XaX1/VRsRAiffAKC/0w7vnKU73eBu9qA9CpdVnGb2ZACfYDgC
SDz1Smu/WhJq7FERlw8f6T0=
=IRV0
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--


--===============3032269909761486543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3032269909761486543==--
