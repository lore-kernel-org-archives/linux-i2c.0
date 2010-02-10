From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
 functions and data
Date: Wed, 10 Feb 2010 21:32:03 +1100
Message-ID: <20100210213203.48a9105e.sfr@canb.auug.org.au>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
	<4B7285D5.9060008@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B7285D5.9060008-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> =
wrote:
>
> > __devinitdata goes at the end, immediately before the '=3D'.  Ditto
> > throughout the file.
>=20
> This made a difference and revealed section mismatches. "const" seems to
> be incompatible with "__devinitdata".

Maybe try no "const" and "__devinitconst" (I am not sure if both will
work).

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktyiyMACgkQjjKRsyhoI8wgYwCfdC8zV3yrfw6+w0HGXS0vTJmO
RbkAnj1FBCqDMZeJ11SxrZaFI3U9gdDj
=YwsP
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Feb_2010_21_32_03_+1100_6qbkzAYoAYI.ZWNt--
