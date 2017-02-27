From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH RFC 3/3] ARM64: bcm2837-rpi: Fix pwm and i2c pin control
Date: Mon, 27 Feb 2017 14:36:48 -0800
Message-ID: <87a897tg5b.fsf@eliezer.anholt.net>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com> <1487280047-29608-4-git-send-email-stefan.wahren@i2se.com> <87r32j8ial.fsf@eliezer.anholt.net> <1798682438.259359.1488229985933@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:43362 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbdB0WjN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Feb 2017 17:39:13 -0500
In-Reply-To: <1798682438.259359.1488229985933@email.1und1.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Peter Robinson <pbrobinson@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Will Deacon <will.deacon@arm.com>, Frank Rowand <frowand.list@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, devicetree@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Eric Anholt <eric@anholt.net> hat am 27. Februar 2017 um 21:56 geschrieb=
en:
>>=20
>>=20
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>=20
>> > According to the firmware DT blob [1] the RPi 3 uses different
>> > pins for i2c0 and pwm.
>> >
>> > [1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blo=
b.dts
>> >
>> > Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry P=
i 3.")
>> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>=20
>> Interesting.  The dt-blob does, I think, basically reflect the state
>> that the pins will be in when the firmware hands off to us.  Note that
>> the firmware also, at boot, sets ID_SDA/SCL to function 0 (i2c0), probes
>> for a HAT ROM and saves it, then restores those pins to whatever mux
>> they had before (presumably the dt-blob pin_config values).
>>=20
>> Linux doesn't have any HAT probing code itself, so leaving pins 0/1 as
>> GPIO input (most boards) or i2c0 (rev2) should be fine.  I think this
>> patch should effectively be a no-op, unless you've enabled the pwm node.
>>=20
>> My only suggestion for change is: These pin configurations are
>> board-specific, so could we just move them into the specific board
>> files, instead?=20
>
> Yes, that would be better. In case of pin configurations do you mean
> only those affected by this patch or all pin configurations?

I was just thinking about the ones you're changing in this patch.

>> Basically leave bcm2835-rpi.dtsi as the "generic
>> configuration of bcm283x for the rpi firmware" rather than "things
>> common to bcm2835/6 with rpi firmware but not bcm2837 with rpi
>> firmware".
>
> If this our intension, shouldn't we rename it to bcm283x-rpi.dtsi?

That sounds good to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAli0qgAACgkQtdYpNtH8
nuiM0w//b7PK7izl2lHMAiIfqGVOFyCJl9sSQ/G0UsxQChlpXwK/FCyuZNafks+R
7xUzuaDbnXmRbKSgwICZ2hK0whcY8wqAdwKI6PNQXIsX97CiNTC41lg8bE0Z7Klo
w7nYPg/VG9enwBX/TfbO1JmbhcDcKtt5DsWfIe9/zvuj6qIxBVX2ULKsF/Fbks6r
iZOS07ifPnE4WvEfF6vjgcmQ8qRd1KsuAZsoW8zS08RVsHPlCT4StrIG/1jf+ceQ
GFpjFHQGUD+yt4DnCYkm6FzH7aZ+O/tt6c49TGZr3or4smJimm1KSxU6QoZy3lHr
lHBNTfPHpWwpI7MHD+oFrp1+cQZbBikzcDguVA1M3sLq3kz6KjAs7pS5aG71b/ZF
iU4irjAawQ1+hZy2aVETjSC03natMwBdRJn618hwUdXqM1fZDgYakTCMsw0GPtwt
xX0U/4XbkOVarH0ItaB2IjmarJ5YZWhTB07Lic5YXqJtSvZiRAZXoLZ9Xu75DTld
XLXYTDMmCsrmzEYAXYeZSm2WjNIeBB9D+eB8Ou4MS7+JI3P5kDyvhIpy4s+NMsUc
6uiobWoJRwx4uAuIf9irNPNoxkainTEsAuq8C6nRKVSMLgilP/R/u9nKMCgl9gWI
lAoIzu/wNzWaYueWoKxVl21VJZmPOLzxWTrYX79NaVMeEe4/h4s=
=LGNi
-----END PGP SIGNATURE-----
--=-=-=--
