From: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rt-mutex usage in i2c
Date: Sun, 15 Mar 2015 09:07:21 +0200
Message-ID: <CABpLfoiQg1smiebL0=nWX4Sp1H+XD9VViUqGk13gRcfdAwkFoA@mail.gmail.com>
References: <54FDA380.8030405@linutronix.de>
	<20150314112703.GD970@katana>
	<20150314113237.GE970@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150314113237.GE970@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Galbraith <umgwanakikbuti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 14, 2015 at 1:32 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Sat, Mar 14, 2015 at 12:27:03PM +0100, Wolfram Sang wrote:
>> Hi Sebastian,
>>
>> > - i2c_transfer() has this piece:
>> >   2091                 if (in_atomic() || irqs_disabled()) {
>> >   2092                         ret = i2c_trylock_adapter(adap);
>> >
>> >   is this irqs_disabled() is what bothers me and should not be there.
>> >   pxa does a spin_lock_irq() which would enable interrupts on return /
>> >   too early.
>> >   mxs has a wait_for_completion() which needs irqs enabled _and_ makes
>> >   in_atomic() problematic, too. I have't checked other drivers but the
>> >   commit, that introduced it, does not explain why it is required.

That was some time ago, but as far as I remember, PIO in i2c_pxa was
required to enable communication with PMIC in interrupt context.


>> I haven't really looked into it, but a quick search gave me this thread
>> explaining the intention of the code in question:
>>
>> http://lists.lm-sensors.org/pipermail/i2c/2007-November/002268.html
>>
>> Regards,
>>
>>    Wolfram
>>
>
> And adding a recent mail address from Mike to cc.
>



-- 
Sincerely yours,
Mike.
