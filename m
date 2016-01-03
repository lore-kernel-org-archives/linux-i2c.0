From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 04/10] i2c: st: use to_platform_device()
Date: Sun, 3 Jan 2016 19:55:19 +0100
Message-ID: <20160103185519.GJ1522@katana>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
 <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56579 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbcACSz1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:55:27 -0500
Content-Disposition: inline
In-Reply-To: <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 09:15:42PM +0800, Geliang Tang wrote:
> Use to_platform_device() instead of open-coding it.
>=20
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied to for-next, thanks!


--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiW6XAAoJEBQN5MwUoCm2z6UP/3CxcQQFpwWumHEyC1LKv+Zt
uv5m0OiHWrECtarzJyyL0eHuK7EIolHG6kh3ZhlMh4YSBQ4fdtsjpPw0laQ2RWC5
q7qAh4zfrRC+uV4Jj3dugZ5ppd/FvzLDz8pPDyQoNjRUdLvaVekrIV3OT8KShPW2
zf/I1zL0lxsNO5E2z4xVz6N2W5Emz/GTge/inqqbPBvgveEk+zpjGdDeyXjpqB7C
o8nageTp1/bj26L0Vu+I8nwdKvmULxFj40y8MsBsYKRxe72UVow71doBNmaXLpZ6
k8IlItmBmZh13vsMwZcRPStWmoShEkRC4+UJ8pTNCL7zVxzh+lrBnbINbarTA0mq
oh6VaYW1Z1sVbNnrZ/kiUM6cPSwMY2u/fnhiRYn4j5D6PtN1bi5N2caBAiZcecqe
DQndODQMWBPQALuiIjZ+F8hSRF8GlvqSZKJBnBvbgkJtguhkhNmfH41YL5P6ooAO
W4F3AXPaS4JPJJbBGcxVf61A2KFUqOuU4IyR9dkdlOOcL48kTFKryYtp9+VSZve1
6uVQLJX5NPmBYWLDUh1DMKvN0/N1f+/H5PYG1ddovf5Cem10Ah8+s40iIZ9/PhHG
6ph+dRNx7BUi3TcNcONhoxC8iAPrr/wrXGhlIc1vJuIA7J+1KGIToujIx8HCimVn
xVt+73eZV5BT3oLkR92G
=ZZDj
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--
