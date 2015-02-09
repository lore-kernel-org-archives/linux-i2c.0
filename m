From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: match return type of
 wait_for_completion_timeout
Date: Mon, 9 Feb 2015 14:21:45 +0100
Message-ID: <20150209132145.GD2491@katana>
References: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423400155-28078-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 07:55:55AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> ret is only used for wait_for_completion_timeout anyway the type is simpl=
y=20
> changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Same as for the axxia driver: Please rename the variable because ret
being an int is kind of an idiom.

> ---
>=20
> Patch was only compile tested with multi_v7_defconfig
> (implies CONFIG_I2C_CADENCE=3Dy)
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/i2c/busses/i2c-cadence.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-ca=
dence.c
> index 7d7a14c..5fbffe0 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter =
*adap)
>  static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>  		struct i2c_adapter *adap)
>  {
> -	int ret;
> +	unsigned long ret;
>  	u32 reg;
> =20
>  	id->p_msg =3D msg;
> --=20
> 1.7.10.4
>=20

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2LRpAAoJEBQN5MwUoCm2yFkQAJTnJncRU27lnNJ7H3yO5IKQ
vaQqvcW+IN9qxakU4RKni/w6NCMamVKWWGIhWoFek57WZWcdD1oTyPrvbVv+Wlw4
AHifVCBj/kuhzXs7uJXkmmK5o1wzf/2tw6biw5Ts6l89J7qxTVMEUC6OHv19t3bS
ahMAKana8t8XX0p4kIpkHY4e/h2EUGixo96UvNK16fCmIaQv76NxpUnomeRpCbfZ
OAjcSOd77VwMlKOcvNLSD52/WEZZAu90mAEfQUPAvBHPYTy9lV5IkiF/CoHGremo
gSuMsFAJLXjWHE3H06+znDn6gC7JMqWp708os3nTFaF0Tz2Zp5GBu4F4Vkfm4Srl
LdsToOT++hDtGlcwyAVz1fTZcSPnTDVUPb+XcByWFfPhmZRJxa0JbfhNUS+gdlX/
44bcPEWWJcJMJU4RVYfvHHKDEdlFZbi3uI5TfDg2vp2Vy1PJyMCyrchnBZeverte
SweJmNsEeNcMC96L58IhjFH+otPaPhgaPt2TBWfW3tsn5XkNCzpUmhMQGKX14wAe
QSIZ7IybPGOmQ7IRis9am2590G/4PNBwP/S6iHqMZgvOqiLnNh7CZfn6fg4qu9f9
kMP/I8U/PtrFZr4quwO8FLncG1hXwhk04Ej0jRwiRDu3M1g1D7sOrFUSu+k727Po
DfV1IyRGp54E0/KVLnqe
=j1iX
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
