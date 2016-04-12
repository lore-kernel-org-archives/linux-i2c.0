From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: xlp9xx: add support for Broadcom Vulcan
Date: Tue, 12 Apr 2016 23:40:39 +0200
Message-ID: <20160412214039.GG1526@katana>
References: <1460377886-22437-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59660 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbcDLVkn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 17:40:43 -0400
Content-Disposition: inline
In-Reply-To: <1460377886-22437-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 06:01:26PM +0530, Tanmay Jagdale wrote:
> The Broadcom Vulcan ARM64 processor uses the same I2C controller
> present on the Broadcom XLP9xx/5xx MIPS processor family.
> Updated the Kconfig by adding ARCH_VULCAN option.
>=20
> Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>

Applied to for-current, thanks!


--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDWtXAAoJEBQN5MwUoCm2ahgP/2eEtRb0eOxMi/en7LLU19hx
XdHWQZygjwpMSbZURvyL7bEcc5gI2vJJdeArhMtEMCibVS9EPrKIQ7Xq9zfJow3J
eLHb3E4yL7uve3aBFWW0o0XBs1jZ2djVaS/mwFJwVNNtrxL5tXoOcsj592CCDkCS
7br6mT5ggfPgN3/B1d/tTN+JNijyIj4+pE3lYhcg3N8yBDbV5o1XXT4xwcVfSrIC
Zf7Lf6g1p0N2lrikDfMZIl4M0+3zEDS/mekNM73PgtitG2UNkL0SmTdoJTmlzpol
B8UOzkGq0trOgpO15PFNe8+1zyV3XocGZT0U+DL7Q+TuVBQ9F3KrcfP7QNvZzJ0J
8T7wt+Es2BY4bp19HjdlLlwtQf+lZNJUWuLrDi5Aobg/gk3jdNzkXB5Hd+uVIYmF
CUit4ljvDWyGROHDETi/6q8YpUnxw9tkGpt8liV6GFtsfLr5Sdd82ZKvLTr/iztK
NU67axzhq5yl8XFMelIpcRcr9zZgMwFbI0HrZsAXZdUem1VDgNptMEp1OLmjZz6n
M1q0uRVWWvYM/qH70/kjbY19+j6dzuEGydmF0uE/WeB64vdD5tHjKPBhW9halMXQ
YWzyTOWOiCB+P4Z3smV7VCFn7Vh1SojQNbzNm6RAw6bM4q9Thxau2aCbj4YLLbs+
7sa167LtNW3oIVMzic14
=DgMM
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
