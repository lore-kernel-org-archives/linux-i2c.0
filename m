From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/2] lost i2c-nomadik patches
Date: Fri, 12 Aug 2011 01:46:27 +0100
Message-ID: <20110812004627.GE19115@trinity.fluff.org>
References: <1312913828-8229-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312913828-8229-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 09, 2011 at 08:17:08PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> These two must have been missed somewhere between the last merge
> window and 3.1-rc1. If you think they are -rc material then by
> all means please merge them, else we'll wait for the next merge
> window...

ok, will queue them for the weekend's fix push. thanks.
 
> Linus Walleij (1):
>   i2c-nomadik: fix kerneldoc warning
> 
> srinidhi kasagar (1):
>   i2c-nomadik: Do not use _interruptible_ variant call
> 
>  drivers/i2c/busses/i2c-nomadik.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> -- 
> 1.7.3.2
> 

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
