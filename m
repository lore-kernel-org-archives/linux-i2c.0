From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: mediatek: Use DMA safe buffers for i2c
 transactions
Date: Thu, 6 Sep 2018 20:33:47 +0200
Message-ID: <20180906183347.GE8607@kunai>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536239729-10008-3-git-send-email-jun.gao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 09:15:29PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> DMA mode will always be used in i2c transactions, try to allocate
> a DMA safe buffer if the buf of struct i2c_msg used is not DMA safe.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!


--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRcwsACgkQFA3kzBSg
KbZa0A//X8r1smIUOljW7c4uxJqYfYp+QlX18IAFMkaIJlEwhJeXlk7iLyYwk8j+
WYEqojJ/wE0M56aQhjGwSENT9wXcE+jcl92k+ieashTSs/kWLGZnYh1DFXXdblXj
9m5CwbyRpYcaWD/+3yf6VxnNPci0CwJ1mbocDjF2OFfgMFQtoiQ2NQjHQS5j2/iQ
bMlaSFx8iFF+mSrfT9pEBfD9OJ+uQrsfvsBAxN2cOSnKtgClH5hlDVOSv/AtkVXw
NZMAhcPshGfLYHQ3g+ZGRSkX50X9APZPz4LNTygHFwS+dDCIQNVPPB7CeuN4ALwI
WUJSvt4xAkGnO2d6lMAH9iyYi66KSQ38eo27Xk9hLhXXd9xh9N1Sj5sBBRJzKZ33
smSRorXjLfm/hDQGLDgW2qhOb/MV1dqCLXUQVYpfmCQxIPFXiZ7zA1qzfK8UhifP
7qEyHJl1NP+r70+qATFieM2Bb1j7llUARHKjuBDj69cbW8tRTpV96SyAeoqOHRk2
jdDf2HonzQhJjAS88O9UqWz+JHmZarOzX9bDu7NqC/Y2WDD92voCnl60BSa6dTjP
5wHjp1K9iZk9R+aaRKevpIQmOnfqtq7St37UZN0mvhkguiSs2F7xiTWsmlNPiJ0X
D/DeAPzRJOcRtOQLmzdLuObKpIlHEUnRo3WwAeY3Wy3tmcUdOg8=
=LmrF
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
