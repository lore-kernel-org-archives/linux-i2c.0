From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
Date: Sun, 27 Aug 2017 15:31:52 +0200
Message-ID: <20170827133152.igoqe4ftzslza3um@ninjato>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
 <1503286614-17670-4-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ra7sroh3hvy2gz2t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503286614-17670-4-git-send-email-jun.gao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--ra7sroh3hvy2gz2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 11:36:54AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> Add i2c compatible for MT7622. Compare to MT8173 i2c controller,
> MT7622 limits message numbers to 255, and does not support 4GB
> DMA mode.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Applied to for-next, thanks!


--ra7sroh3hvy2gz2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmiycgACgkQFA3kzBSg
KbZWfxAAnRLneYkwnQs+FNeOn2/ZzavFKcni/KGA3V9coKIquLwtYTmSLGIrJWo6
MgJL7NLPO8CaEMUwgC54mtWlh5OHZmKxqFZmyR0xCziTLE4HHpCQTTrufm1EnJTL
dciL+b4Hx4JayWWIG7UTy9V3Ymhip8BSXy/f4q9BgV4D2AOjbhdugu9SSUmiTuTa
FJeP+RwV3rFN79f9PN5v2m5ZAMpRE7/TO+G7q9KEP9bhqyY5vHQJI6fpzhPVIN06
FJtjTbc6ithITYGExlUXo8vfi/YyebkJ3bKp7C1AR5GOuSASZMcBXnVCmypUsIgO
xvFrOJXsnUAxy3sWog/0CijL0mQcPKVEfjrmS3zHbjf95SyfCamf+fRQLaNGO6SK
me/4LU5Ky78P8B1bPUH9kke//c008qhvE6Xp8Fjx8uifd3s820dup+II3rNrUJ6R
KbU5hCo1x5zLqILZGSASi1SxyDms1FpKq5sm3tSsBuaOWj67u3JmP0dsOj/Bq/Gi
r66PIyBJ9pjmVJUsStQ7ewU5uKHwTyOyI+nO9NtYk8LTbtvhqUYxHN53kZwxVOil
5OtDh9T16VrZy+8oESlYouDH5FQJm135zMjTQvkPT+J7ICBz1ePfw0N2ojCErVqy
J6ZoOHj7zBukugJkeEvGgFcNGofDo01BwV/IlvKy4dQEnURveNc=
=h6SC
-----END PGP SIGNATURE-----

--ra7sroh3hvy2gz2t--
