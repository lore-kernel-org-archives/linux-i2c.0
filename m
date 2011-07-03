From: Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-ocores timeout bug
Date: Mon, 4 Jul 2011 09:45:20 +1000
Message-ID: <CA+Y=x3msvnAw_H8YecQMpUEH__8c0j-1rX7Yu8TS-ybSR11Pqg@mail.gmail.com>
References: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ@mail.gmail.com>
	<20110616185209.08ef41ed@endymion.delvare>
	<87pqlr14z0.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87pqlr14z0.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4 July 2011 06:31, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org> wrote:
>>>>>> "Jean" =3D=3D Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
>
> Hi,
>
> =A0>> Basically the i2c-ocores xfer function, kicks off an interrupt =
driven
> =A0>> array of i2c_msg transfers and waits 1second for it to complete=
 and
> =A0>> just
> =A0>> returns -ETIMEDOUT if it times out. The interrupt driven transf=
er is
> =A0>> *not* stopped on a time out and continues referencing the i2c_m=
sg
> =A0>> structure. In my
> =A0>> case an i2c read the interrupt handler keeps adding bytes to th=
e
> =A0>> structure. Unfortunately after the time out the structure was r=
eleased
> =A0>> and it's length field was changed to a large number and the int=
errupt
> =A0>> driver kept happily writing bytes way past the end of the origi=
nal
> =A0>> buffer until the kernel crashed or locked up!
> =A0>>
> =A0>> Below is a fix that works for me in 2.6.32 which removes the i2=
c_msg
> =A0>> buffer from the interrupt handler and changes the handler to ch=
eck for
> =A0>> it's removal.
>
> There's been some changes to the ocores drivers since then (mainly
> device tree support) - It would be good with a patch that can be appl=
ied
> to head.

Unfortunately the HW I found this bug in runs 2.6.32 and I suspect
it's likely to require a
fair bit of work to port to head and because of the device tree
support I suspect it might be hard to back port the
current driver. But perhaps some one can suggest a simple way?

> =A0>>
> =A0>> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/buss=
es/i2c-ocores.c
> =A0>> index 8dee246..21e57a0 100644
> =A0>> --- a/drivers/i2c/busses/i2c-ocores.c
> =A0>> +++ b/drivers/i2c/busses/i2c-ocores.c
> =A0>> @@ -137,6 +137,12 @@ static void ocores_process(struct ocores_i=
2c *i2c)
> =A0>> wake_up(&i2c->wait);
> =A0>> return;
> =A0>> }
> =A0>> + =A0 =A0 =A0 if (msg =3D=3D 0) {
> =A0>> + =A0 =A0 =A0 /* Caller has with drawn the request, buffer no l=
onger available */
> =A0>> + =A0 =A0 =A0 =A0 =A0 i2c->state =3D STATE_ERROR;
> =A0>> + =A0 =A0 =A0 =A0 =A0 oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP)=
;
> =A0>> + =A0 =A0 =A0 =A0 =A0 return;
> =A0>> + =A0 =A0 =A0 }
>
> I would prefer to send a stop here. You don't know in what context th=
is
> will get called (spurious inteerupts?). I also don't like adding extr=
a
> meaning i2c->msg when we have a perfectly fine state variable.

I was worried about spurious interrupts as well well but never saw any
in practice,
probably just because the interrupt is always valid and just detects
the termination and cleans up.
The thinking behind clearing the buffer pointer is that this dangling
pointer is the big danger and immeadiately
removing it, by making it invalid, guarantees that if the interrupt
checks it will never be writing to released memory
which leads to the corruption and panic() calls et cetera.

> How about you instead set state to STATE_ERROR in ocores_xfer on
> timeouts, and then directly send the stop condition (so not in the
> isr). Otherwise you don't have any guarantee that the next transfer
> isn't setup by the time the interrupt fires.

That occurred to me but I don't know enough about the HW to know what
happens if you write another request on top of an
already running request. I am happy to try different variations but
perhaps some one
has a more informed view of what we can assume about the HWs behaviour.

There is also the race condition where the interrupt routine
ocores_process() increments the i2c-msg (line 146) and the zero-ing of
i2c->msg  in the time out code. But that would be much rarer than the
crash in the original code.

Is there a way to prevent interrupts on any CPU so we can set the
i2c->state (and possibly clear the i2c->msg) safely
or can we use local_irq_save()/local_irq_restore() with out
introducing a spinlock or something to prevent other CPUs from reading
and changing the i2c->state/ i2c->msg variable via an interrupt?

>
> =A0>>
> =A0>> /* error? */
> =A0>> if (stat & OCI2C_STAT_ARBLOST) {
> =A0>> @@ -223,8 +229,13 @@ static int ocores_xfer(struct i2c_adapter =
*adap,
> =A0>> struct i2c_msg *msgs, int num)
> =A0>> if (wait_event_timeout(i2c->wait, (i2c->state =3D=3D STATE_ERRO=
R) ||
> =A0>> (i2c->state =3D=3D STATE_DONE), HZ))
> =A0>> return (i2c->state =3D=3D STATE_DONE) ? num : -EIO;
> =A0>> - =A0 =A0 =A0 else
> =A0>> + =A0 =A0 =A0 else {
> =A0>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_NOTICE
>
> WARNING seems more suitable here.
>
> =A0>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ocores_xfer() i2c transfer to %d=
-%#x timed out\n",
> =A0>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_adapter_id(ad=
ap), msgs->addr);
> =A0>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->msg =3D 0; /* remove the cal=
ler's request which
> =A0>> will be re-used */
> =A0>> return -ETIMEDOUT;
> =A0>> + =A0 =A0 =A0 }
> =A0>> }
>
> --
> Bye, Peter Korsgaard
>

Sure.

If people approve I can submit a patch which uses the state but
introduces a spinlock to guard access to the i2c->msg access. Looking
at the driver some more I think it's unsafe to have the interrupt and
the user space playing with the same data with out a lock
as much as I would like to avoid the extra lock / code.

Either we can split the data into process context only modified and
interrupt only modified areas or a lock is introduced. The original
patch was the smallest way to avoid the issue I could see but isn't
perfect, just reduces the chance of a corruption to a very small but
non-zero level.

Perhaps just a spinlock on changes to i2c->msg or i2c->state?

Andrew
