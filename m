From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Wed, 12 Jun 2019 12:34:53 +0200
Message-ID: <20190612103453.ccet2pneairnlpcc@ninjato>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5829541328941561870=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
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


--===============5829541328941561870==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2p7l3jstr6cxok3"
Content-Disposition: inline


--o2p7l3jstr6cxok3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 09:42:06AM +0100, Lee Jones wrote:
> Add a match table to allow automatic probing of ACPI device
> QCOM0220.  Ignore clock attainment errors.  Set default clock
> frequency value.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Sadly, there is no cover-letter describing if there is a dependency or
not. I assume there is, otherwise I would get the I2C patches only? But
what is the suggested way upstream then?

Also, the current maintainer entry for this driver looks like:

drivers/i2c/busses/i2c-qcom-geni.c:
        Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
        David Brown <david.brown@linaro.org> (maintainer:ARM/QUALCOMM SUPPO=
RT)
        Alok Chauhan <alokc@codeaurora.org> (supporter:QUALCOMM GENERIC INT=
ERFACE I2C DRIVER)

I didn't hear from those people yet, would be great to have their acks.


--o2p7l3jstr6cxok3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A1U0ACgkQFA3kzBSg
KbaoxBAAhggdoyYJ7Ory41uJZnpyS7E81TmUKsmVqsSij9MOr2pAO6ksoixVcsKJ
o+uoFROtUHSJfi/0ZzdMkt9qn50fRBn525tiT+IirJnXotAS8f9eTtzZwl14wBCS
+yVDItXLHA5jJqBwgGQeGAzn+/PuGOdp4NxsATnAOEh9QJyVjHppT7nUQGBv6yrH
qEgQCLKuywZbsg/GSwwyZ0TfWFbVgenGRiVCWyYNEMQeGntZWG9/JF6ad0C+x7+P
GYPM83p0krqDMIfWCh/P1M02Tu++P+IB68u4cHwZvDDpKFTqgthSENVPdZYJ4RB4
irJUfrFJPOV+JNit85YZfAqV8gkt4bPWXm6+h/sOD2LyK2P5A7+X9+l5pyb7EJl6
t6YPDfHl1Z7dP8rgKzbBkyhPS0KJS0XoC5JyPm7YsYWYywMAOIqd4GDP869ZQGD8
FTbgmw9hsU9KA+j78B7DmgasSRUutFQLoSAKZLK+HTXPg8Zsa/XWA4m6zN1xH1Dp
KEo+IF0ioEhbhSNqN8PzfKr1OJcaW07Fw61syO497VS5d2JXml4mseeUGRBSXOwG
hD4R3Jv30x/U9HzyYVmjV5qS+P9hIcwrIKKWNIND0+kXwGsWYBD/pl4BQZfcufA8
qvL2wQs5sTFynh8ZgAvv6vczs7Nlsb/08XrEJjRm8hYpXu+8s9U=
=xlPb
-----END PGP SIGNATURE-----

--o2p7l3jstr6cxok3--


--===============5829541328941561870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5829541328941561870==--
