From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 5/5] drivers/i2c: Use resource_size
Date: Tue, 14 Jul 2009 23:53:20 +0100
Message-ID: <20090714225320.GA10277@fluff.org.uk>
References: <Pine.LNX.4.64.0907050837160.27464@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0907050837160.27464-QfmoRoYWmW9knbxzx/v8hQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 05, 2009 at 08:37:50AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> 
> Use the function resource_size, which reduces the chance of introducing
> off-by-one errors in calculating the resource size.
> 
> The semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @@
> struct resource *res;
> @@
> 
> - (res->end - res->start) + 1
> + resource_size(res)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

I'll class these as fixes and have applied them to my
tree for linus.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
