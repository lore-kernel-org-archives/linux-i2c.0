From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: move locking operations to their own struct
Date: Thu, 25 Aug 2016 18:05:06 +0200
Message-ID: <20160825160506.GB2856@katana>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
 <1469780277-31085-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46082 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758242AbcHYQc4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:32:56 -0400
Content-Disposition: inline
In-Reply-To: <1469780277-31085-3-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2016 at 10:17:57AM +0200, Peter Rosin wrote:
> This makes it trivial to constify them, so do that.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxcyAAoJEBQN5MwUoCm2lOAQAIeemRxphXS4Dbgr0lQgSWQh
Fu75eIewOzVWZ92S0lA0KhMoTxWijecVZbSVyuvKrt3pcvnIXB81dFFw1uj3/H0J
krUzA7j0ifbbqINHjO8fCrObqXVXVyx5xSiwNxGLRIxEOUhiaJPiqkU5FCgVEW85
DcEgpWai0Fe/gEi1bF4PTteBsvTD28Tlh7NX7v/dJmFF1dRoJEVik/0XXW3NZvMF
dUZn+AVeMjPj6b376TY5dOKYqIJECBEkEn8UMxa73KmiO10R+evVdTG5LQLkBqSn
EPVNSipSWi7VKM9grVerQxGAPlqNdRueZNN25UrUKS9haNz69SdTuxrj27Nx0VJV
Rw1lMqdSxpvFiFC7NeAkdGHZD1F3bTy2mRIr/cl47gzoasrJO0ZSSq1FoJuaz+lx
CbvAH6B4t0obbQPfz9XMN+aMySNip4xiMcAl1XFJY8Zrq8nHFyg/atLlxubaV9ED
zJC6A3RDoVe6PI0GKJMXuZO5yDVz2MhhRlwPpuDHIqQAzNej6bsxYASkJlxpiPNm
LwgMM5hucDksr17eAbIhTzKjxEpMDpRU89m2OUM0iWK8DbGv/q4WmIlZT2JoKpfl
HyCylx6APtOyF7IsDDjeobE/bJj4md4g1t1sdRdH4OCBKrlsbrgS8S4WH47apWBR
CCFXOGh/eZ9eGZKFJxmh
=ODIc
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
