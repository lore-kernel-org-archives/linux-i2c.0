From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Question about i2c new style modle
Date: Sun, 12 Oct 2008 15:00:53 +0200
Message-ID: <20081012130052.GA27016@pengutronix.de>
References: <56458e0810112335r529622dei4c6891465c6fdf88@mail.gmail.com>
	<20081012075715.GA26683@pengutronix.de>
	<56458e0810120452n2def8400n883ad46d0440e779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2439248376355520440=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <56458e0810120452n2def8400n883ad46d0440e779-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wen Wang <sickdoctor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2439248376355520440==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wen,

On Sun, Oct 12, 2008 at 07:52:08PM +0800, Wen Wang wrote:

>    i2c adapter is initialized", but I'm quite sure there won't be a such
>    static i2c_board_info in the board init code.

Well, you could add one :)

>    And I'm just wonder if there is a dynamic detect method to go?

There is also Documentation/i2c/writing-clients with a chapter about
Device creation and Device detection using the standard driver model.
For reference examples, just look in drivers/hwmon/. There should be
plenty of drivers which use a detect-callback, in case you need this.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjx9QQACgkQD27XaX1/VRsRYwCfa9sHy+Rlc2Qstj2VeUCSJbH3
tPAAnRLjN15vSp1KzJqv9FMJWnqownH2
=remq
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


--===============2439248376355520440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2439248376355520440==--
