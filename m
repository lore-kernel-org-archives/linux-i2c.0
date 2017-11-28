From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: core: fix compile issue related to incorrect
 gpio header
Date: Tue, 28 Nov 2017 10:48:33 +0100
Message-ID: <20171128094833.vwxplzbzzrnu6uch@ninjato>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
 <1511838551-4035-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wsd3qknvwox7pnmb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50542 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdK1Jse (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 04:48:34 -0500
Content-Disposition: inline
In-Reply-To: <1511838551-4035-2-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au


--wsd3qknvwox7pnmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 11:09:10AM +0800, Phil Reid wrote:
> The correct header to include for the gpiod interface is
> <linux/gpio/consumer.h>.
>=20
> fixes commit 3991c5c80beaf7eb9 ("i2c: Switch to using gpiod interface
> for gpio bus recovery")

Thanks for the fixes tag, yet please use this format in the future:

Fixes: <sha> ("desc")

like

Fixes: a34a0b6da22540d19e57 ("i2c: designware: move i2c_dw_plat_prepare_clk=
 to common")

Fixed it myself for these two patches.


> Signed-off-by: Phil Reid <preid@electromag.com.au>

Applied to for-next, thanks for the fast reaction!


--wsd3qknvwox7pnmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlodMO0ACgkQFA3kzBSg
KbYdbQ/5ASFKS7sv2NmZrwUBo9QXorWBb2OBYTAI9xU8qGjjzmXPOqH/aqqioLOi
Z6sn9n0+A7ycBmw5m7aFxWjIoK1yoCCCxJqwW+3UC2YrgSiQgmPxina3XM/Y552C
YL92ZYaph9BYcWJahmYJdSZ8rM9wY3usjLzWUTMdcFJ4dMeFDaNAmITtO0qfsnrx
p3Cp4BgzwYmnFJ2tmyyZ9D9VOyWJuevLc63E2552J+GumDLGzESCSUaKpF8nrxM/
nqn0WIdwwtpa6qFKCsZs+hFpLwBfl4chJai5RWotsaP6efYv1lm1+/RfhwXDKqOx
/MWSZL3jOmN6IhwwqasEgnS5WLWVeDLPlFT5mm8vzs2DeIh6JBjWZnR2mybMz/mq
hhP05+rbs1PSZytKs8pd6qn8A7bHigekqdBr+NvwiHxFOH0qzqz0n8JlfFLPAu10
Azh5U9FLzQieqeUDSAmW9JKXH11a+p6LCAZiDmplkeilDXTa8TsoMSzmY4RX1PF+
OugaCkDdda8YnWFRjkyX+uuLpFgChI4GhRrFMYqXnQJwStXL2P43iorymtxkjrIW
K9bLfVrvMmAiU3Jt1EnnzIOrDXbiGt9VtDkM33dLOxcfLeKpQssH+UjJa4uLQXNF
CwHsLGi+gHuBgKw2BimnM8pYt49CbrRoNGpJijxpydfXQrmlThU=
=XMlY
-----END PGP SIGNATURE-----

--wsd3qknvwox7pnmb--
