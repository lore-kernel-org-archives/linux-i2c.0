From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] Topcliff: Update PCH_I2C driver to 2.6.36
Date: Tue, 26 Oct 2010 10:20:48 +0200
Message-ID: <20101026102048.316d0c04@endymion.delvare>
References: <4CC645A1.5010509@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC645A1.5010509-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, "Wang Qi\"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang Yong Y\"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tomoya,

On Tue, 26 Oct 2010 12:06:09 +0900, Tomoya wrote:
> Could you merge this patch to 2.6.37 ? 
> 
> Change Summary
>  - Change Author
>  - Change Name of "Signed-off-by"
> 
> Thanks, Tomoya(OKI SEMICONDUCTOR CO., LTD.)
> 
> ---
> I2C driver of Topcliff PCH
> 
> Topcliff PCH is the platform controller hub that is going to be used in
> Intel's upcoming general embedded platform. All IO peripherals in
> Topcliff PCH are actually devices sitting on AMBA bus.
> Topcliff PCH has I2C I/F. Using this I/F, it is able to access system
> devices connected to I2C.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> Reviewed-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/Kconfig   |    8 +
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-pch.c |  908 ++++++++++++++++++++++++++++++++++++++++++

I don't like this driver name at all. For one thing, "pch" is too
short. Many other vendors could come up with names with acronym "PCH".

For another, Intel has many PCH (Platform Controller Hub) chips, some
of them (5/3400 Series, Cougar Point, Patsburg) are or will be
supported by the i2c-i801 driver, some of them (Moorestown) will be
supported by the upcoming i2c-intel-mid driver (even though the name
"PCH" is surprisingly missing from the source code) and your driver
only supports one particular model.

So please find a name which accurately represents the hardware your
driver is for. i2c-topcliff would be fine with me, but you will have to
check with Intel, as I know they are quite picky with the usage of code
names.

As for the driver code, I will not be able to review it, sorry. It's
not in my area, I don't have the time and I don't have the hardware. I
think it would make sense for Intel people to review and test it before
it gets upstream.

-- 
Jean Delvare
