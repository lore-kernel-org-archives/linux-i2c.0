From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.13
Date: Thu, 13 Jul 2017 12:03:07 +0200
Message-ID: <20170713100307.7lmn6biehdp3a426@ninjato>
References: <20170712154901.yrrhtwfpnokkmswe@ninjato>
 <CA+55aFzHpnRw6Vw3GNGydzQbxK5SUFKkDH-MLUWPm5r1rAHeDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5iedct3lyk7hkln"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48181 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdGMKDK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Jul 2017 06:03:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzHpnRw6Vw3GNGydzQbxK5SUFKkDH-MLUWPm5r1rAHeDQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--a5iedct3lyk7hkln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

> So I personally tend to much prefer
>=20
>    drivers/i2c/core/acpi.c
>    drivers/i2c/core/base.c
>    drivers/i2c/core/of.c
>    drivers/i2c/core/slave.c
>    drivers/i2c/core/smbus.c
>    drivers/i2c/core/core.h
>=20
> as the model. Then things *really* sort together, auto-complete works
> better, and tools like "git diff --dirstat" etc that group changes by
> directories also automatically just do the right thing.
>=20
> And notice how the filenames are smaller and prettier too? It's just a
> win/win situation.

I am easily convinced by these benefits, thanks for pointing them out.
There was one request from distributions, though, when we once tried to
refactor only ACPI out back then (which we had to revert because of this
request): keep the module name constant. Given that, I am going to take
some middle path and rename like this:

    drivers/i2c/acpi.c
    drivers/i2c/base.c
    drivers/i2c/of.c
    drivers/i2c/slave.c
    drivers/i2c/smbus.c
    drivers/i2c/core.h

and keep the resulting object name 'i2c-core.o'. That implies that the
root directory of 'i2c' will be core only. I think this is fair.

Will implement it hopefully today and send you a pull request ASAP.

Thanks,

   Wolfram


--a5iedct3lyk7hkln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllnRVsACgkQFA3kzBSg
KbZZMRAAhTBVanlW9rgOYsHNPi8qoTDynBlEHs3SPwRrUAKLmbQt+JqOBiQrgZOg
Umvr+ptYvEoW9jNG5y/GWPj41jmtYkToAnarLYL+FBb47gbYNQthYoUgD0LPQLj/
eD3+7PFTGksgUq4q8WixtBqrs0v8mLtsvyruSYlz/fgO2xOoIvvribmHXEnsq3YW
EzVMgzyRCOd9mO8u7kDeO80XtI1K3emAFaFPYe/Ul9NhWnLAlbXKyrFaf1XzEird
LMBQPTaN/an0v7oDsNorSfR97IjRvMcaumBwvYGLJz7gRxpHYjC8QBUMPprvk61h
AYXcQvMjHQOkNuQrS3k0xM0t8UXW6sDBTib1mvUunfud1bfnWNlwIi58G63uZ7PP
Tj30CvB4Clva9PBGcS8bkpE+P+XPNJBFLauHFoii/06fG5eldcZ6oMALkmDfjsMn
stiIc7DfTUB6GJRFFI3E8uxOE/vwzUhbyUTCOmtNLEnkZpOLdtyRNHZYnLGwWucO
x+370gIQpUk5qmEgSYF4fBsiihR4J4CUU3O7Fr2Vj+5LofXksAlG1j8U9jfuhDLT
cmajhzUr0aIejR7q1UQ9oRNtPqQ17ZWn+9KV0NFYtb7aHvPKZubmHmhq6lKqePMW
ZLOL7B8zHuJG0CuculuyUIScEtvHFSHp8tvSUhiFlag6xbCsA6c=
=QvxK
-----END PGP SIGNATURE-----

--a5iedct3lyk7hkln--
