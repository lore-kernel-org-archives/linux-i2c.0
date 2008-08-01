From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Date: Fri, 1 Aug 2008 10:32:12 -0400
Message-ID: <9e4733910808010732u48ed06a4vc2121c133d91bbbd@mail.gmail.com>
References: <4891F4D8.9090905@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<20080801020303.GA30947@secretlab.ca>
	<9e4733910807311935n1f81f18dw135372d97d3dcb45@mail.gmail.com>
	<ed82fe3e0808010625q53680d42l83f28a6df835f959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ed82fe3e0808010625q53680d42l83f28a6df835f959-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 8/1/08, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> On Thu, Jul 31, 2008 at 9:35 PM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>  > I've having trouble with whether these clocks are a system resource or
>  > something that belongs to i2c. If they are a system resource then we
>  > should make nodes in the root and use a phandle in the i2c node to
>  > link to them.
>
>
> I can't speak for 52xx, but for 8[356]xx, I would say the clocks
>  belong to the I2C devices.  The screwball determination of whether to
>  divide by 1, 2, or 3 only applies to the I2C device only.  The divider
>  itself is not used to drive a clock for any other device.  If you
>  disable I2C support, then you don't need to care about the divider (or
>  its output clock) at all.  That's why I think have the I2C clock in
>  the parent node is wrong, because it would only be used if you had I2C
>  child nodes.  If you didn't have any I2C nodes, then you would need to
>  delete the property from the parent node as well.

I see this as being one of three ways...

The source clocks belong to the platform and the clock messiness
belongs in the platform code.

The source clocks belong to i2c. The i2c driver needs to use platform
specific bindings like Grant proposed.

I don't like the third choice. Keep a simple Linux driver for i2c and
the platform, and then move all of the messy code into uboot.  BTW,
the messy code is about 10 lines. It's going to take more than 10
lines to hide those 10 lines.

I'm also of the view that all clocks are system resources. Linux is
designed to have clock domains, we just aren't using them on PowerPC.
Check out arch/powerpc/kernel/clock.c. They are mostly used on ARM.
Could we define domains I2C1, I2C2,.. and then implement them? That
implies using the root node to communicate the clock speeds to Linux.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
