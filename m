From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: mediatek: Reset DMA engine in hardware init
 function
Date: Tue, 11 Aug 2015 16:55:12 +0200
Message-ID: <20150811145512.GA1525@katana>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
 <1438845731-17805-2-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438845731-17805-2-git-send-email-eddie.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 03:22:10PM +0800, Eddie Huang wrote:
> Reset DMA in hardware init function to avoid unknown hardware state
> before do any I2C operation.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVygzQAAoJEBQN5MwUoCm2iOQP/0P6kBsLxAJN5DP7UQcedmqH
3WIUVqbV8lYRkgo54gQvrrgsN5aGl/LsKd/wCbLZdf+uIEcmkB3ZQ3EpC8GeCAfF
zPiTfjKHGSlYC2mD4+Nl7CJpkfXtD7VA9KSOX/uXrECZC74ncVmC3kfymFpdVaNW
sy3PnKdbU27MNDtD7/u/bX/KN2tr1eAb/7Lsf4sS9YnMdmzqxR4NwrATqEcANPzx
kRG2mmdD/CilIWlZQqsaXGL85Jo8daGCx91VQMh9iwetqBIb/sTEI4OnAOz8StNd
dNtb7eLyp7CqZmJkGu0wRjJh3NrgbyoiIjuLHitex1UefqV93v5RVhHwdubjY+f3
/D9LIV+W/5H8ax5v9IQkCOjFLmWtSo7XK22Jeo2w3NOVPTKicaP4ST9+jV313kUK
d0uZfF2XsOxNGANEQDpVuRGIJlXhIsvg4/hMrCxM60ADHjuZADrXjmC+IFOPq8ZV
iyLxI+pyjrrUy5TZVSZp/hkC0KC7cGfBkAMRxRkccKuZsG7BuQ/6L2g8//oAY6U7
3a0oP1gE8C+SuOkzLeXIGhYh5aw5NMS8kRfPFcX+sac1jahuyJT0pishaa/B91Pf
fTe/oNeOCjkBzGXjZu1RVbqfBQeLK2d7TR40+FDtu2S+XH81+8i2/mG14ctSdEcc
nywRlXMhWewVx1tJdEYe
=r+y6
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
