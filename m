From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] i2c: refactor parsing of timings
Date: Thu, 26 Mar 2020 12:15:22 +0100
Message-ID: <CAMuHMdWmBE5qpouuJfJMvw_TuxbmnQd70CTH3RVaoK6k5eUcqw@mail.gmail.com>
References: <20200326101647.1756-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXVy1acwXxD9C==gGve-Xb-oPbF7BOpu1BaT=1gvUTdQQ@mail.gmail.com> <20200326105241.GA1538@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200326105241.GA1538@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Mar 26, 2020 at 11:52 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = device_property_read_u32(dev, prop_name, cur_val_p);
> > > +       if (ret && use_def)
> > > +               *cur_val_p = def_val;
> >
> > Alternatively, you could just preinitialize the value with the default value
> > before calling this function, and ignoring ret.
> > That would remove the need for both the def_val and use_def parameters.
>
> I can't do that because if !use_def and ret, then the value must not be
> changed.

Of course the preinitialization must still be done conditionally:

    if (use_defaults)
            t->foo = DEFAULT_FOO;
    i2c_parse_timing(dev, "foo-name", &t->foo);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
