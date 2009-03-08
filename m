From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C pxa regression
Date: Sun, 8 Mar 2009 20:05:40 +0100
Message-ID: <20090308200540.6c972fd2@hyperion.delvare>
References: <87ljrf6et6.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87ljrf6et6.fsf-GANU6spQydw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Mar 2009 19:37:57 +0100, Robert Jarzmik wrote:
> Hi,
> 
> In linux-next, the commit named "i2c: Add missing KERN_* constants to printks",
> id 77130fc992cfdcce8c0a748a2daef16fc16e76bb, breaks compilation for pxa
> architectures.
> 
> I think that hunk should be amended :
> 
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index bdb1f75..bfa4586 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -210,11 +210,12 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
> >  static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
> >  {
> >         unsigned int i;
> > -       printk("i2c: error: %s\n", why);
> > -       printk("i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
> > +       printk(KERN_ERR "i2c: error: %s\n", why);
> > +       printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
> >                 i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
> > -       printk("i2c: ICR: %08x ISR: %08x\n"
> > -              "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
> > +       printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n"
>                                                       \-> a comma would be
>                                                       welcome here.

Correct, thanks for reporting. This is now fixed.

> > +              readl(_ICR(i2c)), readl(_ISR(i2c)));
> > +       printk(KERN_DEBUG "i2c: log: ");
> >         for (i = 0; i < i2c->irqlogidx; i++)
> >                 printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
> >         printk("\n");

-- 
Jean Delvare
