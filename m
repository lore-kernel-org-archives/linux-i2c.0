From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number
 read
Date: Fri, 11 Dec 2015 13:08:32 +0100
Message-ID: <20151211120831.GA2742@katana>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 11:25:17AM +0100, Bartosz Golaszewski wrote:
> Chips from the at24cs EEPROM series have an additional read-only memory area
> containing a factory pre-programmed serial number. In order to access it, a
> dummy write must be executed before reading the serial number bytes.

Can't you instantiate a read-only EEPROM on this second address? Or a
seperate driver attaching to this address? What is the advantage of
having this in at24?


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWary/AAoJEBQN5MwUoCm2MvcP/3NEKZJb7+rXxYbK1nej7OY0
gC1zNsJ9XGwrKoDz74/qzPNnasPKiKMxXdRTFcjs5Ydi1YvR+qEglm0lcnDQwUg6
pzhDgjRzTiJC0ilULTHhrRXJ8MjaYF+3fCSSI5dlIKWP49HR/5PbEWnnp33jpGDp
VDbBoYW/naTKHbUTaneG0BzcCIapRw7MRRYVx/wHyXKyx9kpDHvebA4uceScllcS
dghcd7RmBGvj2+So0eRX8DvsrYvlL14TSDkWuLPOcVrk/vzjbj6cYvi6o+kCV4zK
K1apOJc5x37V6umk80GL3w58L7Gol4g0k53svZBcVPhNhQrXWwAPSMTa07to5tuZ
gopL6nv5Qd86a6k0T+0L2g+QFdX+F4DWRhBm34csO/V/SjLCT72pV8hCgO4+u3dU
NbruiX4QPjlsNbkCerZWMS5zGIWC5u9eMu/DQiqvVuK5Dy+RT5nFQLmwSGZs5/CV
/d93H3ZYYzre2wy7/3wqibRDd1i7Kh8n8cL6HzCgeDTzYh6FbMN+x+KJzK/CP9u8
rRSkyrs4P4Ux1nBK3IWqaBWtESMoiEpDPqLaab3lNkzXrVpuehHnaaAyvgs9QyDW
+3QGpJwoC03hOOE2zMb+p9zrzNjkzTR5v+MOKGGKDB93zcploEaCGzqsVYpjFgwC
YA0q41s3Jp4sOw5E36Qs
=Og6a
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
