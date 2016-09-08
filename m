From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: run properly with multiple
 instances
Date: Thu, 8 Sep 2016 16:50:27 +0200
Message-ID: <20160908145027.GB1485@katana>
References: <20160823152803.2051-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823152803.2051-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
List-Id: linux-i2c@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2016 at 05:28:03PM +0200, Wolfram Sang wrote:
> We can't use a static property for all the changesets, so we now create
> dynamic ones for each changeset.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: 50a5ba87690814 ("i2c: mux: demux-pinctrl: add driver")

Applied to for-current (and thus will be in 4.8), thanks!

> Simon: I think you can retest your demuxer-dts-series now.

Simon: you think we can get that into 4.9? Would be awesome.


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0XqzAAoJEBQN5MwUoCm2QZ4QAIWpi5Jc6J0IkiTiDQVRJa/1
lJTloqxvNXSewQgJozhOYCr5tQ0g65tDZhNVQRCCZKvfSc2BCd8iB90VizkdOMMk
cHBomYpVAwsQ4C+AcxmbYoscU4Lk5HJ3eoLzst67eX5CBb8ivjfrCoT+uFIDsGUG
BvB3G2MVekAA+paYg9hydoRifAOOS8AFrqHMLTEQaCVkIzvpgX3nT8xCzay2ewa3
UVB0imVdoxPh2OLWshQNfkzqY0vcU06CBixtKnzObJ3Aui7ZWSwAm0ctimJ2WwYq
BM2RkmLMiYMPV7YHKnoRtNZHL28bHcqs/GSZyeMFyPDrnamdXVOIGNESMG3rgbTs
2xA0LuEv0mvWkuEnxGQ2HxI5TRfGm3s6wyNp5zuoF1qXkchofjGesI90iCQ7bNTH
7V9N/mBWZfY06+XU3Ci8CItn3Mxp0VsRv/GT9JqL77UHrLILDLnzPoKC7QJ51jJa
ehm9eSAVbam/yguWqTrvyHt1PGgKgSireeytYXznZsR4jL1A0ebFGtDWGtAM+ugk
VVj1YsceQ/iKHU7P5UvQWYzwbGUI3Rix13FuJmsqZJCMK9I9qlQU9y2EkFQzPqZu
NtXZJMPYqdPvtZf2eOLyNhhSfZv/zZgaCY/phiPv27gEGapERVCN9hsa/B3oTv0l
6lRFs7YXxhSSc7BL85fM
=oYFS
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
