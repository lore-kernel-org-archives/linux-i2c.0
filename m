From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6] i2c: cadence: Check for errata condition involving
 master receive
Date: Wed, 14 Jan 2015 11:37:18 +0100
Message-ID: <20150114103718.GA2615@katana>
References: <1421174099-19839-1-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421174099-19839-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 12:04:59AM +0530, Harini Katakam wrote:
> Cadence I2C controller has the following bugs:
> - completion indication is not given to the driver at the end of
> a read/receive transfer with HOLD bit set.
> - Invalid read transaction are generated on the bus when HW timeout
> condition occurs with HOLD bit set.
>=20
> As a result of the above, if a set of messages to be transferred with
> repeated start includes any message following a read message,
> completion is never indicated and timeout occurs.
> Hence a check is implemented to return -EOPNOTSUPP for such sequences.
>=20
> Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Applied to for-next with some whitespace corrections, thanks!


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtkbdAAoJEBQN5MwUoCm2nfYP/0H8SYdWn4SA73uwqLFo9rob
fBpN69GZPGko5lS36jDp4thSmBRJnQlaIQeQgA1IqG1ftmgWDgJAeCWpxfFxO6pt
ZSDRtDzkQv+8I8hfNQa1dXH5a1/kiQ3WSqCFSFeIWIDsozjvy7shFab/JLvrX9/A
Jd+NN/6ExJszXrUbOId9AqPIK2ZZZWy9iX60Z1fJSwRQsjw/uKq9QsmQQo2H9s3D
QF3PiTionlpsT9LqfTRi+dD0o1eR8qC79gG369iJUkwsxTzNXwdWp54P5vP6/ZcY
LGJV9HtZiSJhZMfcBWMH0weeZkEcw/8cWvsx7dwmSrL/utagYpol7dXXr5+pqlE4
dxBJ/Evg3A3JNlouolGsDnSYEduypmBo5hFNXwa1Ivd4JTRYZJmxUDGee3syvcev
pMjFA0akgNBdgLHnn4D+FzzvbKSO/3RAPDGKWG7dYRjTxc8s8MEr6X5Jm76tHsZw
Ya3tCT3SYJY4ooLola2mTb6RcKx9KkZrvMlvc2EaBYSuXRbGBPlnVk1cXgkZp8KC
+G4KG/4X59LgrFLLfDPCEdxCl4KfZVSy9jmcd3gxjPkWqw+fAvjHq4bVcSm+L1/e
j1Hs4FCMEaTfeqja3TKA+9xxkOriuStx99aKbQVM7Npk0xwoGa/n2acyPjh/tUzv
wnMgyTHsEoDVi6uqvfba
=Qtnr
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
