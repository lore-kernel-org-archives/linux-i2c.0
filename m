From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: mv64xxx: Add YAML schemas
Date: Tue, 11 Jun 2019 11:07:14 +0200
Message-ID: <20190611090714.sjqyo4cqyh7l4li2@flea>
References: <20190605122936.11972-1-maxime.ripard@bootlin.com>
 <20190605122936.11972-2-maxime.ripard@bootlin.com>
 <CAL_JsqJczoTpq=8BS5FwL3TJmitZp9e4Mh4oXcvgOMdRmoURvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6313579398122538006=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJczoTpq=8BS5FwL3TJmitZp9e4Mh4oXcvgOMdRmoURvQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Gregory Clement <gregory.clement@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Linux I2C <linux-i2c@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============6313579398122538006==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i4ldgqqqixlfi53r"
Content-Disposition: inline


--i4ldgqqqixlfi53r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2019 at 03:37:17PM -0600, Rob Herring wrote:
> > +examples:
> > +  - |
> > +    timer {
>
> timer?
>
> (and missing unit-address)

Yeah, sorry, this is a copy and paste issue..

I've fixed it in v3.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--i4ldgqqqixlfi53r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXP9vQgAKCRDj7w1vZxhR
xVKXAP0RF4cYMBzsD/TKvd2+MSBUJprWGV+yr32Y+uRWTlAbRAD9EcJQoYoITgBA
6SZNHmYk4JttNkI5odc971TTyVX0UAw=
=XakM
-----END PGP SIGNATURE-----

--i4ldgqqqixlfi53r--


--===============6313579398122538006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6313579398122538006==--
