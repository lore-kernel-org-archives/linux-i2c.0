From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ST DDC I2C bus driver v1
Date: Tue, 5 May 2009 22:38:36 +0200
Message-ID: <20090505223836.51b241bc@hyperion.delvare>
References: <63386a3d0905050452v5ade99cav7265c38d74699a8c@mail.gmail.com>
	<20090505134002.GO32548@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090505134002.GO32548-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 5 May 2009 14:40:02 +0100, Ben Dooks wrote:
> On Tue, May 05, 2009 at 01:52:22PM +0200, Linus Walleij wrote:
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-stddci2c.c
> > @@ -0,0 +1,973 @@
> > +/*
> > + *
> > + * drivers/i2c/busses/i2c-stddci2c.c
> 
> Is it really just for DDC? is there another i2c block in the chip?
> if not, can we just call this sti2c or similar?

Both names are equally bad. The driver name starts with "i2c-" so there
is no point in adding "i2c" again. Please use i2c-stddc or i2c-st-u300
or similar.

-- 
Jean Delvare
