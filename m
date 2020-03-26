From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: refactor parsing of timings
Date: Thu, 26 Mar 2020 14:05:19 +0200
Message-ID: <20200326120519.GS1922688@smile.fi.intel.com>
References: <20200326101647.1756-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXVy1acwXxD9C==gGve-Xb-oPbF7BOpu1BaT=1gvUTdQQ@mail.gmail.com>
 <20200326105241.GA1538@ninjato>
 <CAMuHMdWmBE5qpouuJfJMvw_TuxbmnQd70CTH3RVaoK6k5eUcqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:55934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgCZMFS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 08:05:18 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmBE5qpouuJfJMvw_TuxbmnQd70CTH3RVaoK6k5eUcqw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Thu, Mar 26, 2020 at 12:15:22PM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 26, 2020 at 11:52 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret = device_property_read_u32(dev, prop_name, cur_val_p);
> > > > +       if (ret && use_def)
> > > > +               *cur_val_p = def_val;
> > >
> > > Alternatively, you could just preinitialize the value with the default value
> > > before calling this function, and ignoring ret.
> > > That would remove the need for both the def_val and use_def parameters.
> >
> > I can't do that because if !use_def and ret, then the value must not be
> > changed.
> 
> Of course the preinitialization must still be done conditionally:
> 
>     if (use_defaults)
>             t->foo = DEFAULT_FOO;
>     i2c_parse_timing(dev, "foo-name", &t->foo);

If the default *is* coming from timings structure?

Care to look at rcar case?

-- 
With Best Regards,
Andy Shevchenko
