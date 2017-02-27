From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH RFC 3/3] ARM64: bcm2837-rpi: Fix pwm and i2c pin control
Date: Mon, 27 Feb 2017 12:56:02 -0800
Message-ID: <87r32j8ial.fsf@eliezer.anholt.net>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com> <1487280047-29608-4-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:42718 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdB0U6F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Feb 2017 15:58:05 -0500
In-Reply-To: <1487280047-29608-4-git-send-email-stefan.wahren@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> According to the firmware DT blob [1] the RPi 3 uses different
> pins for i2c0 and pwm.
>
> [1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
>
> Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Interesting.  The dt-blob does, I think, basically reflect the state
that the pins will be in when the firmware hands off to us.  Note that
the firmware also, at boot, sets ID_SDA/SCL to function 0 (i2c0), probes
for a HAT ROM and saves it, then restores those pins to whatever mux
they had before (presumably the dt-blob pin_config values).

Linux doesn't have any HAT probing code itself, so leaving pins 0/1 as
GPIO input (most boards) or i2c0 (rev2) should be fine.  I think this
patch should effectively be a no-op, unless you've enabled the pwm node.

My only suggestion for change is: These pin configurations are
board-specific, so could we just move them into the specific board
files, instead?  Basically leave bcm2835-rpi.dtsi as the "generic
configuration of bcm283x for the rpi firmware" rather than "things
common to bcm2835/6 with rpi firmware but not bcm2837 with rpi
firmware".

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAli0kmQACgkQtdYpNtH8
nuiwwhAAujVC0ifl9wWBDLx7DaGAgRiUkhWTBgYXiC9YORxXskrFNGmx2qaYs1CM
Bb5rCEjHGN/iz1yYWdW8Vysvb6DkWaF5nVJaTsv/S585sMBuZBPutv/Vwj5c9gjs
BTbKSt+BktWePnJwmY5jmI/lhGZNICtJvry3m9428ZvvJegG8PD6biqDGGPjre0b
OA+PbM5FGesajoQaFxqdFpLMN2uWx25w6zG1/nVtYrQjfbF9zA073JP4G4wSIHTf
RVJC1xVHtLZ7TZFSNyH/W1TJI91ba114qbnDZfJ84GAWPKiM18DxEmONlLagBpSj
p3ls9xY3tyjdBt7r78alDfPX7n14Aa0FGqzYOcL5wTJMz/PSTkEJ5VG4N+z3rxFx
3obbPuUm4pmy7FBmlr/BusPsbu6Bi3TkYx8q/BCFXm1gvj6Zj2LFqGPbw8k65Pmd
04EGbJnHBJ5lAQoLWwzLMEe7p9I8SXORqXQqKC2+GaiKSyXEd5LtleijdYop+tNe
ect92Y/g3mfzCOrL4ZrdkdP6MvNpS+NR6iE9yUmSPwijiQvGigvQzE8XCR5+49ZB
Nomjiy4F0fDwlKnCohpS1ySLWYXVPeyYWiCS1tZPiDWkoPOgEvEgm/RqzkVXsYO3
LPAXvt3hHk9+Td3H/nU4wX6LAYB2ewLs1kqfMCK88Itv5AILzfI=
=X3Fe
-----END PGP SIGNATURE-----
--=-=-=--
