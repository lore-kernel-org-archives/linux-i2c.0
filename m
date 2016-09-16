From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Fri, 16 Sep 2016 22:04:57 +0200
Message-ID: <20160916200456.GA2216@katana>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965306AbcIPUFI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 16:05:08 -0400
Content-Disposition: inline
In-Reply-To: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> after testing last patch, replacing request_irq() location is not a
> good idea,it might produce a little time windows ,in which the interrupts
> occurring inside  will be omitted.
>=20
> the new patch adds a check point on interrupt handler in case field
> 'pch_base_address' has not been initialed.

What about using two for-loops in probe like this pseudo code?

for (all_channels)
	do_initialization

request_irq()

for (all_channels)
	register_adapter


This seems to me the correct order and most readable solution.


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3FBoAAoJEBQN5MwUoCm2ynUP/3hMn+5KnB1lWQAdebaN1IYW
oafNgRPqwobbLjDixxx7r3IkUzb8EX3nO40z5AWmjQYrgXH4hCkg08GyZ4sB14cs
GqWG8G/LG6+eXSMRGBKgSbKBaR+aV2swe2KKGaAL0zvU9+mBG1Kqi1/kmjreVhyF
sgrCvsOD+QdwA6uSF5cwhYzk3bCuF5YXCPaEgPViUAqi9kAZmjajMIihbGV9vVDP
6Y5f+hBgtGQiA82pS76UFYmCz6dwWIU/277v5vdQVBg2Tk74tjXolR95UfSQ25qs
k9CY4aNUdvmzNgnBoevcNgpI27GI1zUYo44S/7Gr54l8e92TVt7aLPyXId3Ck/m1
tbkEvZu7OvCbCYupiAoyub+AYMuE45mfTQLR5ltMlQXIh93ZIjopcZ7F1cBGQsFE
2hGdQ/g9dGFjpCtT4Q2tpnVSfwJgFj7k1mKwfSBW3M8PnjscNKfgTbCMcrrW57hh
0wsDRSDXznhOMoKmdt9FZja1OfYTC9xYuSODWXBsgCCfQbP/kHFM5KGkLUnAl0t9
fBzg9AAk7yFmWNlpYctQjylSvKwmlAe+7Xoz+/ViCPACarnzpwmMqzetb5ERhEqo
Mxk9gThkNhDdyV3vg0yBrOS2h4FcO6eHaP0cXip/ybA0mlGdXzSygO5Ji0pRMj3D
N9Q0Sv667eTlTdnXq3NW
=K/FN
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
