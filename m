From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [V5, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Wed, 10 Jun 2015 22:05:32 +0900
Message-ID: <20150610130531.GF1592@katana>
References: <1433878581-22666-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433878581-22666-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 03:36:20PM -0400, Kamal Dasu wrote:
> Adding support for i2c controller driver for Broadcom settop
> SoCs.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Removed superfluous .owner in platform_driver and applied both patches
to for-next, thanks!


--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDYbAAoJEBQN5MwUoCm2vd0P/jvrcGRJft0Ga8utQ0c6FAMp
X1Xr3cVA+Poxxkq72q2fu8a5hGLq5ggLYW1btWrvM72GKYszmVPV99i40e7U7qzY
kDXKQ9RWIMItS0sjzBXzEPAl3qfUJoEJOz0/vD/jvZhl32lbT7jBHDPQ3j/jNKtF
5hNHI8s/5G4jfEmmzVwtXluh+2vycjJkCW9MXU+4UpxxCKJipJcxRO+LiwY29Fdv
739FXJu9wrGqgh75rd+I/gUOIqGxOZiUcXilHWtn/GXhNK4ZCepvKL7r7Gv8Ic94
F86Q6uLIIe0pq1BeZ5eeZ4LqME1b3HYG5/5ojnrSxeo2S3Qz8vASVck1PVtrL3IU
lsuQ4C/1y+9wvVp2l+1n3VSs2/QtX+OByTnQYXPHoqCq3PWlIsoUeeVK2bc4vKZt
ceJrkXR81Am0dP0Fqq44ywQMddngxHUBu3eFSc/NiyZ5maxws5BYfAU+uOp7nCdE
2HriU4mTIupiZppRWwIOj8xqoXXbZeVgHC5+igmvvIykDzRmzxEzsdGtAFoAlPxg
I9r8dJfjVCdpBLZqCLSVeLglhFuyOu8ZVG/lbJyFJiWQUTAn5O7W14t+klHLW60s
w6GrEjR2lhauzPPXn+/HvQ3AVV9WrU/xmGDd7f2fBl5CGNaOzZZyf1SUAtaIyU5e
k0JIXU+5oUBpXLJWpc4w
=geoL
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
