From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Mon, 19 Sep 2016 08:44:07 +0200
Message-ID: <20160919064407.GA1407@katana>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
 <20160826173019.1f939ce5@endymion>
 <20160917214912.GA4395@katana>
 <57DF5AC6.4050504@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35602 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758313AbcISGoR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Sep 2016 02:44:17 -0400
Content-Disposition: inline
In-Reply-To: <57DF5AC6.4050504@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi <yadi.hu@windriver.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> For my case, i2c-kempld register dynamically  itself by default,
> consequently it would occupied i2c bus 0 and cause to fails for adding new
> i2c bus with i2c_add_number_adpater(0).

This is exactly the PASEMI case as well. A video card got probed before
the pasemi driver and took all bus numbers it wants.

> i2c-kempld.c
...
> how do you like it?

Not much. If we change kempld, then another driver might come along next
time and we have the same issue again. I want a generic solution.


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX34k2AAoJEBQN5MwUoCm2W1sP/2+0M3vSZE2VGQ72RQd/pGGw
rvz5jSUtN1O2v/40TW7s3zh3XSJrXYKt+GNfLYOPJHzvrnNoCIy+5DuJTy7EKJzi
81p44ulvSqrRm6QMAUeePHbn6OCi8KkRGidXRQVoX0TJdRbIvyv6ww5FIMcvdvDg
Si+IX2zHtwbTHejmkwfBtxOimkdVimB7BrnXH2Tn6iNoqrbTa+JEY17ydQ869lx7
fxEWlBpnOmgZ9O8k1DEvB5NoV3uys1/7MoihCsbda2BTjpOahiN5Znbf0ZKsJbHS
B1OCqW83zqkBWxne7qMc21RyGLHaW996e/EQN+0GWMLuQb3BQQf9Kkf/gBt/qo1i
IHqNL+LmCBC0sQQhbLBXSlThOp9OE/2WN5CnKeeVRavUpOnUBVsCW32G+e5rTPP4
bLydxaM1zT80K8sbyQLlgdIt/h4DFj/1VqkZGuAWyLxOTwTNWFFq2yie5tLvnAiK
20QTslxKldl41Wi97ImrjIl0ZM5UZG7r/n1CWdJEXKvSfxPt+O8N1xoka/MJP17N
Fob/4ymRUIi/PE8ztFFIEPbSrgBlrNYnv5Jti62F4lcwGHhRM4COsgpt3erRsPYs
nFoV31aDbL4wp3/Y8pGcUrw/YuzCckPDVims3btoxakXZq9zRrdfDN+SjKyXlc3A
MdlhuCVYMGUSOO6OqPDZ
=qfCH
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
