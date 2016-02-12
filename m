From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/3] i2c: iproc: Support larger TX transfer
Date: Fri, 12 Feb 2016 22:44:37 +0100
Message-ID: <20160212214436.GC1529@katana>
References: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
 <1455311443-30590-4-git-send-email-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:60791 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcBLVok (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 16:44:40 -0500
Content-Disposition: inline
In-Reply-To: <1455311443-30590-4-git-send-email-ray.jui@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2016 at 01:10:43PM -0800, Ray Jui wrote:
> From: Ray Jui <rjui@broadcom.com>
>=20
> The current iProc I2C driver only allows each TX transfer up to 63
> bytes (the TX FIFO has a size of 64 bytes, and one byte is reserved
> for slave address). This patch enhances the driver to support TX
> transfer in each I2C message for up to 65535 bytes (a practical
> maximum, since member 'max_write_len' of 'struct i2c_adapter_quirks is
> of type 'u16')
>=20
> This works by loading up the I2C TX FIFO and enabling the TX underrun
> interrupt for each burst. After each burst of TX data is finished,
> i.e., when the TX FIFO becomes empty, the TX underrun interrupt will be
> triggered and another burst of TX data can be loaded into the TX FIFO.
> This repeats until all TX data are finished
>=20
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Tested-by: Icarus Chau <ichau@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Applied to for-next, thanks!


--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvlJEAAoJEBQN5MwUoCm2b7QP/j/lyeRF4vwnIUVmSZVEN40N
76CQg8OLn5bUO+q/O0jdSVCkr2e79fOGE09PRjmPFTb+U8A/pIFEnhixXCOH9hF7
NJmOxxQ9XbHo9uZmk6DK7yAS3GIDzFRcfLN0ToNB3ih8KerR6Km+4NKNzG+ZcSQB
h12tKeA0E0/LEgH+Rk3LpTsxZySu9g7Pj+FGLbPixNn64euVt2NtXDovOtmbHAoy
EMBgakREgfcys4UY53+2P/gqqXkfoQtIdgH6f4/p1BqVWCtNlBgYz4qt7lEcBHqk
F02SDx2DKpGLziRBRy95l5lGq2KhHWRhTJNwsmMCCmpu+rTBQgOjfcgvt3fIdzgS
Q0IFOMAQmT8SHjrButn7Qsl45RGtKOiNNpYCnl1oGPJ1oyxOhzrS0Us9eaenXR61
snIcIhbF+qKPwwIsZD7UA6K/vjPBpgklS6+qH52u04VukzWErBWsDWOL56GMlAar
5FzrG8cDo0kzXL8xNm1trZAUtt+fxML85zZnJx+ZW3bD4N/29uHvgo3sSFajZnmJ
sEpgXq9DyrmZKVIzWjA/NVfgUmFwq+LDYsf34wcspU6PYiussgCrA8Wb7//Mt/S8
GjWaBWIsAxJbVvVFZZxggJm4sBs0JZLbsf4pqWftEXoKIuA5z+GbQR+xy7RgqWJe
MG0eSvxEvmXayVyJz6aZ
=HsCm
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
