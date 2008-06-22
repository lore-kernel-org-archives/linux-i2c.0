From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 14:50:10 +0200
Message-ID: <20080622125010.GP10695@enneenne.com>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5007402748138149029=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <8763s1spuw.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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


--===============5007402748138149029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XDjvnsv+LUV9J1kR"
Content-Disposition: inline


--XDjvnsv+LUV9J1kR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2008 at 12:53:11PM +0200, Peter Korsgaard wrote:
> >>>>> "Rodolfo" =3D=3D Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> writes:
>=20
>  Rodolfo> Maybe if you provide a littke code I may understand exactly
>  Rodolfo> what you mean. ;)
>=20
> But I did?!

I mean the code that shows how you wish adding your i2c mux by using
i2c_add_virt_adapter(). :)

However, we also should make attention at i2c_del_virt_adapter() which
must call (new) i2c_del_adapter_nolock() since the core_lock is hold
by i2c_del_driver() when the mux is an i2c device.

If you define a virtual adapter as a non-i2c device I suppose we
should use the lock...

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--XDjvnsv+LUV9J1kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIXkqBQaTCYNJaVjMRApe8AJ4ng8Fe61IddgEi6s9lDQZzc0qChgCfQQVr
AasH/q9w+PipfxoFENXBBFM=
=8FN6
-----END PGP SIGNATURE-----

--XDjvnsv+LUV9J1kR--


--===============5007402748138149029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5007402748138149029==--
