From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: virtual i2c adapter support.
Date: Sun, 22 Jun 2008 10:52:06 +0200
Message-ID: <20080622085206.GM10695@enneenne.com>
References: <1213895701-9872-1-git-send-email-giometti@linux.it>
	<1213895701-9872-2-git-send-email-giometti@linux.it>
	<87fxr5sw5f.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5181103445115770877=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <87fxr5sw5f.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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


--===============5181103445115770877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="abrXHEFNt7TvgPF5"
Content-Disposition: inline


--abrXHEFNt7TvgPF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2008 at 10:37:16AM +0200, Peter Korsgaard wrote:
> >>>>> "Rodolfo" =3D=3D Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org> writes:
>=20
> Hi,
>=20
>  Rodolfo> +
>  Rodolfo> +struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *p=
arent,
>  Rodolfo> +				struct i2c_client *client,
>  Rodolfo> +				u32 force_nr, u32 mux_val,
>  Rodolfo> +				int (*select_cb) (struct i2c_adapter *,
>  Rodolfo> +						struct i2c_client *, u32),
>  Rodolfo> +				int (*deselect_cb) (struct i2c_adapter *,
>  Rodolfo> +						struct i2c_client *, u32))
>  Rodolfo> +{
>=20
> How about changing the struct i2c_client to an anonymous void *data
> instead so it can be used for systems where the multiplexing hardware
> isn't a i2c device? E.G. I have a driver (currently not in mainline)
> for a I2C multiplexer implemented in a FPGA together with the
> opencores I2C controller:
> [snip]=20
> It would be nice to be able to use the i2c-virtual stuff for it.

Mmm... I suppose is not so easy as we wish since there are several
references to the i2c parent struct into the code.

I suppose you can get better result if you define your i2c multiplexer
as a dummy i2c device. The you can force it to be connected with a
real i2c parent by using the i2c_register_board_info() function.

What do you think about this solution? :)

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--abrXHEFNt7TvgPF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIXhK2QaTCYNJaVjMRAiumAJ99uYol1y05LpufgVszB7MtYa2E6ACfavMh
p+j4+AtLDGQHiIldaIPr9IE=
=+CXA
-----END PGP SIGNATURE-----

--abrXHEFNt7TvgPF5--


--===============5181103445115770877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5181103445115770877==--
