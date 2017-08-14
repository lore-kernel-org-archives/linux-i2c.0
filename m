From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/2] i2c: mux: move include files out of
 include/linux/i2c
Date: Mon, 14 Aug 2017 10:08:18 +0200
Message-ID: <20170814080818.tfw46axtmw2mxhwc@ninjato>
References: <20170813135856.3454-1-wsa@the-dreams.de>
 <4ff46816-6585-2197-5804-c0065af6d9f5@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ua22z7gh6aszezss"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48632 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbdHNIIV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 04:08:21 -0400
Content-Disposition: inline
In-Reply-To: <4ff46816-6585-2197-5804-c0065af6d9f5@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org


--ua22z7gh6aszezss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Right, no problem, I'm happy to take them. However, I know I probably acked
> them and all, but now that I look at them I see that the #includes are no
> longer sorted. Care to fix that?

Sure, will do.


--ua22z7gh6aszezss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRWm4ACgkQFA3kzBSg
Kba4gg/+KKj2dYrW2frIkzjwhLPIG4Oed1bFPuyeAts8drTrjdVxvsLEETG7+C6/
HyyM2Ap4/7T+e2pQf4N2PkGI0e2BDGdO+TxSoCM/Szp6SQZW9N3TrEjb4eqc/5j/
lhX6gaZsQhBL85iNLJKHg3aNjbvDQRA3J2C/lK1NbAieSfQIHpGT0g9FcWDOVARK
c9mfpuXAsH50/ph4V2NqQ/sIHAD3XNLRQr0FrlIxxq3H6I+ywxhm+SvknytyBhoB
KpSotXnAzAj5hw5gFqNpGbu2YigCOXM+U2VSmK4s8AEtY+8i2fx8AONWlZ0DV3qB
I8gDa0kLTT0k0Nw08Hb0wx7RVQQHoqrTX9NyAaFITZTo3wYp1u7CORMJ0znZvll0
PZkqsHbblEtNGYCGz9xpgM/qiiQxTij1WBxFxKAAaUsvZguJXO7wP218QqkAgzME
SOoLYb6Wir00I+Z/zq53jOZjSU+sYonHFUdOcVZpShUyqhUgxLOVqFv29STYRXKp
fSh/ipAIINe//4KSPpH0oHT5k6AdtRXGCPEx+bezU5XSfCyf1y7J0Rdd/fbMkiYN
RWpQS7UAcF/HUnJF2/9aVswtwMbSGPnCLkaY4PHmKqBVmXWCd+b2STDpLi4z8VHd
95u0w4o/5yckzmUdBARln60E43aHrHucSz7TMWKtk98iriFkJzg=
=JDZJ
-----END PGP SIGNATURE-----

--ua22z7gh6aszezss--
