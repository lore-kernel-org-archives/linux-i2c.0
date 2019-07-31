From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 18/57] i2c: Remove dev_err() usage after
 platform_get_irq()
Date: Wed, 31 Jul 2019 16:30:11 +0200
Message-ID: <20190731143011.GB1680@kunai>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-19-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-19-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -dev_err(...);

What about pr_err, ...?

> While we're here, remove braces on if statements that only have one
> statement (manually).

You can let cocci do this for you, too. From the top of my head:

if (...)
- {
 S
- }

with S being a statement and this rule depending on the matching rule.


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1BpfMACgkQFA3kzBSg
KbYd2xAAq3Fa3pEk4zsTqHw98EaB/Ko5iBApFcFnoiPINoT9hj6CiXIaRsRygAKY
tVMDFDymLmplNlXU+lrc0NVQQ6irFzHeTTYt/BSkFjh30rhJOW1JnfJrRmfqrCpt
N/+2dH+5j3qGZW22NCQUOmEZTZuGKqSwqeyyqJMfcAUokzHCWuFibmN6yXm9QoJY
veOJuSqabB2H9dLHLwYFQ3Yiy+6S3s/puMnvZd4qMqsmjxVgO1E0Xg6CeLsqTKyc
mu/Lo0Qm9FSRLeO+2YgaYt8JGJBS9Vm2eXoNYXYorrIJXZ/yglKixt0DeJbvbyvw
bga7P09n9H0bmk4kYJbIQpM30MHFrAa63y6vpsteyC/zeEVLyPDOaokx6QVZxOuJ
gLHZK/oUnvBS97S2xxJjX0cuejLPjNt1zhx1AJvB29jaPl1J2RLkKyV1hLB/um3S
R1SjHBsqVREHaLGAlgd4fGHF6IiEfOIJWBXB8FXhQ5WcAkF8Rj4Vg9KV/FrQYpE0
OeW8VW43BhPSmjphOJNAc7pg5Jcl+z2JiX0ABjUtEon4HjscaRpDQ99oYDz9dZJ5
0EB0Xcni9EO7gO0nH400BfGwpszheOVpQxfsQj1BQxFFr6nogjEQYI1k5MmM/REt
y2Wo3RiI6i3yRtCaeFjtzVAOYGTrVexGjgNzuMKwa61m9Ox32TU=
=LV2u
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
