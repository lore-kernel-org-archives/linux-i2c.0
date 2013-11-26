From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-bcm-kona: Fix module build
Date: Tue, 26 Nov 2013 14:00:14 +0100
Message-ID: <20131126130014.GH7427@katana>
References: <1385409678-4398-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385409678-4398-1-git-send-email-tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Patches List <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 12:01:18PM -0800, Tim Kryger wrote:
> Correct a typo that prevented the driver from being built as a module.
>=20
> Signed-off-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current, thanks!

Have you also tried repeated module loading/unloading?


--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJteAAoJEBQN5MwUoCm2gHcQAJpgTYtr1ji17RZs4GZnfUQs
8jxC7N/pyIzYuiy0n9cY+1HYzltiOho58skPvMdGzonodxoIECNy6ReR4NCfL/e1
VQbnNHKAByOZAhV0KZpBOBABc9HwauFnmhe+tfkThWzyczNZACjMYRGRaat1/RX3
nK/EEX0BNRGaqdKlCbGrrZFcfoVtw/s/BuVwiGaGYbp9JgvQ8TOv9eFwrDnF1Syr
U1w0kSQI8dT/WBdc9MNUyOED/niV0ATyW1kRUHQrP4158Oq0+8od+c5OiZdLq82O
mzO39ZIpnZcsy6vYIgo8+snh2OFaq2g8ro/jUasK4zzPTa/a1g3vRaiqlsO15kWK
ye15Ev9kS1LlHX4TvoUwp+v5IpJ+lf3+dBtsXxC4MVsotnkaW+zwW3bRWfQk/ugu
CoENTgTpIDXLLB7t5TYbNcIAejkohojXTRNImnfRXZhcU+ULOHxy2qVRyno+y+k2
OHQOOG+cedSxOfEsMQIehPq5fMlVc6C8+lAV84IWyc0WdqON7bRd58H2ydDDrgFC
06upR/rqNUOQ5U5oGGg7YJsqK978R9g11dDozM/uYywieuxGiAGopV4M3GVbrNd3
H0uAjxRsBA5CBaE1VV4bPaBXTwu22hk6d3Ca5iQwHJY8NfD5hannR4aEYYazw4EO
HHiaQFsWd0xEgoYOFa9d
=l2+p
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
