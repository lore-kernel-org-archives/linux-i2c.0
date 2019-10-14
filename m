From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [EXT] Re: [v2,2/2] dt-bindings: i2c-mux-pca954x: Add optional
 property i2c-mux-never-disable
Date: Mon, 14 Oct 2019 03:21:14 +0000
Message-ID: <DB7PR04MB44908DE0F57E985ED40C401A8F900@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190930032503.44425-1-biwen.li@nxp.com>
 <20190930032503.44425-2-biwen.li@nxp.com> <20191011144445.GA2340@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011144445.GA2340@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "peda@axentia.se" <peda@axentia.se>, Leo Li <leoyang.li@nxp.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

>=20
> On Mon, Sep 30, 2019 at 11:25:03AM +0800, Biwen Li wrote:
> > The patch adds an optional property i2c-mux-never-disable
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v2:
> >       - update documentation
> >
> >  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > index 30ac6a60f041..71b73d0fdb62 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > @@ -34,6 +34,7 @@ Optional Properties:
> >      - first cell is the pin number
> >      - second cell is used to specify flags.
> >      See also
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > +  - i2c-mux-never-disable: always forces mux to be enabled.
>=20
> Either needs to have a vendor prefix or be documented as a common
> property.
>=20
> IIRC, we already have a property for mux default state which seems like t=
hat
> would cover this unless you need to leave it in different states.
Okay, you are right, thank you so much. I will try it in v3.
>=20
> Rob
