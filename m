From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 2/3] i2c: add support for Socionext SynQuacer I2C
 controller
Date: Wed, 4 Apr 2018 20:34:11 +0200
Message-ID: <20180404183411.rrukznuwmtbwwyjd@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-3-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5198818327616283628=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180325110747.8852-3-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5198818327616283628==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opzuznbiydjoa63m"
Content-Disposition: inline


--opzuznbiydjoa63m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 25, 2018 at 12:07:46PM +0100, Ard Biesheuvel wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.
>=20
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Removed two empty lines found by 'checkpatch --strict' and applied to
for-next, thanks!


--opzuznbiydjoa63m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrFGqMACgkQFA3kzBSg
KbabuBAAkybcS87PcbL1iEGKsiK3wPRbjsDMfJkjylMhj6s8AmABz/xi8oBzcCJd
A6loU8oc68uAYWtuQlvwvWDACn31vZKY0eZvJ1oP0LReSQqBQI8h034Y0sfHJ/BN
meqzeO4veLRe5G6ae3niHDdiznn8KC8xR86vELWMlHmjysE9Cd8TjHoAI88RZk6k
1p+v1EEKyQD05iDZ+Buj9jqs40KYYQRefJxK2/XOojV/gYpn88xVZvx8BxG2Ly0k
YocUGW4f9QmIh0C+fWq8jjArFuFmCDZ4c8Xbr89rSr+wehgEhXHi5QGUNN2NYyWu
bNcYAKOI7/PP/etNgC7VNy37Dtog4WqvPWT9X1HJAjKOZPbMWrzDeaLZOFKmDlqW
vE3K/14kS40bPl2hLoSvHJjqfy0/9087lF1s+GnZaJEEwYS4QrjS7Lv4g8FpdPKY
M38M4UBJ4u/87XF/O+6X6gnGWUXSpYRGKshZrVkyNQg4RAtPinHU8IiYCdbeuiDz
kB+zC+6YGJX2mibiKB8hOsPU7xz68xYV0a7uEKpkTB4lTnD/f1cDJS/hFI98ztJv
TAmMcybEIpxRbtc7xFo+V8h/iW9lmNTdiYtXDzf3bNvMxnUxOqmmDsmLzFWgxPPs
QlSukbz2v2sMIRHbjfvTS1tQ0sbS3DKXSIddjQhoqJ47iADesyI=
=+9Lh
-----END PGP SIGNATURE-----

--opzuznbiydjoa63m--


--===============5198818327616283628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5198818327616283628==--
