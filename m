From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 1/3] i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
Date: Mon, 19 Sep 2016 17:51:49 +0100
Message-ID: <87zin3omsa.fsf@eliezer.anholt.net>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Writing messages larger than the FIFO size results in a hang, rendering
> the machine unusable. This is because the RXD status flag is set on the
> first interrupt which results in bcm2835_drain_rxfifo() stealing bytes
> from the buffer. The controller continues to trigger interrupts waiting
> for the missing bytes, but bcm2835_fill_txfifo() has none to give.
> In this situation wait_for_completion_timeout() apparently is unable to
> stop the madness.
>
> The BCM2835 ARM Peripherals datasheet has this to say about the flags:
>   TXD: is set when the FIFO has space for at least one byte of data.
>   RXD: is set when the FIFO contains at least one byte of data.
>   TXW: is set during a write transfer and the FIFO is less than full.
>   RXR: is set during a read transfer and the FIFO is or more full.
>
> Implementing the logic from the downstream i2c-bcm2708 driver solved
> the hang problem.
>
> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Patches 1, 3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

For patch 2 I followed some of it, but couldn't quite say it's a review.
I trust your testing, and that the path has had a lot more testing in
the downstream tree, so it's:

Acked-by: Eric Anholt <eric@anholt.net>

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4BelAAoJELXWKTbR/J7okngP/1Bp3KjxrgtpXoDVmZ466ZB/
GCxueUc33yoFS0PLlEZQJD3KtMrnPmABuRdgv0DWohat57kRRQBswiQ9qbTEZw7/
dIeSuMCy4k/iVzXNzrnxzY6BwWgo3NsC52Z5x785/WHopbfe56P0dRO+P4w0SHVt
t095xgE2+mfOl/D+Q7WiaJ8bWVQ0vsOZPKI5iWkFwrTnhNYY+hLVCGH9fP4h6Wc5
CYIXZIAXsW3iaNfllUsAo96dwYORioSwxVDOOZqI6uqiPKHw9OT00fFX8/MPvxl/
T8aiNZ8Nph+66Qnza3frrI8ZmxIo7r92gR14K/w1LyZI/7m5M6KcDr/oEzIEwkT5
SjQ2YQCnPd2cKqJYRR+lhEnpbHOOxYzpA6mf0t8TFRpjtuYuaprmd1wfvcjpBwDY
5YA2SHy/jgvS4fLKJ+OGre3LExgsCmYUlVduxR7bDBQDGVe2pVEKhJP/o0I5K09q
BnAYJvl/oZx72Q0wQKuyefvGDD8NX9rpLDNuKSU3zC9DmdnXkKJ2r6mu88E3zDd2
J2Wob9YgWIVnGSY/eISwnTnX3uC3SLB3ShwpUC/inUetawoOKtMtPIfUej8iyvwv
qLkrIyIPBo98fqz8wB4Rg9QcGgNOVfBzy4ewfEBiyoLX6nsLkan+QDLtHri5Eky8
xztobOHAhFQc6cHfzNgx
=Fq9N
-----END PGP SIGNATURE-----
--=-=-=--
