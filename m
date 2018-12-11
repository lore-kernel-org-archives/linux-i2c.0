From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 11 Dec 2018 21:29:31 +0100
Message-ID: <20181211202931.xav4gzi7rzh2scgx@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qookkrqmaew3bmbg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qii.wang@mediatek.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com
List-Id: linux-i2c@vger.kernel.org


--qookkrqmaew3bmbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - ch-offset: base reg offset for multi-user.

What is "multi-user"? Why can't you add this offset to the reg-property
directly?

> +  - mediatek,share-i3c: i3c controller can share i2c function.

Please explain in more detail? Is this an I3C controller?


--qookkrqmaew3bmbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQHisACgkQFA3kzBSg
Kba9lA//XQcp5LIyZqRaesg1uwwq1/DUnhfyqYK9Hyq5mqOGd+wXFZbvCUWicwwk
/N7FXIICvbEgzyhzItu4d2m5blloyJiA4rVxPAYo8MihORADU0Eu9qJLwI6XUGUH
kLe8/GrqWqg8DkGw4xNx7q+QpO52y/Fx7Lit6K2FmCAuMUTU8hkI05Mmm+eFaYGd
/Wxq2KZTaeDQsT0qLpRXRDi6hVMWamhgfNHO5WPcy32rHAMJ17e6iFOQaOv5FaaZ
dQmTrp5Wn1mRaKrLKuTACkz5XUqIPNxV/w5ZHWRFyTbEr5zKXdcdcYIPYjNd/bzg
vkEJR5Ith3YlmjU7YfVPyUBm0y7VGjeDXr+KL4LoVcUD/kbZUT+/GGTmAL5PZvP1
qatQcUvPiR62LTEi2nZaMjNFwg+9k9BC5WjARRzSi3Ev/2gHA7gwcCgnJEBmwp89
TaysiINGGxzRzfYnn+wL2ja3lYyJr7iYie9JAqzLHM8Q120KgavZEHyHJCWdOvX8
sMVcLh6ld03+J8iFtiNJemPiRl4jFMkg0rQs11YeAZJu/H0rVdU2Bvbk1yJ2QaaK
a22CduYq10DwPPwCrPh4GMGK3Ohi+md5XcUgDTnnc/JVD+hOHSOBtYOHkNp/nYBN
fnM1q9BoJlE+irfzbAqx64BX+a6rrg5KeAWy+f21+Z7xwCW6gII=
=ZORW
-----END PGP SIGNATURE-----

--qookkrqmaew3bmbg--
