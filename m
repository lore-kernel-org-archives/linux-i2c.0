From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: slave eeprom: clean up sysfs bin attribute
 read()/write()
Date: Tue, 28 Jul 2015 08:11:40 +0200
Message-ID: <20150728061140.GA1598@katana>
References: <1437945391-27823-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437945391-27823-1-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 12:16:31AM +0300, Vladimir Zapolskiy wrote:
> The change removes redundant sysfs binary file boundary checks,
> since this task is already done on caller side in fs/sysfs/file.c
>=20
> Note, on file size overflow read() now returns 0, and this is a
> correct and expected EOF notification according to POSIX.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>

Applied to for-current, thanks!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtx0cAAoJEBQN5MwUoCm2rS8QAJgtxSvL8xIlTlrc+AySC4u0
NX9a0XeQZ68cGSGFlOVALf3ENBULUPEx1vLgy2iRCh1Pw+GIfED4a1xf+n7R15kS
BEbvnBNyVqNJou4Ud7gT3xTFHLwuVAN/Dew3mfV/GcUa69tPWFPxSBzDOLfAUaIY
Au0wnVUiJVGWeLF6PQQ7W3bvsb6Q91LysYzFZrtv5C74g6sjNaZ8GEF9xK9ZdHjI
+x1Rah8ti2CIXhOAQqg7/0iq0eitsd0FQuKTzDPtYVQn20UO+HEJeNqwYu3Z6otP
3d/WaoxGG9idzRW2c+JKbzjiKaCEv9V6rKa3B1i7Au+Wdmn1yRjXA/q4HgLhryJZ
yI3sMbdnL2X40r2fbacDzQaOduhTcIJwLBRwHO0uL/x3MS7y/+PnT4GrvvaENuVL
UVQub3sj03l5UVyo9gBhDxikY7iyn1JOKKm+R40x+KrqYCtTCT/PY8T1cVwg0Tgb
b6xH+bpP6l22LvbfjwS1m0sM+yLs6irPMIAXyhnxlb6eU74DDjtL9rCm4mK7effQ
BR8tZrRIdAwPkbZheLPuZkc26HvLhoEIYQyf26kLLPWzPN5SBorOSWIupCkdEZIX
AJexxejmgDaDSfvScIx87EVPbsfIkqqKkdggYj9pu+27aBRXo2PAf8OIDmEcwk37
83fIg8SFBX2KGC7EMjLz
=MUHu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
