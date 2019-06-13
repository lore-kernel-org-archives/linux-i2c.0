From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Thu, 13 Jun 2019 11:19:26 +0200
Message-ID: <20190613091926.GB952@kunai>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190612103453.ccet2pneairnlpcc@ninjato>
 <20190612104011.GA4660@dell>
 <20190612104459.gvji3qxym5s4odfq@ninjato>
 <20190613085204.GF4660@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1624337728034579834=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190613085204.GF4660@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: balbi@kernel.org, linux-usb@vger.kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, david.brown@linaro.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============1624337728034579834==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I contacted both of them.
>=20
>  Andy doesn't touch anything that isn't QUP based (8994 and older).
>=20
>  David doesn't deal with MSM platforms if Andy is available.=20

That's good to know, thanks!

> So I guess the decision is yours.  Seeing at this patch is pretty
> trivial and has our ACPI expert's Ack, the decision shouldn't be a
> difficult one.

No worries, the patch will be applied. I just wanted to check if the
listed maintainers are still there. Otherwise I need to orphan this
driver.


--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0CFRkACgkQFA3kzBSg
KbaquBAArPmt8Fz3DGFNlnfxI6ee/fBc4huwdqsLrUXhirCq2NxTHi0g8mc1Y4O5
js7pOOLQSqZ6cTamIqHGv7wNonZ16xhvJPexVAz8CPT9BOysmHI/Z1eBEorBqOh8
MXkJGWXCSJ8li3yAdDLcQWKyj42zzEV7YJ/7kzEVpodSec/ufP1l34mxPNY+gVkj
b2YAX41oX7KMQ+ix+O9dK1U/wja5costVyUNXxjLuzZBTooVShj7dnrcLuROw1ss
I3V09OpXN7E8tF4Tq52gJ3xH1wJslMsi2GGGBFC4kKC3txfO04cuOZsLmf36Jomd
hBFUBBQotylM32w5lshWXcPQOUWBsKlDtfK5qyAhKIeBEvs08pbqK1Lw8hFT8T7t
6kD5Ty0cRPx5yBU0DE46FWuR60RYUqfq+bLYy4Y1O5lyCY2IdM46SMuFo6pp96lq
GQReaFopNp4SCpNPNJCDFtoHegeEoT5JKrcjLHRV9Zg2+p4mNL2O7Epkvi+4JvzV
p1gVvtL0/x5wVD8QWtXq8a7/IQ5oYUaULExw+WzhWD+VV4c/4JyyMNtGpCmnXCAr
EXj+7drBHheZN7nmmrer+sEuAySjTlhhHtFvb2K735P06Etqu5YWAtm88j7FcZUU
SaCzuSKqPQgU401V3+k5aexWOMCEN1DehlbyL+n7nQazEovGM24=
=dLE0
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--


--===============1624337728034579834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1624337728034579834==--
