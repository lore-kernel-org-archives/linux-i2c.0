From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Mon, 19 Sep 2016 11:02:47 +0200
Message-ID: <20160919110247.4e0657fb@endymion>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
        <20160826173019.1f939ce5@endymion>
        <20160918192250.GA1415@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40829 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752279AbcISJCy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Sep 2016 05:02:54 -0400
In-Reply-To: <20160918192250.GA1415@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yadi Hu <yadi.hu@windriver.com>, linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, 18 Sep 2016 21:22:50 +0200, Wolfram Sang wrote:
> 
> > If not, it may make sense to add a helper function exposing
> > __i2c_first_dynamic_bus_num to drivers (something like
> > i2c_is_dynamic_bus_num().) After all, i2c_add_numbered_adapter() mostly
> > makes sense if static i2c device definitions exist. If not,
> > i2c_add_adapter() is just as good. So something like:
> > 
> > 	if (i2c_is_dynamic_bus_num(i))
> > 		ret = i2c_add_adapter(pch_adap);
> > 	else {
> > 		pch_adap->nr = i;
> > 		ret = i2c_add_numbered_adapter(pch_adap);
> > 	}
> > 
> > may make sense. Unless someone has a better idea.
> 
> PASEMI does:
> 
>         smbus->adapter.nr = PCI_FUNC(dev->devfn);
> 
> I am unsure if there is any guarantee in what order PCI_FUNCs are
> probed, yet I have the feeling we could try a little harder to get the
> numbered adapter. What about this (untested, just to get the idea)?
> 
> static inline int i2c_add_adapter_try_numbered(struct i2c_adapter *new_adap)
> {
> 	int ret;
> 	struct i2c_adapter *old_adap = i2c_get_adapter(new_adap->nr);
> 
> 	if (old_adap && new_adap->nr >= __i2c_first_dynamic_bus_num) {

Note that __i2c_first_dynamic_bus_num is not currently available to
device driver, so your function can't actually be inlined. This is the
reason why I proposed to introduce i2c_is_dynamic_bus_num(). If you
prefer to expose __i2c_first_dynamic_bus_num directly instead, that's
fine with me, but then you probably want to rename it.

> 		i2c_put_adapter(old_adap);
> 		dev_dbg(&new_adap->dev, "Static bus number occupied, trying dynamic number\n");
> 		ret = i2c_add_adapter(new_adap);
> 	} else {
> 		ret = i2c_add_numbered_adapter(new_adap);

You may be leaking a reference to old_adap here (if old_adap is set but
new_adap->nr < __i2c_first_dynamic_bus_num.)

> 	}
> 
> 	return ret;
> }

I'm a bit confused by the logic, it seems unnecessarily complex to me
(but please keep in mind I am working in a noisy environment these days
so maybe it's just me.)

If old_adap is set, i2c_add_numbered_adapter() has no chance of
working. So why are you additionally comparing with
__i2c_first_dynamic_bus_num? For me you should check either, not both.

My own proposal was checking __i2c_first_dynamic_bus_num. To be honest
I can't see the added value of relying on i2c_get_adapter() instead.
Would the result not be exactly the same? Plus it seems racy, just
because i2c_get_adapter() returns NULL at one point in time doesn't
mean the bus numbers will not have been assigned by the time you call
i2c_add_numbered_adapter().

> I used 'static inline' because I think the drivers needing this should
> carry the extra weight. But no major objection to put sth like this also
> into the core. The documentation for this function should carry a big
> note that this is only a workaround and it should not be used directly.

I don't care much where it goes, to be honest.

If you consider it a workaround, what would be the "real fix" for you?

I was wondering if selecting one of these drivers could set a Kconfig
option to initialize __i2c_first_dynamic_bus_num to a non-zero value.
Unfortunately there does not seem to be a way to set a numeric value to
a Kconfig option using select. We would have to do it indirectly as
with CONFIG_HZ:

choice
	default I2C_RESERVED_BUS_NR_0
	config I2C_RESERVED_BUS_NR_0
	config I2C_RESERVED_BUS_NR_2
endchoice

config I2C_RESERVED_BUS_NR
	int
	default 0 if I2C_RESERVED_BUS_NR_0
	default 2 if I2C_RESERVED_BUS_NR_2

config I2C_EG20T
	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
	select I2C_RESERVED_BUS_NR_2

And in i2c-core.c:

__i2c_first_dynamic_bus_num = I2C_RESERVED_BUS_NR;

If that's possible at all... I'm not sure if select works on choice
config options.

Alternatively we could set the default directly based on driver
selection:

config I2C_RESERVED_BUS_NR
	int
	default 0
	default 2 if I2C_EG20T

This is more simple but a little harder to maintain. One possible
problem is if the number of buses isn't known at build time but could
change depending on the hardware, for example. Also I don't know if
more than one such driver can be included in the same kernel.

Or we can make it a user-visible option and leave it on whoever
configures the kernel to get it right. In all cases it would move the
decision to build-time instead of being set dynamically at run-time. 

Note that I am not claiming this is necessarily better than my initial
proposal. I just wanted to mention the possibility.

-- 
Jean Delvare
SUSE L3 Support
