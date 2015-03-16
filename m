From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: rt-mutex usage in i2c
Date: Mon, 16 Mar 2015 21:50:56 +0100
Message-ID: <55074230.20307@linutronix.de>
References: <54FDA380.8030405@linutronix.de>	<20150314112703.GD970@katana>	<20150314113237.GE970@katana> <CABpLfoiQg1smiebL0=nWX4Sp1H+XD9VViUqGk13gRcfdAwkFoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABpLfoiQg1smiebL0=nWX4Sp1H+XD9VViUqGk13gRcfdAwkFoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Galbraith <umgwanakikbuti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/15/2015 08:07 AM, Mike Rapoport wrote:
> On Sat, Mar 14, 2015 at 1:32 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wro=
te:
>> On Sat, Mar 14, 2015 at 12:27:03PM +0100, Wolfram Sang wrote:
>>> Hi Sebastian,
>>>
>>>> - i2c_transfer() has this piece:
>>>>   2091                 if (in_atomic() || irqs_disabled()) {
>>>>   2092                         ret =3D i2c_trylock_adapter(adap);
>>>>
>>>>   is this irqs_disabled() is what bothers me and should not be the=
re.
>>>>   pxa does a spin_lock_irq() which would enable interrupts on retu=
rn /
>>>>   too early.
>>>>   mxs has a wait_for_completion() which needs irqs enabled _and_ m=
akes
>>>>   in_atomic() problematic, too. I have't checked other drivers but=
 the
>>>>   commit, that introduced it, does not explain why it is required.
>=20
> That was some time ago, but as far as I remember, PIO in i2c_pxa was
> required to enable communication with PMIC in interrupt context.

Let me add one thing I forgot: the locking is using raw locks which are
not irq safe. It usually works. But. If the wait_lock is hold during
the unlock's slow path (that means there is no owner but the owner
field is not yet NULL) and the interrupt handler gets here with a
try_lock attempt then and it will spin forever on the wait_lock.

I will try to lookup the threads later=E2=80=A6

Sebastian
