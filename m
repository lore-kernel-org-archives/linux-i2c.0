From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 11:39:39 +0200
Message-ID: <20080622093939.GO10695@enneenne.com>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6571822020674260999=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <87bq1tsue5.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============6571822020674260999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/yfn7NBi5qsQ3/E8"
Content-Disposition: inline


--/yfn7NBi5qsQ3/E8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2008 at 11:15:14AM +0200, Peter Korsgaard wrote:
> >>>>> "Rodolfo" =3D=3D Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:
>=20
>  >> It would be nice to be able to use the i2c-virtual stuff for it.
>=20
>  Rodolfo> Mmm... I suppose is not so easy as we wish since there are seve=
ral
>  Rodolfo> references to the i2c parent struct into the code.
>=20
> That's not the problem, the struct i2c_client is. The i2c-virtual
> stuff doesn't do anything with it, it simply forwards it to the
> select/deselect callbacks - So changing it to a void *data shouldn't
> really be a problem.
>=20
> You don't derive the parent i2c bus from the i2c_client.

Ok, but what do you suggest to put in "struct i2c_adapter *parent"?

>  Rodolfo> I suppose you can get better result if you define your i2c
>  Rodolfo> multiplexer as a dummy i2c device. The you can force it to
>  Rodolfo> be connected with a real i2c parent by using the
>  Rodolfo> i2c_register_board_info() function.
>=20
>  Rodolfo> What do you think about this solution? :)
>=20
> Sorry, I don't see what the problem is?

Maybe if you provide a littke code I may understand exactly what you
mean. ;)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--/yfn7NBi5qsQ3/E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIXh3bQaTCYNJaVjMRAv5tAKChp42HSrCDYOuoa4wJAERmlpsaNgCg4Jwm
xEwbjDFVRmOlAjI2f0Qr1ds=
=WgkY
-----END PGP SIGNATURE-----

--/yfn7NBi5qsQ3/E8--


--===============6571822020674260999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6571822020674260999==--
