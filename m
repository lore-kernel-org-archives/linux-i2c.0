From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Date: Wed, 27 Jun 2018 20:53:51 +0300
Message-ID: <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon> <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
 <20180626234638.076fb816@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626234638.076fb816@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 27, 2018 at 12:46 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 26 Jun 2018 23:44:36 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Tue, 26 Jun 2018 22:07:03 +0300
>> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> >> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
>> >> <boris.brezillon@bootlin.com> wrote:

>> > I'll say it here because this is not the first time I'm pissed off by
>> > one of your review.
>>
>> Like 'I like offending people, because I think people who get offended
>> should be offended.' ?
>> I'm not that guy, relax.
>
> I'm not offended, just annoyed, and not because I have things to change
> in my patchset (I'm used to that and that's something I comply with
> most of the time), but because the only reviews I had from you were of
> this kind (nitpicking on minor stuff).

OK, point taken.

>> > and most of the time your reviews are superficial (focused on tiny
>> > details or coding style issues). Don't you have better things to do?
>>
>> If your code is written using ancient style and / or API it's not good
>> to start with.
>> Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?
>
> Come on!
>
> - kzalloc() vs kmalloc_array()
> - for (i = 0; i < n, i++) { if (BIT(x) & var) ... }
>   vs
>   for_each_bit_set() (which is not even applicable here because I'm
>   not manipulating an unsigned long)
>
> Where do you see ancient style APIs here?

Both. kmalloc_array() and for_each_set_bit() were introduced quite
long time ago.

On top of that you are open coding, if I'm not mistaken, cpu_to_be32()
and be32_to_cpu().
...and more I believe.

> And that's not even the problem. I'm okay to fix those things, but you
> only ever do these kind of reviews, and sometime you even act like you
> know better than the developer or the maintainer how the code should be
> organized without even digging enough to have a clue (your comment on
> the fact that mask should not be a pointer is a good example of such
> situations).

"sometime". Yes, I admit my mistakes.

>> On top of that you might find more interesting reviews where I pointed
>> out to a memory leak or other nasty stuff. But of course you prefer
>> not to norice that.
>
> Yes, sometime you have valid point, but it gets lost in all the noise.

Btw, you forgot to call of_node_put() on error path in one case. Did I
again missed the details?

>> > I mean, I'm fine when I get such comments from people that also do
>> > useful comments, but yours are most of the time useless and sometime
>> > even wrong because you didn't time to look at the code in details.
>>
>> Calm down, please.
>
> Why? Because I say you didn't look at the code in details? Isn't it
> true? Did you look at what I3C is, how it works or how the I3C framework
> is architectured? Because that's the kind of reviews I'd love to have on
> this series.

You got me.
I have a copy of the spec, this require a bit of time to go through.

For now I can offer you to consider IBI implementation using IRQ chip framework.
It would give few advantages (like we do this for GPIO), such as IRQ
statistics or wake up capabilities.

>> You would simple ignore them. Your choice.
>
> That's not my point. My point is, maybe you should do less reviews but
> spend more time on each of them

Good point.

> so you don't just scratch the surface
> with comments I could get from a tool like checkpatch.

Perhaps you should run checkpatch yourself then?

-- 
With Best Regards,
Andy Shevchenko
