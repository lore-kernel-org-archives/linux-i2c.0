From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3] i2c: slave-mqueue: add a slave backend to receive and
 queue messages
Date: Wed, 5 Jun 2019 11:25:39 +0300
Message-ID: <CAHp75Vdaeprj0hFXukMqDi_dnK9-vA-O-OTRiGY6y3aGrNHUjQ@mail.gmail.com>
References: <20190531043347.4196-1-eduval@amazon.com> <20190531043347.4196-3-eduval@amazon.com>
 <20190604171611.GS9224@smile.fi.intel.com> <20190605032709.GA1534@u40b0340c692b58f6553c.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605032709.GA1534@u40b0340c692b58f6553c.ant.amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduval@amazon.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Haiyue Wang <haiyue.wang@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 5, 2019 at 6:30 AM Eduardo Valentin <eduval@amazon.com> wrote:
>
> Hey Andry,
>
> Long time no seeing :-)

True!


> > > +#define MQ_MSGBUF_SIZE             CONFIG_I2C_SLAVE_MQUEUE_MESSAGE_SIZE
> > > +#define MQ_QUEUE_SIZE              CONFIG_I2C_SLAVE_MQUEUE_QUEUE_SIZE
> >
> > > +#define MQ_QUEUE_NEXT(x)   (((x) + 1) & (MQ_QUEUE_SIZE - 1))
> >
> > Also possible ((x + 1) % ..._SIZE)
>
> Right.. but I suppose the original idea is to avoid divisions on the hotpath.
>
> So, I am actually fine with the limitation of only using power of 2.

The original code implies that anyway, so, my proposal doesn't
restrict it any farther.
> > > +   {
> > > +           .compatible = "i2c-slave-mqueue",
> > > +   },
> >
> > > +   { },
> >
> > No need for comma here.
>
> It does not hurt to have it either :-)

It's just a protection against some weird cases of adding entries
behind the terminator.

> > > +           .of_match_table = of_match_ptr(i2c_slave_mqueue_of_match),
> >
> > Wouldn't compiler warn you due to unused data?
> > Perhaps drop of_match_ptr() for good...
>
>
> Not sure what you meant here. I dont see any compiler warning.
> Also, of_match_ptr seams to be well spread in the kernel.

If this will be compiled with CONFIG_OF=n...
Though I didn't check all dependencies to see if it even possible. In
any case of_match_ptr() is redundant in both cases here.
Either you need to protect i2c_slave_mqueue_of_match with #ifdef
CONFIG_OF, or drop the macro use.

P.S. Taking into account the last part, I would wait for v7 with that
fixed followed by fixing other nits.

-- 
With Best Regards,
Andy Shevchenko
