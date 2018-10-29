From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Mon, 29 Oct 2018 09:50:15 +0100
Message-ID: <5352289.A0jT2G1FDH@pcbe13614>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <4222986.LvGMQbjSbS@pcbe13614> <87woq438li.fsf@dell.be.48ers.dk>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87woq438li.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Friday, October 26, 2018 7:45:29 PM CET Peter Korsgaard wrote:
> >>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:
> Hi,
> 
>  >> > -       } else
>  >> > +       } else {
>  >> > 
>  >> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
>  >> > 
>  >> > +       }
>  >> 
>  >> This looks unrelated to $SUBJECT.
>  > 
>  > Do you prefer a different patch just for styling?
> 
> Yes please, it is a lot nicer to keep functional changes from pure style
> changes.

Ok

>  >> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
>  >> > +{
>  >> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits
>  >> > */
>  >> > +       u8 loop_on;
>  >> > +
>  >> > +       usleep_range(sleep_min, sleep_min + 10);
>  >> 
>  >> Where does this 10 come from?
>  > 
>  > It's true, it's just a random number. It can be zero as well, and we ask
>  > the system to just sleep for that amount of time.
>  > 
>  > (1) usleep_range(sleep_min, sleep_min);
> 
> Or just usleep(sleep_min);

This does not exist as far as I know; the alternative is an active wait with 
udelay. But then, it is not that different from just start polling TIP or BUSY 
flags.

I think that something like this could be better

(2) usleep_range(sleep_min, sleep_min * XXX);

But.
Since it is better to make this patch ready for xfer_irqless, then I will 
definitively go for udelay(). The reason is that, xfer_irqless may run in 
atomic context where we can't sleep at all.
