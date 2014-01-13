From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c-ismt: add the support of the
 I2C_SMBUS_I2C_BLOCK_DATA transaction type
Date: Mon, 13 Jan 2014 17:46:52 +0100
Message-ID: <20140113164652.GA14602@katana>
References: <5285704e.jwiZWyk8R3ZEoySS%robert.valiquette@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5285704e.jwiZWyk8R3ZEoySS%robert.valiquette-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robert.valiquette-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2013 at 07:52:30PM -0500, robert.valiquette-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> This patch adds the support of the I2C_SMBUS_I2C_BLOCK_DATA transaction t=
ype for the iSMT SMBus Controller.

Wrap the long line next time, please.

>=20
> Signed-off-by: Robert Valiquette <robert.valiquette-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---

> +		/* Make sure the lenght is valid */

Fixed the typo and applied to for-next, thanks!



--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS1Bh7AAoJEBQN5MwUoCm2978P/RCSrZSRzk6XI+kRIowwJzg2
q2Htk88WpdP/wUC1Tousp+6NZzO5Af6KVKxtZ9ad7kEPLHuDrdw0wIpxUiKEf3X1
wYHOaJGKqQvdm33RAlrBH4eNjb2swX3q74v441uaued4yXLu0PmYfd3u+eHqOqUQ
MBKQa1b/qeaAhx5NoY5YQLh2AO/yS5bkWlGx58INsLrimlJyu5NJctsbE5p/16jm
UD9Bm5z+L9ah04Eyh7C1lYif33ExtMx1kPSSr5ZqLss9WJvWEUl0F7iXnIZHKaea
Ii25tOnHLOly+yNBRlOK35M37pWfFx38zAq2SOOgRf3rPbDY51pYzQrkLsqlK3mI
eLLOhaVr+/z4iMmxa+30P3xCRNU6AjcaN4sRW+x2bXkvLx9iB2ufU7icKoGBFAeq
rbRQAazOkDOdUiGLAWS0B0H80SpGeGSsBM6WUgijLW95SWJH4efnlJxdCbedDKd3
QtnteoJvDL3k3/yYqr3oXaCg4oCddrWEN90elzieNB5t/GIFZRpU9ZpuLnYXYC20
OE8A0RmZWMpQ78RLBCg5WOMxbwMpurHP2vTGYt0GjZcjzXu92/GrKwASQl8ZWA6Z
YuQacuhLeokZsg1mTtFfqxYLYQrSTy6uadyKPIfkFXXNXgwZCZ3qHMnIDMBeFKv1
DwS3mkyZRoCm1U1skRhN
=8hXC
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
