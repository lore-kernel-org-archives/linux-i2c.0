From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C-GPIO: Don't include the asm/gpio.h directly
Date: Wed, 15 Sep 2010 08:35:25 +0200
Message-ID: <20100915083525.16786342@hyperion.delvare>
References: <20100914073053.GA15611@july>
	<20100914232026.GB7494@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914232026.GB7494-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 15 Sep 2010 00:20:26 +0100, Ben Dooks wrote:
> On Tue, Sep 14, 2010 at 04:30:53PM +0900, Kyungmin Park wrote:
> > Don't include asm/gpio.h directly. Use the linux/gpio.h.
> > 
> > Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> will merge this, unless Jean wants to do it, at the next merge window.

Please do, i2c-gpio is mostly used on embedded systems.

Thanks,
-- 
Jean Delvare
