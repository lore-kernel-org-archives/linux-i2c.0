From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: fix master pending state handling
Date: Thu, 10 Oct 2019 08:37:35 +0200
Message-ID: <20191010063735.GA893@kunai>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <20191010003234.GA12710@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2646571758092879859=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010003234.GA12710@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Tao Ren <taoren@fb.com>, linux-arm-kernel@lists.infradead.org, Cedric Le Goater <clg@kaod.org>
List-Id: linux-i2c@vger.kernel.org


--===============2646571758092879859==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, since this is a bugfix, can we get this in 5.4?

Of course! Just giving Tao Ren some time for the Tested-by.


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2e0asACgkQFA3kzBSg
KbZEfA//eG2wIit8ZvHICrI4HHDAD/xgrOjZcCQHKy+PB5uNFMnEVdGy0ifN2Oml
NIZvvWUp0hjhw7ZkPI0uJQ/MLGO47R02T9s9IXx5s0OaxYjB3MINRr1r/8SHvY2h
4CeHFuMbAOdGx6h0vCACwXVpAvjewebvO45bX80AOXq88b8bRtS4Dx9sWIWRS8Fy
5wpSWP0fFbPCimwIkW8SZE6KZcKy4AenP95Jjxyv7YXGFXDRHgV9xAp5eXDw0ZZR
lhfsSkIWsQkNqOCDzwXO6IKX+GMu2UMzX8ipsXi0S2u03/HUGnhlxMg04AwH28x5
iQv7tO0Boj1/OMJ2jfz/QAk0A+C04lo20/z+heHJoBz6BbhFnbXX+tMUzdn070EB
AHN1pcLMlpPufqEcCBPj0Ky0RP2WH48vFqY+uJnTwAWAFx5quO1/DOYBRyzc4kPW
FnDv6cgFtQKIbO6UWyGs4dHOttBFs2KSpNWcFaRxUHqUDpR7BBw0Bt8V7f6irsql
lVPjyAQj5kDm3eA621uZR3/hFP4Ud1hLF1HzF+j9LX/1lA2+PMB/L7E2Yt6Dv+Ba
1vX55ITdwFTyQ1MKpVileOYL1IY62EcFvUdhi5ahyjQNQtHaslKwa/l4Q/WDpMNu
7AjPGDDcjnmNTW2DAcdxbHMeN3so766ZPr08ujZezcXZX7BBT14=
=ApV2
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


--===============2646571758092879859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2646571758092879859==--
