From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c:imx: use IRQF_SHARED mode to request IRQ
Date: Fri, 13 Oct 2017 20:38:44 +0200
Message-ID: <20171013183844.es57aui4ghipjobx@ninjato>
References: <1507708640-11622-1-git-send-email-wei.jinhua1@zte.com.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2qp7y2t4dwqb2jh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41506 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbdJMSis (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 14:38:48 -0400
Content-Disposition: inline
In-Reply-To: <1507708640-11622-1-git-send-email-wei.jinhua1@zte.com.cn>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Jinhua <wei.jinhua1@zte.com.cn>
Cc: linux-i2c@vger.kernel.org, jochen@scram.de, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn


--f2qp7y2t4dwqb2jh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 03:57:20PM +0800, Wei Jinhua wrote:
> Some SoC share one irq number between I2C controllers.=20
> For example, on the LS2088 board, I2C 1 and I2C 2 share=20
> one irq number. In this case, only one I2C controller=20
> can register successfully, and others will fail.
>=20
> Signed-off-by: Wei Jinhua <wei.jinhua1@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

Applied to for-current, thanks!


--f2qp7y2t4dwqb2jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhCDAACgkQFA3kzBSg
KbYvqRAAjfgojgpfiP96p/EMSMQ+IBwXYFjoNVCexRvVva2qzGFHFjP63Q5hTWh9
lUW4IMUhgVh/VubKLSic7dZXfmyaee9KPrqFV4BMBUYM0e2HAMT+5HRsmio/BnJ1
ifeg7TT+EJu5NFPF8GTiePJltd0mhRQWkZ1KTAbh9wxBFPzp/MqsjhWlUJcv0pUC
ZyC7M2ipD846PZezgLE7d+njONkIf+cPn0asKj2hKqEwJygeVAwR0z0sseRqDIcC
3ln326NH5z++1+zFPWNpwAVweSmom43tCo+d7MWkIAnxi2wxQkYeofCoWs9HC4/p
1y4ataey+wyNMsz8QcA2DMo7mmnPfHJciwdt45qWLOK+sUDnHHEQIirVRRQ9QbSo
lH0eIFpjRbAI4kNSFC7NLY5/fPq0dEQV0o4LBYwu8P4/6j5rCswZopYg4KN4Iu6y
iCcQVTvj0vsVtijOjrhE5iKhhqloiYHXsPmdb5HQsdShXnQL887EBJ+uHtSxc45l
EasCQfElE2y8ZMltQ3qUwY0nXd6UHwO9Z7huLqD8jR0TJawrWnzJycj9fhbmhJkQ
TMzvUfduQXP6eRTYHSp2DrFiSxZL2R633vRo1G6SFI7Bmxw7Lie16p7TXIwCrGrn
u4dWyHOhdFObFmlBykyti2SCV3kdZ12kcTrGQMG12PdZFavgbqA=
=2h5H
-----END PGP SIGNATURE-----

--f2qp7y2t4dwqb2jh--
