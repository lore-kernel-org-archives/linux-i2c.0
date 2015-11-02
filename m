From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Double commits in i2c/for-next branch?
Date: Mon, 2 Nov 2015 06:50:52 +0100
Message-ID: <20151102055051.GA1065@tetsubishi>
References: <CAK7LNATkMPJOBABg9TH69Z2gEfudvk_jQHkE-j5QZLevdzBW9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52354 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbbKBFvB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 00:51:01 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNATkMPJOBABg9TH69Z2gEfudvk_jQHkE-j5QZLevdzBW9A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [1] was applied to i2c/for-4.4 and then merged
> into i2c/for-next.   It is supposed to be pulled
> into the mainline in this merge window.

Yes.

> [2] was directly applied to i2c/for-next and
> won't be pulled into the mainline.  It will only
> remain in linux-next.

Unfortunately, I had to rebase for-4.4 this time :( I try to avoid it,
but sometimes this happens. When I merge that rebased version into
for-next, double commits happen. Linus will get the pull request for
for-4.4 only.

Hope that helps,

   Wolfram

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNvm7AAoJEBQN5MwUoCm2CtgQAIgfr6mUZKKDKmF3n8038sDZ
bH1opavhdCqBsjF1ugbLkYeAPYV2bhqQ2rsCsISGHJWcMW65CyN2GjxXWXRUxLt+
zxSRA2t6EVi2CLGs74xqG4kbL+rwGcDHOLttPv1KeC5UBuHp/IybYnV2SxR0HMbC
G27MClQ95h3ANkupCEcH606EtyFoUg97gGhSrJbBMGD1V8rklVdb+umW/lCWuNXo
lcY3i39pjwZpZwfr7xIqvgSFZT+f+oFugWT+bBRX+v5O+Vxqetaygokoos7pBpQV
OiBGrEtHz9LrlPyFcpt5Oyse6GgSCXCHHHgZPfZeo10cGUBi+XSOh3Ak/Vb5rz7a
i9RmEgsCp0q1rN0mIa/doq7D4EMnoUx0zSxOYHwuQs1qy8bm+00tkSw6qJABE53o
oNPRSyrR/O2atiJisUJv3ia6+8fH3jtOJyL2fCVxkav5vxpoDjxf1TlLfhU9vw0w
mq+qywbEaLFArNMnGL00rE2LPvsVMFApzIst3iXu8r2IoEi+cXsqmxefyt7VWAD7
IfQX9RUQ9Ly7pdcD0VAm+GCfW5S1LZKgXlmXzOFi+UACP6UkYJEBgvYtiWImLU4S
jFLLbRfms1GkYdWEzD5s7Bap9rRilW3wY10grE74yhjROsYOycSPqqVmwFQqIQaJ
A3Z+j8Fu79D5BGAggunA
=eLnu
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
