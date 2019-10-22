From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware
 timeout support
Date: Tue, 22 Oct 2019 06:56:56 +0200
Message-ID: <20191022045655.GA975@kunai>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
 <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
 <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
 <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5716356383810352818=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Brendan Higgins <brendanhiggins@google.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Tao Ren <taoren@fb.com>, Peter Rosin <peda@axentia.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cedric Le Goater <clg@kaod.org>
List-Id: linux-i2c@vger.kernel.org


--===============5716356383810352818==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Changes I submitted in this patch set is for a different purpose which
> is very Aspeed H/W specific, and actually it's a more serious timeout
> setting indeed. If this H/W is used in multi-master environment, it
> could meet a H/W hang that freezes itself in slave mode and it can't
> escape from the state. To resolve the specific case, this H/W provides
> self-recovery feature which monitors abnormal state of SDA, SCL and its
> H/W state machine using the timeout setting to determine the escape
> condition.

Thanks for the summary. I just wonder on what the timeout value depends.
Do we really need to put in DT or can we derive it e.g. from the
compatible value in the driver?


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2ujBMACgkQFA3kzBSg
KbYZZg/+ILRBsr6VA2yU97i07DYrhNgIs0GsfqAA3zqC+JhbF/dyORbZWno4fIxZ
+qHvJ6pTQCR/jWA4aP1kO/NL9EU3nWIICyZHIFJpXBtwrH9mGP1+hlnyrWc2uaZC
JpOw3AKSYevrQb0RksLu16ZddmlMHO0+Qi2rkhh4LGcsdCiUZRSOEeoaQkiyS3Cy
hsb1uqiGFQFdq/gFv08rpW2ja7TGS/HMzs8RdXlOI03bL6ORXU9QCV6H2oIBl00v
9YQYHo9lV5PtRTweCpaN0o+9XLmP1y4A7kHS1lr9YVoRVT67HniEisum3t6UPR2H
B5Ha1IVzBYuqtoq0vhuiowNVmV9OROoM+alQxhw3g6HPT0K+d5GmD9k6aPNXWCod
rBT7QTBslplAZJNo6R2tGvh0wIYWU0PMJ+ZSsS9YdigSqMXfd8C1p2R6ZphdyCk7
dHfEaPa4iuUGYaJWiHFROYni/GhG1EBN3kpUSphG5ETA6Ur16blwXyAZy7oVm5xO
IsIVfsJYBiV/1O77xE7FUF8gXpIalsLLH7/AXH80JexMqZBpu5hg6N6GhbN7K4rl
wZBpfCNq9Rvy65BvFL4Vmw2elrZmo9S7vYs907eZ1ZJNWB9TVpqe+z0c9FNMuAKx
o1ZttPvRuKUhoQTMnQ734eW74vmmrl4IfguSGshRymILa5AaX1Q=
=INXh
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


--===============5716356383810352818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5716356383810352818==--
