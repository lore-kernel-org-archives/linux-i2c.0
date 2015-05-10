From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
Date: Sun, 10 May 2015 20:34:32 +0200
Message-ID: <20150510183431.GA1510@katana>
References: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431192213-2904-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2015 at 07:23:33PM +0200, Wolfram Sang wrote:
> Commit 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from
> device-tree") added a codec device instantiation workaround
> unconditionally although it is only needed for onyx. Do it conditionally
> since keywest has its own codec instantiation in the sound drivers.
> Thanks must go to GrowlTiger from Gentoo bug report #469132 for
> bisecting.
>=20
> Reported-by: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Tested-by: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> Tested-by: Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Fixes: 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from d=
evice-tree")
> ---
>  drivers/i2c/busses/i2c-powermac.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-p=
owermac.c
> index 6abcf696e3594b..cad5552c0cd4e4 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -285,7 +285,8 @@ static void i2c_powermac_add_missing(struct i2c_adapt=
er *adap,
> =20
>  static bool i2c_powermac_get_type(struct i2c_adapter *adap,
>  					    struct device_node *node,
> -					    u32 addr, char *type, int type_size)
> +					    u32 addr, char *type, int type_size,
> +					    bool found_onyx)
>  {
>  	char tmp[16];
> =20
> @@ -305,8 +306,8 @@ static bool i2c_powermac_get_type(struct i2c_adapter =
*adap,
>  		return true;
>  	}
> =20
> -	/* Now look for known workarounds */
> -	if (!strcmp(node->name, "deq")) {
> +	/* Now look for known workarounds for onyx/aoa */
> +	if (found_onyx && !strcmp(node->name, "deq")) {
>  		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */

Okay, so this patch is bogus. I understand now that onyx uses another
codec than TAS, so this change will regress on other machines. However,
it shows that this unconditional instantiation of the TAS breaks sound
on Macintoshs which still need non-aoa sound support. I assume there
will be noone in the near future to convert Keywest to AOA, so we'll
need to find a hackish way around this instantiation problem.


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVT6S3AAoJEBQN5MwUoCm2wg0P/j4wgBvt54dj0f1Gjnv3+Xo6
K7RfP++zyYUYT6N720AMPoeIT7XcVXAxKMfB6VpP85WHRb/T5RobSUP5tf12jUu7
6xXZ0KXFryKbb2rEJqWGZgZEDbCtfyOxCdTMwvoKbQSo1F2AZ0+p/RUKqj7cDNKO
4LPDA94BACuvxD2s71eByXzpDO6395y3s54m8qDiXu2wKuLfrHA/xJAsQLlR0Jv/
mPlZrseFQn1UFk3GRvhkT+J2Y/CD6npcZh2Xp7tUheukoCt6HBBZ2/BbS5ZWvENI
LRFtoiwyJJcOJfirpuBBqhs04ZdL9sj4GuW8A5gAC8zi07GvrxdwE6JudDfHn3GX
aYxELaxTQXunk2Ee3+S3jH+jVf1ZEVLT66yvOgT9veb9FcipPcDp714TkT9SVnKd
r3tFQLRhTm2YH2k89UqBpFuCMN96AeBUjiDhh9vvUoSzitIi02vJrUgZSHjYkgvq
cKmOmBsMxgbAXqcZ1plw0eFYZSIRuKi/76fhfTetVdyM5wlQpPvDQIn4sNk3Uf5X
/rTzUGFQxzCawH4X/e1PEaCKBUw3R14bnbBr0OlOUsuIWBn+XAYjVC3k2LE61fNG
iIZOaCC5pYDs5qJi6uVwJCVt5K/Em7hiWnfJ8XfNxRVU13oquliQqYUyKPsqwZmR
64KC+RJvZWmh7xUo6zoC
=3Aaz
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
