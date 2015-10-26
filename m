From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: at91: manage unexpected RXRDY flag when starting
 a transfer
Date: Mon, 26 Oct 2015 15:47:26 +0100
Message-ID: <20151026144726.GB5588@katana>
References: <20151022130847.GE1517@katana>
 <1445852312-28389-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51867 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbbJZOrb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 10:47:31 -0400
Content-Disposition: inline
In-Reply-To: <1445852312-28389-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, peda@lysator.liu.se, cyrille.pitchen@atmel.com


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:38:27AM +0100, Ludovic Desroches wrote:
> In some cases, we could start a new i2c transfer with the RXRDY flag
> set. It is not a clean state and it leads to print annoying error
> messages even if there no real issue. The cause is only having garbage
> data in the Receive Holding Register because of a weird behavior of the
> RXRDY flag.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA
> controller")
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Tested-by: Peter Rosin <peda@lysator.liu.se>
> Cc: stable@vger.kernel.org #4.1

Applied to for-next, thanks!


--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLjz+AAoJEBQN5MwUoCm2i8MQAImiYiIHMtD61s5SR4WSsOXB
ZDmTOB9DHTd0kgVwjUJbQogOzEnnbwTtA/e7j9QFT9ca5xc30ymh6BYkEXk+hqHc
hXFThLrUeH2ir1xDpmI+/xUj8vKhx897XwoC4ZLjEQXQ9FMjr2Pquq3HRSRb8Txs
B8ALZoZqnWPMVl8I9/14ZxToXo0ECsr450IDmU7hWWdBOM9vIB8JpQsTgh+UeF0P
Iu7vVj83TlK5lOXvuamZ9gaodSZjVdSok/sAVRHPC0yBlQC8U+5vNLYFs46qUdR+
vMIzAnqv9FUZrIanc22LyxQLssBrVJRGIGGsU/yRuwH1KslLXMp/csTibJr9qQT4
4jjeOU5YN5fEEOxTk1KEGKFGz/82AcRtWIk7lq3z9nMV+lass/qN3NFTn4L7lBvb
06jnzkpvLgX+q1+BcQ/20Xor6w4Y84HAM1wCaR0xGCk1GaDvdas8vNspv5muLhcf
mb5FEbEdxbpr4lk0MOG/9KPnHffmi3q351b3OdEmByso6Zy5tKgPT5R46JwxEWbd
sH2o0Yg16RP8HBg7nyqZadVn/UoLV9ESCPt3Rz7rIPxh/Uf7VwODzBCaxkOVSh+t
EBIVD8ny5u4aNqxK+fNewAvkKMMbhxEDI57ZdSzPaKdFd9ky9QxN4jpEUMutHEfV
CdynZC2EAlIkrBYIqd3K
=UGM4
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
