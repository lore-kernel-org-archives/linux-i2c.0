From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] i2c: i801: enable irq for i801 smbus transactions
Date: Wed, 20 Jun 2012 18:21:47 +0800
Message-ID: <CAGS+omDLYvqM69MFbU-pE6mAKT3tQnRw08aqbK73-hUBjOmZ0w@mail.gmail.com>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org>
 <1325847502-17841-3-git-send-email-djkurtz@chromium.org> <20120619204704.69454016@endymion.delvare>
 <20120620105847.65cf37f2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120620105847.65cf37f2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 20, 2012 at 4:58 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Tue, 19 Jun 2012 20:47:04 +0200, Jean Delvare wrote:
>> On Fri, =A06 Jan 2012 18:58:21 +0800, Daniel Kurtz wrote:
>> > @@ -879,8 +953,24 @@ static int __devinit i801_probe(struct pci_de=
v *dev,
>> > =A0 =A0 i801_probe_optional_slaves(priv);
>> >
>> > =A0 =A0 pci_set_drvdata(dev, priv);
>> > +
>> > + =A0 if (priv->features & FEATURE_IRQ) {
>> > + =A0 =A0 =A0 =A0 =A0 init_waitqueue_head(&priv->waitq);
>> > + =A0 =A0 =A0 =A0 =A0 spin_lock_init(&priv->lock);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 err =3D request_irq(dev->irq, i801_isr, IRQF=
_SHARED,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i801_dri=
ver.name, priv);
>> > + =A0 =A0 =A0 =A0 =A0 if (err) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Failed t=
o allocate irq %d: %d",
>>
>> Missing "\n".
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->irq, er=
r);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_del_adapter;
>> > + =A0 =A0 =A0 =A0 =A0 }
>>
>> I believe order is wrong, and interrupt handler should be installed
>> _before_ registering the adapter. Otherwise you have a race conditio=
n
>> where the handler could be called before the waitqueue and spinlock =
are
>> initialized.
>
> Oh, and it's not a theoretical thing. I can reproducibly crash the
> kernel by removing and loading the i2c-i801 driver again. Swapping
> request_irq() and i2c_add_adapter() solves it.

Jean,

Thanks for taking a look at these patches... and for testing them!
They were from more than 7 months ago, so it will take me a little
time to context switch back to the point where I can really digest
your feedback and update and test them again myself.  But, I wanted to
just let you know that I am reading your review comments, and will get
to it as soon as I can.
Speaking of which, I have only seen comments on patches 1 & 2 so far.
Any comments on patch 3?

-Daniel

>
> --
> Jean Delvare
