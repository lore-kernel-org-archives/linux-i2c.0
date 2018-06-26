From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Date: Tue, 26 Jun 2018 23:44:36 +0300
Message-ID: <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626215648.1472b96e@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 26 Jun 2018 22:07:03 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > Add a driver for Cadence I3C GPIO expander.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> > +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);
>>
>> kmalloc_array() ?
>>
>> > +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
>> > +                                      ARRAY_SIZE(xfers));
>>
>> One line?
>>

>> You don't change mask here, why do you need a pointer to it?
>
> What are you talking about??!!! This is part of the gpio_chip interface
> that drivers have to implement. You can't decide that mask should not be
> a pointer. And if you actually look at the code, you'll probably see
> that the reason we're passed a pointer here is that the GPIO chip might
> expose more GPIOs than can be represented by an unsigned long, hence
> the array of unsigned long.
>

> I'll say it here because this is not the first time I'm pissed off by
> one of your review.

Like 'I like offending people, because I think people who get offended
should be offended.' ?
I'm not that guy, relax.

>  You seem to review everything that is posted on the LKML,

That's not true.

> and most of the time your reviews are superficial (focused on tiny
> details or coding style issues). Don't you have better things to do?

If your code is written using ancient style and / or API it's not good
to start with.
Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?

On top of that you might find more interesting reviews where I pointed
out to a memory leak or other nasty stuff. But of course you prefer
not to norice that.
I understand you.

> I mean, I'm fine when I get such comments from people that also do
> useful comments, but yours are most of the time useless and sometime
> even wrong because you didn't time to look at the code in details.

Calm down, please.
You would simple ignore them. Your choice.

But okay, I would try to avoid your stuff to make you happier. Sorry
for disturbing.

>> Ditto.

In these two comments I'm indeed wrong.

-- 
With Best Regards,
Andy Shevchenko
