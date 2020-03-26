From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: refactor parsing of timings
Date: Thu, 26 Mar 2020 12:50:12 +0200
Message-ID: <20200326105012.GN1922688@smile.fi.intel.com>
References: <20200326101647.1756-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXVy1acwXxD9C==gGve-Xb-oPbF7BOpu1BaT=1gvUTdQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXVy1acwXxD9C==gGve-Xb-oPbF7BOpu1BaT=1gvUTdQQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 11:36:44AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 26, 2020 at 11:17 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > When I wanted to print the chosen values to debug output, I concluded
> > that a helper function to parse one timing would be helpful.

...

> > +static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
> > +                           u32 def_val, bool use_def)
> > +{
> > +       int ret;
> > +
> > +       ret = device_property_read_u32(dev, prop_name, cur_val_p);
> > +       if (ret && use_def)
> > +               *cur_val_p = def_val;
> 
> Alternatively, you could just preinitialize the value with the default value
> before calling this function, and ignoring ret.
> That would remove the need for both the def_val and use_def parameters.

Some drivers are using false to use_defaults. How they will survive this change?
(See rcar case, for instance)

> > +       dev_dbg(dev, "%s: %u\n", prop_name, *cur_val_p);
> > +}

-- 
With Best Regards,
Andy Shevchenko
