From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 8 Feb 2015 12:03:25 +0100
Message-ID: <20150208110325.GA2750@katana>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
 <20150207175039.GB6263@katana>
 <54D6EF3D.4030302@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D6EF3D.4030302@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Arend van Spriel <arend@broadcom.com>, Kevin Cernekee <cernekee@chromium.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, Dmitry Torokhov <dtor@google.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Is it really a HW limitation? Could the driver later be extended to
> > continue filling the FIFO if a certain threshold is reached?
> >=20
>=20
> Will return -EOPNOTSUPP. This really depends on whether or not we expect
> one sequence of START + SLV ADDR + DATA + STOP per i2c message. I can
> later extend the driver to refill/re-drain the FIFO for data size >=3D 64
> bytes, if one sequence of SATRT...STOP per message is not a requirement.

It is important to have the terminology clear here: One transfer can
consist of multiple messages. The transfer uses START/STOP at the
beginning/end, the messages within the transfer only REPEATED_START.


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU10J9AAoJEBQN5MwUoCm2ANgQALKCNtbY4aUsxivEuiqT/XT6
RWd9OqSObUdDJ/J30k4huW9EHMVYKvbETq9VdlJIVJtl7XazNA8Qzcmb2fwYq4ey
53YMBtG4/90FATN9jkITtcLKSKuYp1i/YZ6E9TncL66iERM2MeWX41yvI3nODI0+
r5d/RqWk6uFLoHuFPgz6OqEdD0LH40G1L92sgJuBbGqC0pGWW4O1Q2HG7KkIZOHv
5WT9biQKlMFsdcZ8HbmH9sId7eLtnlZfO+vr2g29tbbtHEqWvvABfGpcxRfG8JKF
SQjdVO3a9Cu66mHStaZIT9t2FyAm+FcPclv/cIPc5vp16Kw9miwjXra3KA0jvm53
YiV3nkCjAD+iurfundkgaVX58vE8bLmLzRx+uvjHjpDQrET/HrmHBLskRxWg432S
XCLRjyzBLgfR5bRrvstjiwMnjoyfe6foOXxtiJOSjP6KKI8d4Fif54lMo20gc8fu
EIw9peCt2Odw7oTzscBV99vFfYnVGtkEmTyeqsyIaSQOFvRp25iLMBiGoJAqEpxw
NlX3CJ6My5wCeOMNK09OibHZGJzfZCO9Hism3ORFZcShnF7cbY84OOH64q2hPuuU
P4gblyugL0ZlctR5rnxyzTa+D/RuOFdgRbLnspj0GTmN1+sZm24sxn6/9zlvUOxp
ylJWZLZwl0+i1EwrWlYd
=wIuG
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
