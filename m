From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Better error handling
Date: Thu, 15 Aug 2013 12:03:31 +0200
Message-ID: <20130815100331.GD2987@katana>
References: <1372841962-26310-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372841962-26310-1-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 10:59:22AM +0200, Alexandre Belloni wrote:
> This patch fixes two error handling cases in mxs_i2c_xfer_msg():
>=20
>  - in PIO mode, mxs_i2c_pio_setup_xfer() may return an error but i2c->cmd=
_err
>  will not be set so mxs_i2c_xfer_msg() fails silently.
>=20
>  - in DMA mode, mxs_i2c_dma_setup_xfer() may return an error and have
>  i2c->cmd_err set to -ENXIO. In that case, we want to go through the
>  MXS_I2C_CTRL1_CLR_GOT_A_NAK before returning.

A short explanation why we want that would be perfect.

>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I'd like to postpone this until I applied Marek's PIO rework. Could you
respin after that?


--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKdyAAoJEBQN5MwUoCm2jJsP/2Br1B/TWYafPoG8xjTMEJkb
YsfBsueRVDja+6zFL/AnuTwv6JoY6prxLQly/Av+Adx/rkDaZj0RFmVrdjB//iOm
LuiRL8+Lfkg2CKTVyLnVdOvJ9LRSVDNscCSbE7AvEk9uBDfwHk8dR7i4GqUojE2Q
uTC+9+W2BMAjrGMpOivFlRRsHHmpxAkmBOi3Rs3Cm0wV2smu2jhSYSnSlvKnAQvK
X8Ll5X98jcPbTuYct4Qo7wXMJzeTkT7zEqKDVv3W5AE1seozM5wH9DPJN7peiSe0
Aivz0NqOvD2n3ILw7byV77cAAM+4Zfmu+GifKIghfgRVmPZz/ohpAJx9CPn87aao
iO1xsExDT72WBzXUKMVaia3/wbkBQiU8M11L72RYnXNT198PVxjuDfhMmaOjevEY
kUN6YakaT4gMkq7+SNAEOqEpaDuXKDFM4zKX8pSLyJShpo9eUt8YDttXjXJfI4sW
Z8h2gnLgeOzfZ+ha1zoSesL4taq2AKyYKCBO7ea0it83Apkin4W5UJTi62A2ebHS
q6sbBvpSnxlDDpcP6w5WsLwj59Y2gEySrFXYvnlHiSlcaCpY7Q02OwmWiJBrtS19
4jvoHDu+LRM9M5PB1cLJz4iFgh/znDejjAn4N/T+7bMKT1p3fXZ2A3SA48tD8f2N
Ud3gCcfRtoz1IWTphNFW
=vMYL
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
