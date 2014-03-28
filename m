From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix reset controller handling
Date: Fri, 28 Mar 2014 08:49:00 +0100
Message-ID: <20140328074900.GC2708@katana>
References: <1394449930-29696-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394449930-29696-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 12:12:10PM +0100, Maxime Ripard wrote:
> The reset framework recently gained optional stubs when CONFIG_RESET_CONT=
ROLLER
> is not selected. It also introduced a function reset_get_optional, that i=
s also
> dummy-defined whenever the framework isn't enabled, for drivers that need=
s an
> optional reset controller.
>=20
> Switch to this function, since the mv64xxx driver is in this case. This a=
lso
> fixes a compilation breakage whenever the reset framework wasn't selected:
>=20
> drivers/i2c/busses/i2c-mv64xxx.c:771:2: error: implicit declaration of fu=
nction 'devm_reset_control_get'
>=20
> While we're at it, remove the redundant test on dev.of_node surrounding t=
he
> calls to reset framework functions, since it will either be a valid point=
er, an
> error pointer in the case where we called reset_get_optional without an o=
f_node
> pointer or if it failed, or NULL if we're not loaded through DT.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied to for-next, thanks!


--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTNSlsAAoJEBQN5MwUoCm2YHMP/1CrANcdOxhBvyV0qJlhwFXn
tJK6QQgcP2OC5s4hVenfI5QEpw43xEm9LrfNQ3mAtJipISfGtKhF58uWc6CUuXvI
moATfimXE3OBWRrSfO70u2C1qn7LVweJwI0A3bGJk/GGvaJDcb/h88XzvN61C7Bl
zLOMwiJTSSJ8mspEYEiArBjUpQ78y0wtZ7LhVwrtOEOVucJrHPupAHU4EH/MXnZd
GtQcHrZUzm75jrxjog6Mk4RFVvPGjnuYmGSmqUkjEyqZC1DkmBj26cVpiVfsixGJ
Emihw++3KivEWk07j2c7P7i5VFWEAaeaf9YSs4N5BiU5MZJo9/5qKNmaf3vLtcqV
kIA0fMBYWVUPDF/9Kht7AcndmQ+j+7gH8NN0cidKbPPLfp6bOcGoLYbFlNZuNKRv
qfBsP9BKSikaXrLi35hupSg8l5SRVjIdPBRzDRyLNfP+DwunKyOO5mhH3VIM36H6
/mkM+EdA58/hCBhuZdiGZlB0Kht8BIy6OmtbBz5QMbeVc7LOZV4xE4PkQBpBECHa
DGnKWHLzaaSfJgWi4gRogxktX/c1MZYFt5bL9F7GRJNo8kIu3P9bQ0sGf+hMNZfN
E5LCLe6MlwmOSSgTqJ9dQdCPvkIieMUI/AWRZjveWE2sq54JDP80HHt25SYVyTuT
3eJhLB3aC8UDLHURXUPb
=NXCV
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
