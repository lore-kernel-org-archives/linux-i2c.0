From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: assign the correct prescaler from SVR
Date: Sun, 15 Mar 2015 11:08:14 +0100
Message-ID: <20150315100813.GH6770@katana>
References: <1423583193-28450-1-git-send-email-valentin.longchamp@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423583193-28450-1-git-send-email-valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2015 at 04:46:33PM +0100, Valentin Longchamp wrote:
> For the 85xx platforms, the source clock for the i2c-mpc can change from
> one SoC to another. This is documented in the AN2919 "Determining the
> I2C Frequency Divider Ratio for SCL" by Freescale. Not taking this into
> account can lead to the output SCL frequency to by off by an offset. It
> was observed on the P2041 from the QorIQ family.
>=20
> This patch fixes this problem by setting the prescaler value to the
> appropriate value when required. The SoCs that required a different
> prescaler than 1 are identified by reading out the SVR as discussed in
> http://thread.gmane.org/gmane.linux.drivers.devicetree/94247/focus=3D20556
>=20
> Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>=20

Applied to for-next, thanks!


--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVoNAAoJEBQN5MwUoCm2LXYP/23zW92nV6Cu/OaiAOK74Zqu
lCc4Sy30+lPfCJkJsTmLQfvUo+FpyCgGrEXX1AiFi9yz7BLmmpgjjVBAxox5dlfZ
915HRanFI1wlSbsav1qU0uVEcgiW/xcOF8SQQ6OcUNvudc56lMZwIwZ+iYvECoNq
bvxZiNze7ynptTZfftphU8e41B/SWLNJt29W1iP+IlWKLv4ShAv2A8CEBYeQcELA
LTn188KQg5aiEbS/LnzNaVIMcjO1pq0piv0ksW377DakE2m0woL1h8VIkZMf9fSL
fKLAIMjYk4BOqvDvcxvYTizPlAL7HmlS72wGZJ9vm8cVikz8aNA7dR6NOfKrEFGd
Tcifyjgp8OGMSJYz4RvF7Ka3RhiHxf97z1hDOc0gDFcE7QuAvkVT2mOG8zATavHE
C4QkwWAUbWcmFGrqrNHOaFeXD0LWTTrD80kpVYRZMUnao178oENcJHug+S3wxLI8
2heWIhEQZx4PpvW9Xu2PQXzYGkQO+ai6fUbr6FGXJlhUJLWaWqxZ6E4yPC9FkVDW
eg2X6iUC/5A5JIxqoakBfCN5ZEycoWo52DlX3P39wDyeHhscFGKXz8zqOEJFH91P
CWN00YLGhCHezjb8qNsuLvZLK+HCWYG9/mH1MTEHg9bXTVwytmw0QkNZBAwjlCEM
g98lwWL4MbZxg3QmsJOz
=Iv5e
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
