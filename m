From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/6] i2c: =?iso-8859-1?Q?stm?=
 =?iso-8859-1?Q?32f7=3A_switch_to_I=B2C?= generic property parsing
Date: Fri, 20 Mar 2020 12:30:01 +0200
Message-ID: <20200320103001.GU1922688@smile.fi.intel.com>
References: <20200316154929.20886-4-andriy.shevchenko@linux.intel.com>
 <20200320082342.GA30425@gnbcxd0016.gnb.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57221 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgCTKaA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Mar 2020 06:30:00 -0400
Content-Disposition: inline
In-Reply-To: <20200320082342.GA30425@gnbcxd0016.gnb.st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>

On Fri, Mar 20, 2020 at 09:23:42AM +0100, Alain Volmat wrote:
> On Mon, Mar 16, 2020 at 05:49:27PM +0200, Andy Shevchenko wrote:
> > Switch to the new generic functions: i2c_parse_fw_timings().
> > 
> > While here, replace hard coded values with standard bus frequency definitions.

...

> >  static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
> >  				    struct stm32f7_i2c_setup *setup)
> >  {

> > +	i2c_parse_fw_timings(&pdev->dev, t, false);
> 
> Andy, thanks for the patch.
> Looks fine overall, apart from the above line which should be
> 
>         i2c_parse_fw_timings(i2c_dev->dev, t, false);

Oh, good catch!

If I read the code correctly it's an equivalent, but I see that we don't supply pdev.

I will fix it for v4.

-- 
With Best Regards,
Andy Shevchenko
