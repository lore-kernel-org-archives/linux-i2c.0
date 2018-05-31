From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
Date: Thu, 31 May 2018 09:21:25 +0300
Message-ID: <CAHp75VdnE19hzJPT-jRO99O1t2aV-qjgHfO8=c0QYZ4iDD5Svg@mail.gmail.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
 <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com> <CAHp75Vd8M4-mK=Fs_SbSX67NKeNty7vrq0-Y8-GyFdy9u6Q3jA@mail.gmail.com>
 <48444d16bd410188bd43ca5eea97f03f70c80f42.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48444d16bd410188bd43ca5eea97f03f70c80f42.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 31, 2018 at 1:34 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2018-05-31 at 00:27 +0300, Andy Shevchenko wrote:
>> On Wed, May 30, 2018 at 6:47 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> > On 05/29/2018 06:19 PM, Andy Shevchenko wrote:
>> > > On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com>
>> > > wrote:

>> > > Isn't below somehow repeats of_i2c_register_devices() ?
>> > > Why not to use it?

>> > Because I need to assign all these port structure fields. Also looks like
>> > of_i2c_register_devices creates new devices; I just want an adapter for each
>> > port.
>>
>> Hmm... Wolfram, what is your opinion on this design?
>
> Andy, I don't understand your issue.
>
> of_i2c_register_devices() is about discovering the i2c devices below a
> given bus. This is not what is happening here.
>
> This is a driver for a master that supports multiple busses, so it the
> above loop creates all the busses.

My issue here, that it feels like a lot of duplication with existing approaches.
Though, it might be a right thing to do at the end. So, let's just
assume maintainer will give their point of view.

>> > > > +                       devm_kfree(dev, port);
>> > >
>> > > This hurts my eyes. Why?!
>> > What would you suggest instead?
>>
>> You even didn't wait for answer, why to ask then?
>
> Please stop being so rude.

OK.

>> Moreover, you didn't answer to my question. Why are you doing that
>> call implicitly?
>
> "implicitly" ? What's implicit here ? This is just pretty standard
> cleanup after failure, you are being very cryptic here.
>
> Please state precisely what it is you dislike with that code instead of
> expecting us to guess and being nasty about it. Eddie was a genuine
> question, he doesn't see what you think is "hurtful to the eyes" in the
> code you quoted.

In 99% cases when someone calls devm_kfree() it means wrong choice of
devm_k*alloc() in the first place.
So, with explanation given why it's done in this way I would rather
suggest to switch to plain k*alloc() / kfree().

Or do we really care about few hundreds of bytes wasted?

-- 
With Best Regards,
Andy Shevchenko
