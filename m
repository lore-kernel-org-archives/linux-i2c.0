From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 09:43:07 +0200
Message-ID: <20171018074306.gapzynnrzpf7bvfj@ninjato>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
 <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtk3e4osinvozqam"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56188 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935631AbdJRHnI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Oct 2017 03:43:08 -0400
Content-Disposition: inline
In-Reply-To: <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org


--wtk3e4osinvozqam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> <halfknowledge> Isn't the at91 i2c hardware broken or unreliable such
> that it's usually recommended to stick to i2c-gpio? If so maybe the same

I thought later versions have been fixed? (half knowledge, too)

> applies to client mode and someone should better extend i2c-gpio to
> handle the slave API?

I wouldn't like that much. It means polling the GPIOs to scan the I2C
bus for the communication of the master. That is timing-critical and
does not like latency. Might even depend on the RT patchset ;)


--wtk3e4osinvozqam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnnBgoACgkQFA3kzBSg
KbZ4EBAAsnjRvXvtceRw19Q6/l1ejObPpwVPum5VLVDAe6cwWFUCfJ6DBvtnyeg0
KI2pWQao555ue9edHXXyIS/Q/vsP/L+hgaPAAr9f445jANAQPIFTqN60WXIOVOsO
tA3bNQOEOhZSdKKEj4PWvxlZXmxfE9l/t/QXxN2b8oBTTX+8ku9MMm2t9KqKcRMj
0Aw2m4QVAaKyonuHhDcuCNlPWkVGui8ZSkqJLDwLSVpn8FHDh/maA1KL5G8hvHP0
kusVu2QTOgIXBBJwxPw0TrMFwK/n3J7yExJ9TFfH8riYPfFPxMJ+SY9buhcUN5X4
EeUfB4spvxYKVXOxGKM9iSCSzBg5jRYdQbZFuswCmsQvvwS0U6aeBOpoCPDzOtBJ
+5fA4Knr/eLUMzueo2kO+VduHZjPYeA6JsYzQjMs4nHwvUUQ80GbyHL38yJdavXc
wO/fP1IKoaEpzVPjirLXSbGsgf/26WUzhvb/2nVNoVzzGfoc6x8OMBhX97cayPZ0
e/b7MTHOrHecDUPJNA6u6VPWbtiZLyM7BDti3d3CRMQXEJHbTy4C5OH8Gn0F2cOU
Wpkzz+zO3cs7HckPBnWv/EBLmadZBusljLd0MJ6EKQueHlo/sxm9WBk5uObEUBfE
G42t+poI7cKWv7ujmVWZ0VsUJfPVSnSzuhR5krtJeh1/VjtbeHE=
=Kn+c
-----END PGP SIGNATURE-----

--wtk3e4osinvozqam--
