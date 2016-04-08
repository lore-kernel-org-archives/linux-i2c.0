From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: jz4780: Return error if clk_freq is set to 0
Date: Fri, 8 Apr 2016 11:55:08 +0200
Message-ID: <20160408095508.GA1389@katana>
References: <1460102372.5233.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55656 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbcDHJzQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Apr 2016 05:55:16 -0400
Content-Disposition: inline
In-Reply-To: <1460102372.5233.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 03:59:32PM +0800, Axel Lin wrote:
> Current code returns 0 in probe if clk_freq is set to 0.
> As a result, the probe success but the module does not work. Fix it.
>=20
> Fixes: 34cf2acdafaa ("i2c: jz4780: prevent potential division by zero")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

True, thanks for the pointer! However, I think we should also check
i2c->speed directly. I'll send a patch right now. Please let me know if
you agree on that one.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXB3/8AAoJEBQN5MwUoCm22HoP/iebGS1VkdhPnrFJxX23sHAy
xWSyDJnnPC7YXXmR8jic8U56uvdc1HEdlmtzjSqw8SHfOhpHaAuECYUlFvwS0PrV
ioRYQ7EDSBgLmKroFVpRgJzjeMzrj0cWx1jKx0zVYork+NSRAky5fv2XquUt4cnS
f+b24T6+o1sIc1YEelCYF9PJOnfxXps4Nn5EnxxdrJSwQmNaWx78Isnt6N274wXf
566BUXQEIG0aG8A+4E3tbdalU7k6Q8DZWKMBpjLQAaW1j7IpOEpU0YV3egFvACC4
eukN1cDyV7aq1bNO7kJQ+UCpO7sHqwx3oQ5+Cb21KQ3EV+WBR1dFfpZhpykZTtc8
LL8eoSYJNKQ82+ZndOWzvY2l04w2DPMTNYvpbwea2lJOvhYPjO8E55QCaRRe9T1f
aDoAeFRfemvTveaSY8gLaAJQyN/T+rRQK9FVJZqj9XGZL2O4n8QBa/7lv9f2ZqCz
y1E19ndUfmhCVKUcmu+fVa7uo4z6WcBvPzbC+maQ1I+UDPbo6nkDNJAkcgojKI+l
ndDEkQ9IA35Lgq1ONiKtavVd4C5ZzvZ2rVZum0Hp3Ld6XU0PirkvZyPOV/czVMIs
MsiFM1QVxd2xE9WM+io7W2mwBfh3ejtifC/fjsrZbJ9Dd4dppa5+YA3kg9exiX1I
FcIrOHcxO+r9fO5MX6Yl
=Z8eZ
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
