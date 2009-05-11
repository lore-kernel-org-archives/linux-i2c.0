From: =?GB2312?B?0sHU8w==?= <wxc200@gmail.com>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
	report
Date: Mon, 11 May 2009 18:11:35 +0800
Message-ID: <fd6b62c10905110311w6350828tf90d9c699b73fe30@mail.gmail.com>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk>
	<20090506102202.73d6045d@hyperion.delvare> <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758436AbZEKKMu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Abbott <michael@araneidae.co.uk>
Cc: Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2009/5/11 Michael Abbott <michael@araneidae.co.uk>
>
> On Wed, 6 May 2009, Jean Delvare wrote:
> > On Wed, 6 May 2009 08:32:09 +0100 (BST), Michael Abbott wrote:
> > > All the i2c pxa error messages should probably be KERN_DEBUG
> > >
> > > At least, all the printk messages should have a log level specfie=
d,
> > > and KERN_DEBUG seems appropriate.
> > >
> > > Signed-off-by: Michael Abbott <michael.abbott@diamond.ac.uk>
> > > ---
> > > =A0drivers/i2c/busses/i2c-pxa.c | =A0 =A08 ++++----
> > > =A01 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2=
c-pxa.c
> > > index bdb1f75..8cb9160 100644
> > > --- a/drivers/i2c/busses/i2c-pxa.c
> > > +++ b/drivers/i2c/busses/i2c-pxa.c
> > > @@ -210,11 +210,11 @@ static irqreturn_t i2c_pxa_handler(int this=
_irq, void *dev_id);
> > > =A0static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, co=
nst char *why)
> > > =A0{
> > > =A0 =A0 unsigned int i;
> > > - =A0 printk("i2c: error: %s\n", why);
> > > - =A0 printk("i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
> > > + =A0 printk(KERN_DEBUG "i2c: error: %s\n", why);
> > > + =A0 printk(KERN_DEBUG "i2c: msg_num: %d msg_idx: %d msg_ptr: %d=
\n",
> > > =A0 =A0 =A0 =A0 =A0 =A0 i2c->msg_num, i2c->msg_idx, i2c->msg_ptr)=
;
> > > - =A0 printk("i2c: ICR: %08x ISR: %08x\n"
> > > - =A0 =A0 =A0 =A0 =A0"i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i=
2c)));
> > > + =A0 printk(KERN_DEBUG "i2c: ICR: %08x ISR: %08x\n"
> > > + =A0 =A0 =A0 =A0 =A0KERN_DEBUG "i2c: log: ", readl(_ICR(i2c)), r=
eadl(_ISR(i2c)));
> > > =A0 =A0 for (i =3D 0; i < i2c->irqlogidx; i++)
> > > =A0 =A0 =A0 =A0 =A0 =A0 printk("[%08x:%08x] ", i2c->isrlog[i], i2=
c->icrlog[i]);
> > > =A0 =A0 printk("\n");
> >
> > Already fixed in Linus' tree:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3D154d22b04ae1741c5fcfd5d747b813a9a279abff#patch4
>
> Now this is very odd. =A0I'd assumed the error messages I was getting=
 were
> just noise, but the commit you point me to uses KERN_ERR instead -- a=
nd so
> I get a brief storm of these messages on boot on my target:
>
> [ =A0 20.667923] i2c: error: exhausted retries
> [ =A0 20.671962] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
> [ =A0 20.677113] i2c: ICR: 000007e0 ISR: 00000002
> [ =A0 20.677128] i2c: log: [00000446:000007e0]
>
> This is repeated nine times in total with exactly the same numbers. =A0=
Any
> thoughts as to what this means? =A0Other than these messages on start=
up my
> I2C sensors seem to work perfectly well.
If all error messages seem like "exhausted retries",not "timeout or
master error",there maybe some operation conflicts,and i2c controller
cannot succeed operateing after max times retry.  And which mode do
your i2c work?  Poll or Interrupt?

thanks
--wxc200

> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
