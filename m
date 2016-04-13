From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-platdrv: get fast/std speed scl
 high/low count from DT
Date: Wed, 13 Apr 2016 16:23:45 +0300
Message-ID: <1460553825.6620.134.camel@linux.intel.com>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
	 <CAHp75VcHNdAUeob2iR6U1HbUQzEccdjPy8ffuG4mB_=ZX7EokQ@mail.gmail.com>
	 <20160413201637.284a3673@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160413201637.284a3673@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2016-04-13 at 20:16 +0800, Jisheng Zhang wrote:
> Dear Andy,
>=20
> On Thu, 7 Apr 2016 21:05:35 +0300 Andy Shevchenko=C2=A0=C2=A0wrote:
>=20
> >=20
> > On Wed, Apr 6, 2016 at 10:28 AM, Jisheng Zhang <jszhang@marvell.com=
>
> > wrote:
> > >=20
> > > Sometimes, it's convenient to define the scl's high/low count
> > > directly,
> > > e.g HW people would do some measurement then directly give out th=
e
> > > optimum counts. Previously, we solved the sda falling time and sc=
l
> > > falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put
> > > them
> > > into dt, but what we really care isn't the sda/scl falling time.
> > >=20
> > > From another side, the dw_i2c_acpi_configure() on ACPI platform
> > > also
> > > get hcnt/lcnt values rather than the sda/scl falling time from
> > > ACPI
> > > method, we want similar feature for DT platforms.
> > > =C2=A0
> > Instead of duplicating some words maybe better to explicitly define
> > two groups of parameters and one which supersedes the other.
> I'm sorry, I can't catch your meaning. Could you please kindly give
> more
> details? Or examples of "two groups of parameters"


> --- + - i2c-ss-scl-high-count : should contain the standard speed i2c
> > > clock SCL high
> > > +=C2=A0=C2=A0=C2=A0count.=20


> > > If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-
> > > ns
> > > +=C2=A0=C2=A0=C2=A0will be ignored.

I'm referring to the above sentence. Something like

There are two groups of values identifying i2c timings:

1. i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
2. *-[hl]cnt

The second group of parameters supersedes the first one.


> > > +
> > > + - i2c-ss-scl-low-count : should contain the standard speed i2c
> > > clock SCL low
> > > +=C2=A0=C2=A0=C2=A0count. If defined, the i2c-scl-falling-time-ns=
 and i2c-sda-
> > > falling-time-ns
> > > +=C2=A0=C2=A0=C2=A0will be ignored.
> > > +
> > > + - i2c-fs-scl-high-count : should contain the fast speed i2c
> > > clock SCL high
> > > +=C2=A0=C2=A0=C2=A0count. If defined, the i2c-scl-falling-time-ns=
 and i2c-sda-
> > > falling-time-ns
> > > +=C2=A0=C2=A0=C2=A0will be ignored.
> > > +
> > > + - i2c-fs-scl-low-count : should contain the fast speed i2c cloc=
k
> > > SCL low
> > > +=C2=A0=C2=A0=C2=A0count. If defined, the i2c-scl-falling-time-ns=
 and i2c-sda-
> > > falling-time-ns
> > > +=C2=A0=C2=A0=C2=A0will be ignored.
> > > +
> > > =C2=A0Example :
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c@f0000 {
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index d656657..8739a60 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -188,6 +188,14 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&dev->scl_falling_time);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u32(&pdev->dev, "clo=
ck-
> > > frequency",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&clk_freq);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u16(&pdev->dev, "i2c-ss-sc=
l-
> > > high-count",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&dev->ss_hcnt);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u16(&pdev->dev, "i2c-ss-sc=
l-
> > > low-count",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&dev->ss_lcnt);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u16(&pdev->dev, "i2c-fs-sc=
l-
> > > high-count",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&dev->fs_hcnt);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0device_property_read_u16(&pdev->dev, "i2c-fs-sc=
l-
> > > low-count",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&dev->fs_lcnt);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (has_acpi_comp=
anion(&pdev->dev))
> > > --
> > > 2.8.0.rc3
> > > =C2=A0
> >=20
> >=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
