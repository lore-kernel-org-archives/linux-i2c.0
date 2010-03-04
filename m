From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Don't use the block buffer for I2C block
 writes
Date: Thu, 4 Mar 2010 11:16:44 +0100
Message-ID: <20100304111644.62761ee9@hyperion.delvare>
References: <20100304110109.541b846e@hyperion.delvare>
	<20100304100917.GB18304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100304100917.GB18304-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Ryjkov <oryjkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 4 Mar 2010 11:09:17 +0100, Wolfram Sang wrote:
> > +	/* Experience has shown that the block buffer can only be used for
> > +	   SMBus (not I2C) block transactions, even though the datasheet
> > +	   doesn't mention this limitation. */
> 
> Minor: Comment style?

checkpatch did not complain, and I couldn't find any consistency in
comment style in this driver.

-- 
Jean Delvare
