From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: sun6i-p2wi: Add YAML schemas
Date: Wed, 12 Jun 2019 17:38:18 +0200
Message-ID: <20190612153818.q5xj5su33krlignu@flea>
References: <20190605122936.11972-1-maxime.ripard@bootlin.com>
 <CAL_JsqKC7uP0J14A8_CvPhbZkoSRNWSpS1ee+Q4sG013jY=JeQ@mail.gmail.com>
 <20190611090641.byr6mpywkfmbhrbk@flea>
 <CAL_JsqL3cua3u2gNTzHEdgFU0On5J9ziPZeFNiTpu5HS=SJoDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5426759145756999558=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqL3cua3u2gNTzHEdgFU0On5J9ziPZeFNiTpu5HS=SJoDA@mail.gmail.com>
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


--===============5426759145756999558==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jqnskoivfbu5krfp"
Content-Disposition: inline


--jqnskoivfbu5krfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jun 11, 2019 at 08:50:37AM -0600, Rob Herring wrote:
> On Tue, Jun 11, 2019 at 3:06 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Jun 10, 2019 at 03:34:18PM -0600, Rob Herring wrote:
> > > On Wed, Jun 5, 2019 at 6:29 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > +properties:
> > > > +  "#address-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 0
> > >
> > > These 2 are covered by i2c-controller.yaml, right?
> >
> > Indeed, I've removed them.
> >
> > > > +examples:
> > > > +  - |
> > > > +    p2wi@1f03400 {
> > >
> > > i2c@...
> > >
> > > That should fail on the schema (I need to get the schema checking of
> > > examples finished.)
> >
> > That would be great :) The compilation of the examples alone already
> > caught a good number of examples that weren't even compiling.
>
> I'm primarily waiting on a dtc change to be accepted[1]. Feel free to
> review/ack.

I guess it's too late now :)

> > Speaking of examples, one thing that would be great too would be to
> > allow the usage of our C headers. It's not supported at the moment,
> > and this often ends up with an example that is less readable than the
> > actual DT.
>
> It should be. You just have to add them. See
> Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml for
> example.

Hmmm, I'm pretty sure I tried this before. I'll try again.

> Maybe the common interrupt and gpio ones should be added by default.

I guess so, yeah. The GIC too is pretty common

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jqnskoivfbu5krfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQEcaQAKCRDj7w1vZxhR
xWTgAP9WB+1aXtMSPMtLHzMJKOV6r1RNowdkygnwiE+cBDkvOAD7BDqmviqSzzZt
6saIUD3M+DBgvkUTsko4s0nJ4Wp+1AQ=
=GewT
-----END PGP SIGNATURE-----

--jqnskoivfbu5krfp--


--===============5426759145756999558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5426759145756999558==--
