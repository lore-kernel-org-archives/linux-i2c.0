From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Remove clientdata before kfree?
Date: Sun, 21 Feb 2010 11:32:39 +0100
Message-ID: <20100221113239.4f44752e@hyperion.delvare>
References: <20100221102034.GD25833@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100221102034.GD25833-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 21 Feb 2010 11:20:34 +0100, Wolfram Sang wrote:
> Hi Jean,
> 
> I am teaching myself coccinelle at the moment and created a semantic patch
> which detects missing 'i2c_set_clientdata(client, NULL)' before freeing the
> used data-structure. There are a number of drivers missing that.
> 
> While doing this, it is also trivial to change a few drivers to FIRST use
> i2c_set_clientdata() and THEN kfree (those few are doing it the other way
> around). I think it is cleaner this way, but probably doesn't matter much in
> reality. So, should I do this transformation or rather drop it (which is also
> trivial ;)).

I am very much in favor of enforcing the use of
i2c_set_clientdata(client, NULL) before freeing memory. I admit it
probably doesn't matter that much in practice, but it is a simple
matter of good practice.

-- 
Jean Delvare
