From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] tsl2550: Move from i2c/chips to misc
Date: Tue, 9 Mar 2010 12:56:28 +0100
Message-ID: <20100309125628.5300ee62@hyperion.delvare>
References: <20100309113552.09368dd8@hyperion.delvare>
	<20100309105614.GA4664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100309105614.GA4664-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Mar 2010 11:56:14 +0100, Wolfram Sang wrote:
> On Tue, Mar 09, 2010 at 11:35:52AM +0100, Jean Delvare wrote:
> 
> > Move the last remaining driver from i2c/chips to misc. Good ridance!
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
> 
> Okay, so we move it twice then. Fine with me :)

I wanted to avoid it, but ALS (or whatever it will become) takes too
long to settle, longer than I was wanting to wait for.

> Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks.

-- 
Jean Delvare
