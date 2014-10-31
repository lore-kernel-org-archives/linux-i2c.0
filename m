From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Fri, 31 Oct 2014 21:58:01 +0000
Message-ID: <20141031215801.GD12801@jhogan-linux.le.imgtec.org>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1414612641-4259-2-git-send-email-ezequiel.garcia@imgtec.com>
 <CAL1qeaEquLhpuSXd5=t9oEXi2iOArDbFFbfVrhOmyu70GR-z7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaEquLhpuSXd5=t9oEXi2iOArDbFFbfVrhOmyu70GR-z7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Fri, Oct 31, 2014 at 02:17:31PM -0700, Andrew Bresticker wrote:
> > +       /*
> > +        * To avoid slave event interrupts in automatic mode, use a timer to
> > +        * poll the abort condition if we don't get an interrupt for too long.
> > +        */
> 
> Why would polling be better than taking the interrupt?  Are an
> excessive number of interrupts generated during normal operation?

You get a slave event and transaction done interrupt for each atomic
mode command (start, data, ack, stop, etc) that gets completed, none of
which are of interest when using automatic mode since those atomic mode
commands are managed automatically by hardware rather than by the I2C
state machine in the ISR.

In practice, normal I2C transactions will be complete well before you
get the timer interrupt, as the timer is "pushed back" during FIFO
maintenance and disabled after the transaction is complete.

In this way normal automatic mode operation isn't impacted by
unnecessary interrupts, but the exceptional abort condition can still be
detected (with a slight delay).

> > +/*
> > + * Timer function to check if something has gone wrong in automatic mode (so we
> > + * don't have to handle so many interrupts just to catch an exception).
> > + */
> > +static void img_i2c_check_timer(unsigned long arg)
> 
> When are slave event interrupts generated during normal operation?
> It's not clear from the TRM I have.

Mainly on completion (or rather detection) of certain atomic mode
commands on the bus. Look for the use of at_slave_event in the driver.
This is used with the atomic mode part, and set to false while it is
waiting for a slave event interrupt before it can continue with the next
atomic mode command.

Cheers
James
