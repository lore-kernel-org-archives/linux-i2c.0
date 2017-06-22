From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
Date: Thu, 22 Jun 2017 15:22:18 +0200
Message-ID: <20170622132218.GA3820@katana>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250>
 <20170620074126.GA1541@katana>
 <20170622074831.GA23753@dragon>
 <20170622080730.o352kxrs5pz7wxnf@ninjato>
 <20170622122558.GB23753@dragon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54458 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753316AbdFVNWf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 09:22:35 -0400
Content-Disposition: inline
In-Reply-To: <20170622122558.GB23753@dragon>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xin Zhou <zhou.xin8@sanechips.com.cn>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> With the proper error handling, i2cdetect now works very fast and only
> gets audio codec on 0x22, which is correct.

Cool! Now make sure that the error codes are matching
Documentation/i2c/fault-codes and I think we are ready to go.

> Thanks a lot for identifying the bug.

You are welcome!


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLxIUACgkQFA3kzBSg
KbY+2Q//Yu07EpuPbanI8byO7ao9AGcDS2HYmvPBqa8pGdBNKgUCd4vXxLFEx8bd
PS4ksCa/Dl2ghUwMnasmLiiMbzUgc8WiU61OMbP7DkWtyzkb98B4PLW4uIG0m86Y
sE8pvP1J8UxwGDJzNKC9MyKa5Seu3zJ+lpad6DTbwEyF0qewNkSk0ixl+V6oeZWy
B4HznqZ24AXfy542Bk3SkXqvT/Zi4teg5EKu6c4EzguMy6ZCx50trJIBf1yfhRFk
Lc2uAJ+OlhnG7F4Iphf+t19LBz5DXaTwjQMdaupDM2v0hUXzGKRr8AvTuS1blvXU
bBtNNy5lJhUzORO6ffhL3Bq5q+jSSvvz+xyNFW2eH0jK69oTDhko2O1i6hkl1OtU
C41nRbhJeHBDg4xnlNPZ5w63bfnZX0NYCPfKAeiOysJzoZgf7JX361iZKB5GbU9N
uji7o30aRzjCrCN3Q/E7SItSRyzSigoooaEDpGm26DgCkwJzah01StwX287IUkK8
2FgUmBNaqJ1iMF53M+wkTyR9Rj2dRbbc+ggcnuBUlyp9TPbK2JTnSuk3tJZJWZXy
pcYq3OVYS3WTYcGllGerrHWqK9knAffaHYAelrbJdtolMRZWHOuD48JS3uI07igR
Ofyfrh4JYUTxcXZJtQ9LEO/GezUTaW2FxIXROE6/WmCY1Hd5utI=
=VnrB
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
