From: Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH 2/3] i2c: slave-mqueue: add a slave backend to receive
 and queue messages
Date: Wed, 5 Jun 2019 08:31:20 -0700
Message-ID: <20190605153120.GC1534@u40b0340c692b58f6553c.ant.amazon.com>
References: <20190531043347.4196-1-eduval@amazon.com>
 <20190531043347.4196-3-eduval@amazon.com>
 <20190604171611.GS9224@smile.fi.intel.com>
 <20190605032709.GA1534@u40b0340c692b58f6553c.ant.amazon.com>
 <CAHp75Vdaeprj0hFXukMqDi_dnK9-vA-O-OTRiGY6y3aGrNHUjQ@mail.gmail.com>
 <20190605143158.GB1534@u40b0340c692b58f6553c.ant.amazon.com>
 <CAHp75Vc2us0UDmGnzjF0vkzWM_9KqRa0AZKnRsUYmFRTsgwEyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2us0UDmGnzjF0vkzWM_9KqRa0AZKnRsUYmFRTsgwEyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eduardo Valentin <eduval@amazon.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Haiyue Wang <haiyue.wang@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 05, 2019 at 06:20:37PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 5, 2019 at 5:32 PM Eduardo Valentin <eduval@amazon.com> wrote:
> > On Wed, Jun 05, 2019 at 11:25:39AM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 5, 2019 at 6:30 AM Eduardo Valentin <eduval@amazon.com> wrote:
> 
> > Well, yes, but the point is you would be switching from a simple AND (&) operation
> > to a division...
> >
> > I am keeping the power of 2 dep so that we can keep this with a simple &.
> 
> Works for me.
> 
> > > > > > +           .of_match_table = of_match_ptr(i2c_slave_mqueue_of_match),
> > > > >
> > > > > Wouldn't compiler warn you due to unused data?
> > > > > Perhaps drop of_match_ptr() for good...
> > > >
> > > > Not sure what you meant here. I dont see any compiler warning.
> > > > Also, of_match_ptr seams to be well spread in the kernel.
> > >
> > > If this will be compiled with CONFIG_OF=n...
> >
> > I see.. I obviously did not test with that config..
> >
> > > Though I didn't check all dependencies to see if it even possible. In
> > > any case of_match_ptr() is redundant in both cases here.
> > > Either you need to protect i2c_slave_mqueue_of_match with #ifdef
> > > CONFIG_OF, or drop the macro use.
> >
> > I will wrap it into CONFIG_OF..
> 
> Would be this expected to work in the case of CONFIG_OF=n?
> If no, why to introduce ugly #ifdef:s and additional macros?

I do hate those too...

> Wouldn't be better to have
>   depends on OF || COMPILE_TEST

Well, technically, the original author had a case for using this
without CONFIG_OF. That is why I did not force here to be a strong
dependency on CONFIG_OF. So, I guess in this case the driver will
work properly in both cases if we:

+#ifdef CONFIG_OF
+static const struct of_device_id i2c_slave_mqueue_of_match[] = {
+       {
+               .compatible = "i2c-slave-mqueue",
+       },
+       { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, i2c_slave_mqueue_of_match);
+#endif
+
+static struct i2c_driver i2c_slave_mqueue_driver = {
+       .driver = {
+               .name   = "i2c-slave-mqueue",
+               .of_match_table = of_match_ptr(i2c_slave_mqueue_of_match),
+       },
+       .probe          = i2c_slave_mqueue_probe,
+       .remove         = i2c_slave_mqueue_remove,
+       .id_table       = i2c_slave_mqueue_id,
+};

The above is a well stablish pattern across the drivers.

> ?
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
All the best,
Eduardo Valentin
