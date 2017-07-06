From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Thu, 6 Jul 2017 16:30:16 +0800
Message-ID: <20170706083015.GA6751@spreadtrum.com>
References: <2083c9d6e96a72f9c1324c8a277acfd780a34094.1498472593.git.baolin.wang@spreadtrum.com>
 <6941c6866078fac8fe81d108b573f7408245a0b9.1498472593.git.baolin.wang@spreadtrum.com>
 <CAAfSe-uJZFMA4nr8Ah3OKz0Wx9bJOLHXcWK9Ujxx3kSi=PvaLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAfSe-uJZFMA4nr8Ah3OKz0Wx9bJOLHXcWK9Ujxx3kSi=PvaLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chunyan Zhang <zhang.lyra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Orson Zhai =?utf-8?B?KOe/n+S6rCk=?= <orson.zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Chunyan,

On 一,  7月 03, 2017 at 05:29:57下午 +0800, Chunyan Zhang wrote:
> Hi Baolin,
> 
> On 26 June 2017 at 18:28, Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
> > This patch adds the I2C controller driver for Spreadtrum SC9860 platform.
> >
> > Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
> > ---
> > Changes since v2:
> >  - Remove some redundant comments and parens.
> >  - Define macros instead of magic number.
> >  - Add some comments to explain clock formula.
> >  - Change of_clk_get_by_name() to devm_clk_get().
> >  - Deal with other frequency.
> >  - Change register definiton to low case.
> >  - Change is_last_msg to boolean.
> >  - Other optimization.
> >
> > Changes sice v1:
> >  - Power on I2C device in probe().
> >  - Remove redundant macros and usb __maybe_unused.
> >  - Remove redundant 'of_match_ptr'.
> >  - Modify return values and check the return value for 'clk_prepare_enable'.
> > ---
> >  drivers/i2c/busses/Kconfig    |    7 +
> >  drivers/i2c/busses/Makefile   |    1 +
> >  drivers/i2c/busses/i2c-sprd.c |  683 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 691 insertions(+)
> >  create mode 100644 drivers/i2c/busses/i2c-sprd.c
> >
> 
> [snip]
> 
> > diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> > new file mode 100644
> > index 0000000..a070f61
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-sprd.c
> > @@ -0,0 +1,683 @@
> > +/*
> > + * Copyright (C) 2017 Spreadtrum Communications Inc.
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> 
> According to RobH's comments [1], we're switching to use
> SPDX-License-Identifier tag instead, like [2].
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.2/05122.html
> [2] http://elixir.free-electrons.com/linux/v4.12/source/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts#L6

Will use SPDX-License-Identifier tag instead and resend. Thanks.

> 
> Thanks,
> Chunyan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
