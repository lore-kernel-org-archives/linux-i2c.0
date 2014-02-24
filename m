From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
Date: Mon, 24 Feb 2014 10:00:41 -0800
Message-ID: <20140224180040.GC32621@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <5306BFC4.5000005@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5306BFC4.5000005@elopez.com.ar>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Emilio L?pez <emilio@elopez.com.ar>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, Andy Gross <agross@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On Thu 20 Feb 18:53 PST 2014, Emilio L?pez wrote:

> Hi Bjorn,
>=20
> El 20/02/14 21:38, Bjorn Andersson escribi=F3:
[...]
> > +	clk_freq =3D 100000;
> > +	if (!of_property_read_u32(node, "clock-frequency", &val))
> > +		clk_freq =3D val;
>=20
> val will be modified only if no error occurs, so you may rewrite this=
=20
> bit as
>=20
> +	u32 clk_freq =3D 100000;
> ...
> +	of_property_read_u32(node, "clock-frequency", &clk_freq)

Seems the two conventions used in the kernel is either your proposal or=
 "if
fail the assign default". So I'll change this.

>=20
> > +
> > +	/* We support frequencies up to FAST Mode (400KHz) */
> > +	if (clk_freq <=3D 0 || clk_freq > 400000) {
>=20
> And you can drop the < check when it's unsigned.

Indeed!

>=20
> > +		dev_err(qup->dev, "clock frequency not supported %d\n",
> > +			clk_freq);
> > +		return -EIO;
>=20
> EIO?

EINVAL

>=20
> Cheers,
>=20
> Emilio

Thanks,
Bjorn
