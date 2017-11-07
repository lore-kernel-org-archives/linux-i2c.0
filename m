From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Tue, 7 Nov 2017 21:36:21 +0100
Message-ID: <20171107203621.53uxggqcd4rzbfjw@ninjato>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xzyxnfts6mqmgwmy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933348AbdKGUgX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Nov 2017 15:36:23 -0500
Content-Disposition: inline
In-Reply-To: <20171107201857.5752-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>


--xzyxnfts6mqmgwmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Wolfram: this is in the i2c GPIO refactoring in your tree,
> please apply it directly as a fix for v4.15 if there are
> no protests.

OK, noted that this is for v4.15. Since it touches arch/arm, some ack
=66rom an arm-maintainer would be good to have...


--xzyxnfts6mqmgwmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloCGUUACgkQFA3kzBSg
KbZR4g//W+koQvIWbeKfYj04b1SPpctbVlVq4VKEqB/davzxR85S7QZbgJKCg8g7
AAuCYX1xhQs7ycf13QamT3H6UblHPTjXIPwpdbfvy1pIG+It20FAXiwbz3OVra12
heJoyJ4MxZlLL7WVOOLr7v3vLHaM8RN9tohGg9Is7JPA4KW8H+TUeiUzlgZAPLph
Cy8YBrVPQ2Tag4YbgHt4MJ4bsLlGKrnzZyr4EETdnhOfFlmiGM6PbdVq/g0+A4ML
7r6hOCJWoH5PJHXhfi7+QQwAJSvTVbozonu6XuZIQ0gJzV27l/6bmy0GcQMjLGPz
jW4hPqegq7ef5moKK5M+a0EWi8h3EhEZ7yUEymgTQjFkIlrEig3LaOItUU8EkVsz
hgNU4ZFbxDoEM3b575yst27tgWyQ3al3m1Nm3zVfsX+Qu+ZSB54brPhxwcOBezcJ
Cksp0jFj/CBVQBzGFZNbKntPqQ7Z83CYU1Ixd7PdTrV7fvx3co4V60p0mrtmtR4u
qEWSJZRNkUw9SSesAYWp+f233UMqQL3XCYwo240qbkD2s9n+zZ3rcdkpQR3VgS+F
+zY8+q9mPbS1na7bQSuvoZUQOLB8QmuvDqcKut0YZSy385OOlvgSOg1usybpnNVV
ZEG4X+rGvJgfUmbQN5WsX1L50QlvzjGxTy0mh22S8oWjHxlLLOk=
=RMfg
-----END PGP SIGNATURE-----

--xzyxnfts6mqmgwmy--
