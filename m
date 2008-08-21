From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Thu, 21 Aug 2008 10:45:19 +0200
Message-ID: <20080821084518.GY21330@tekkaman>
References: <1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
	<20080622085206.GM10695@enneenne.com>
	<87bq1tsue5.fsf@macbook.be.48ers.dk>
	<20080622093939.GO10695@enneenne.com>
	<8763s1spuw.fsf@macbook.be.48ers.dk>
	<20080622125010.GP10695@enneenne.com>
	<87hcblqmi0.fsf@macbook.be.48ers.dk>
	<20080623092658.75bddce4@hyperion.delvare>
	<8763s0pp0r.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5156209992799071438=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <8763s0pp0r.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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


--===============5156209992799071438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w1TwAseT95X423KH"
Content-Disposition: inline


--w1TwAseT95X423KH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 09:51:48AM +0200, Peter Korsgaard wrote:
> >>>>> "Jean" =3D=3D Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
>=20
> Hi,
>=20
>  >> Except that core_lock is static in i2c-core.c.
>=20
>  Jean> This construct is broken by design. If you don't know if the
>  Jean> mutex is locked, it means that you're not the one holding
>  Jean> it. If you're not the one holding it, you don't know when it
>  Jean> will be released. So it could be released in the middle of
>  Jean> whatever you are doing which requires the lock to be held, and
>  Jean> that's bad.
>=20
> Exactly. Either we put it on hold for the core rework or we add a
> i2c_del_virt_adapter_nolock() variant for the mux-on-i2c case.

The problem is that into i2c_del_virt_adapter() we have to call
i2c_del_adapter() and the lock is already holded by i2c_del_driver()
since the mux is an i2c chip itself.

Do you think that the problem can be resolved if we use
mutex_lock_nested(&core_lock, SINGLE_DEPTH_NESTING) into
i2c_del_adapter()?

Thanks for your help,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--w1TwAseT95X423KH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIrSseQaTCYNJaVjMRAvyUAJ0Y0V31x9zU6LBuOXXeEK9yA4EC9QCfZDzG
QgUfN+GFSrtouNDL9eGRj2A=
=7zaZ
-----END PGP SIGNATURE-----

--w1TwAseT95X423KH--


--===============5156209992799071438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5156209992799071438==--
