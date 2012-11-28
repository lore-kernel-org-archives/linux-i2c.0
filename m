From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c mux: outdated wiki page
Date: Wed, 28 Nov 2012 23:00:33 +0100
Message-ID: <20121128230033.351de047@endymion.delvare>
References: <CAAXf6LVzLqtUVWRH4aM4rVzqizxbA2Bdk2aO7BspD9S4cc3zbg@mail.gmail.com>
	<20121128100612.GB18521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128100612.GB18521-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thomas De Schampheleire <patrickdepinguin+linuxi2c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 28 Nov 2012 11:06:12 +0100, Wolfram Sang wrote:
> > It seems that in the mean time, at least some of this code has been
> > introduced in mainline Linux, and the wiki page is hence pretty
> > outdated.
> 
> Yes. The I2C subsystem is currently handed over from Jean to me, and I
> wanted to ask Jean to update it to the best of his knowledge during the
> transition. Just -EBUSY came along...
> 
> @Jean: Do you have a few minutes to do this in the near future?

Yes, I'm reviewing the wiki right now. Thankfully there's not much
content there so it shouldn't take too much time. And I agree it's a
task for me to complete before I leave, as a matter of fairness.

Wolfram, there's one section for you to update:
https://i2c.wiki.kernel.org/index.php/Linux_2.6_I2C_development_FAQ#Where_do_all_the_patches_go.3F
I described my work flow there, obviously it's out of date now but only
you can tell what it will be from now on.

It's a little late now so I won't have the time to finish with the
wiki, I'll do the rest (basically the multiplexing page) tomorrow.

> > Although I understand that a wiki can be edited by anyone, I currently
> > don't have the full view on which problems still remain, if any.
> > Therefore I'd like to check with you what the high-level status of the
> > i2c mux support is.
> 
> We use it in projects already :)

Yes, the i2c multiplexing code can be considered mature now.

-- 
Jean Delvare
