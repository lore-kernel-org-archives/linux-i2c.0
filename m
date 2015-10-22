From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: at91: fix write transfers by clearing
 pending interrupt first
Date: Thu, 22 Oct 2015 15:07:35 +0200
Message-ID: <20151022130735.GD1517@katana>
References: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58508 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489AbbJVNHj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 09:07:39 -0400
Content-Disposition: inline
In-Reply-To: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, peda@lysator.liu.se, cyrille.pitchen@atmel.com


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 03:44:03PM +0200, Ludovic Desroches wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>=20
> In some cases a NACK interrupt may be pending in the Status Register (SR)
> as a result of a previous transfer. However at91_do_twi_transfer() did not
> read the SR to clear pending interruptions before starting a new transfer.
> Hence a NACK interrupt rose as soon as it was enabled again at the I2C
> controller level, resulting in a wrong sequence of operations and strange
> patterns of behaviour on the I2C bus, such as a clock stretch followed by
> a restart of the transfer.
>=20
> This first issue occurred with both DMA and PIO write transfers.
>=20
> Also when a NACK error was detected during a PIO write transfer, the
> interrupt handler used to wrongly start a new transfer by writing into the
> Transmit Holding Register (THR). Then the I2C slave was likely to reply
> with a second NACK.
>=20
> This second issue is fixed in atmel_twi_interrupt() by handling the TXRDY
> status bit only if both the TXCOMP and NACK status bits are cleared.
>=20
> Tested with a at24 eeprom on sama5d36ek board running a linux-4.1-at91
> kernel image. Adapted to linux-next.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA =
controller")
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Tested-by: Peter Rosin <peda@lysator.liu.se>
> Cc: stable@vger.kernel.org #4.1

Applied to for-next, thanks!

I considered for-current, but really want this to sit a little in
for-next to make sure there are no regressions. It will go back via
stable.


--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKN+WAAoJEBQN5MwUoCm2EtsP/RWuIx+4pTMDP72HQn6j1W1N
FH2JLtnAQ//+W82IQiEZl1YodKO2UigR6hI3vNF4KJ71cK9q/F8VHT0R2iyIeCrU
1ZKFCj/nfNbsTrNq3tX0xDXCAykkx5+WmggpgQia5LHdxVZfCHvlz7ja5taa4uI4
QAuJlB5swKBwvKrfJOL16emxqypN/SEO/Aej2AarimWw6JA8yZoXAB0rDunAANvb
yZ9AuxBNy8wWxx8EQPbC863fRxa8qPN0ADjEXCy4geSjMIrTEPy7hqQJlRnWhqb3
PWe61U4bRy85ip4xH+kdWyTwF+BkRHlVIvMEFJIAfnoaktJQaboNLK2i6Lrzaifl
Fj3SWhED8vkAAs4VZVeTv7tmHOHUphE1+zygL+858IebuZyO0GD6IAOMB6OMnxOo
422t2z1zU+v0NBo+Av2lZ8OJe4umMSaJ2vJqZ32KBCOdi/R0oGZ+7NKDs/p/73e4
ezdh4Lp6rFkS/5e5Iw2nqxsWa/ve/scNDGMKKWq8XeESXK3a2//BCzTyXyxruczk
qiau0TOicK9VBwTUZZQ5DfAd+esQXYPphRjPN/TKjxXEAiToabD2+BvZuBoJI764
7SW++YZRhLArJholCgb2YI2urpZ0ZDHBEc9E+2KSAzqfCyF/LPXWM6vw3/yvksUQ
BqTKbyy+jzGQw2lVt5Qt
=xedy
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
