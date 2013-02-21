From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Date: Thu, 21 Feb 2013 10:14:34 +0100
Message-ID: <20130221091434.GA22806@the-dreams.de>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
 <CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
 <CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bastian,

> > Also, do you know the reason why this isn't handled in the i2c layer
> > by default? I ask because your comment mentions that i2c-tegra.c does
> > the same thing and I can't see anything in this patch that is actually
> > related to our I2C hardware.
> 
> Yes, many drivers have a similar scheme and to me it more looked like
> all drivers need to take care about this case unrelated to different
> hardware. So the question arises if this can't be handled in the core
> - or if I get something wrong here.

I don't see any reason why this couldn't be handled in the core. If you
want to have a take on this issue (after the other bug is fixed), this
will be highly appreciated.

Thanks,

   Wolfram
