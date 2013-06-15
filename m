From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: pxa: enable high speed mode for i2c bus
Date: Sat, 15 Jun 2013 16:48:12 +0200
Message-ID: <20130615144812.GD2923@katana>
References: <1370587097-21006-1-git-send-email-shangll@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370587097-21006-1-git-send-email-shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2013 at 02:38:17PM +0800, Leilei Shang wrote:
> To enter high speed mode, following steps should be done:
> 1. When running in high speed mode, i2c clock rate is different
> from standard mode. Clock rate must be set according to
> specification first.
> 2. When i2c controller sends a master code and wins arbitration,
> high speed mode is entered.
>=20
> If you want to enable high speed mode, the following members of
> platform data should be set to proper value:

I couldn't find any support for hs-mode in pxa2xx and pxa3xx. So it
shouldn't be set in platform data, but depending on checks if this is
supported on this device at all. And why don't simply switch to it if
rate is bigger than what is supported without hs-mode?

> 1. "high_mode" should be set to "1".
> 2. "master_code" should be set to "8'b 0000_1xxx"(x is 0 or 1).
>    If no master_code is set, set to default value 0xe.
> 3. "rate" should be set according to specification.

Note that you should fall back to full-speed mode after sending the stop
bit in high-speed mode. I can't find this in the code?

>=20
> Signed-off-by: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Which SoC supports this? I'd like to have a look at the datasheet.

Thanks,

   Wolfram


--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvH6sAAoJEBQN5MwUoCm2xg0P/iQefYXPz3h8+DSahwI3TVu1
S8c7IYmOsl7oz3vuxpb5U4+alAUXuORVQiqpukjZFOHlduWX7ZYBJKPOgHYLVegQ
8Osk9qkcyvXzuUJIaPdKI2u2+sgWhBhXZtdCXLiv/YWL+v/aOKPERM+lwvmug7dD
jDXt0jtE/D++BvbovpOaaFWAnPlkd64VZOeiv0VwahWnrBoEWaw/41iMTP13/lLC
Exaw8pEyy7VtwZwBqT2DWOZvi0yKKz2fjC6XrVS4n0bWD5xx0Yv8WbxjL8KdeJIr
VHOcrk/Z3mVyCYPG/1VAFMNqGUOoiTg2V8QKK1DT1UrcxIG+SnjCXzvhtcww/Yuq
C3Sa4ByFf/J+cNa02L5ZmE41fAaWcHsUS/rQezu7UyIbAly8GTRteJWwGqpWIS7h
hlyWJgMm/G3hlsae7MLRlD6RGGYL0Jl1+VYCV8Sw2WcKMftKj4Q/+UX1sBngR6XH
aL4ri39gUCMToH/mcDREmDe38mcsqd+e59ub1dhNsF7IClClC8jyZWZoQqx2BgmA
lqEwSgGqfTchGL7+uOj5AZnsWyhSAVTqa3tNpGOESIe/seqaKiB6RjLgiSiBB0uQ
YX7nG+8xGZr3fEM04AI7llOub0smlthCijFzD5S45Da6V1TCtiRkkazum/V56pfg
/uyYmcbfT6PJamqhxsO/
=jkPy
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
