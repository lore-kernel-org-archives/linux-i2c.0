From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Question about i2c new style modle
Date: Sun, 12 Oct 2008 09:57:15 +0200
Message-ID: <20081012075715.GA26683@pengutronix.de>
References: <56458e0810112335r529622dei4c6891465c6fdf88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0000216754919668348=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <56458e0810112335r529622dei4c6891465c6fdf88-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============0000216754919668348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wen,

On Sun, Oct 12, 2008 at 02:35:49PM +0800, Wen Wang wrote:

>    Can anyone please help to tell me if I have to upgrade my I2C client
>    driver from legacy binding model to new style binding model in 2.6.27
>    kernel or not?

It is not required yet, but it is always a good idea to move to the new
binding (which will be required somewhen, nevertheless).

>    If I have to :(, I don't know which part of code will
>    update the board info about I2C devices or this should be done by the
>    client driver?

I am not sure if I understood what you meant with "updating the board
info". You supply i2c_board_info in your board init code and when the
i2c adapter is initialized, it will call the client drivers
probe-function. Maybe the guide in Documentation/i2c/upgrading-clients
will further help you?

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjxrdsACgkQD27XaX1/VRsfawCffWGPa+gyEiYHd6AgVIfrPB6Q
iS8Anjdqk1NHE3HdPUOtHCbnD+hhYWRX
=0EXD
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


--===============0000216754919668348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0000216754919668348==--
