From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: m65xx: drop superfluous quirk structure
Date: Tue, 7 Mar 2017 09:05:41 +0100
Message-ID: <20170307080541.GE1458@katana>
References: <20170227192505.6449-1-wsa@the-dreams.de>
 <1488854161.8977.3.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:42528 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754662AbdCGIOL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Mar 2017 03:14:11 -0500
Content-Disposition: inline
In-Reply-To: <1488854161.8977.3.camel@mhfsdcap03>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: liguo zhang <liguo.zhang@mediatek.com>
Cc: linux-i2c@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, JunGao <jun.gao@mediatek.com>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 10:36:01AM +0800, liguo zhang wrote:
> On Mon, 2017-02-27 at 20:25 +0100, Wolfram Sang wrote:
> > All length fields in Linux I2C are u16, so a HW length limitation of 16
> > bit lengths is not a limitation. Remove the quirk structure.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> We have tested this patch and it is OK.
> Tested-by:Jun Gao <jun.gao@mediatek.com>

Thank you for testing!


--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYvmnVAAoJEBQN5MwUoCm2m8EQAJH0icjmVMM0C55FWbh+QrTP
U57aqfy0sb4GcW7FCkXdkZZpzlTnQ9Hzx9MSQmWuGTLfGK68SV3FReed+c6ikWSB
qa+9E7IkC1nHs4xqeRJi39EVyPv7xwXROWi/trUfawLel6iM6ebvH9Hc+bZov861
Ets0HBc8ZAHfkF+hJJ5Io8ZPKJH5huLQJzAX0OLQRwmhDcuwuCSv/viE8YchUAMn
Yfu1kQvQf1lg8nPJlfMH3F/xXqR+6LuxMIDBglfHbaE87R6wB6TXqrZNJtuOZC07
Y9nwLOj+qbrh8VAG8H/47wP9+7b5dmFbYLdx73P21NKr9P0+8Uuk9ps0UCzlY0Ah
vPk0CUAuJVo7R8PuD5XMLgKC+TqDYlqmcleIyM2ueSi/PZNiuwcg0XJCzJPRsh65
QArBstLVHmS5pXRVkl9yisEgQu5lMwqU9qs3C9WTLe52mGCVJcYEWgSUNMx+yUu/
TexoUiWwMQjK0W+YiNVtPpYikdto68hYN7JGy0mcTrCtr/+MS8rZSYtT77zxf11/
85rX/o8nGApHVwP6WPoOawfYPB6JrQKWBu3DChwu5gUncuuDHuRSeLwv755sx6TH
TrRY/puvxTHY4a46OukR3MQamBmVN2Uktk3nFAfVaexnVke4Gz3WzWtH2yeoJx7c
Zp58TenQMbshSoMJIBhJ
=cuDj
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
