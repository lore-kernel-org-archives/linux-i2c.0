From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Tue, 20 Sep 2016 17:48:15 +0200
Message-ID: <20160920174815.2c2ec827@endymion>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
        <20160826173019.1f939ce5@endymion>
        <20160918192250.GA1415@katana>
        <20160919110247.4e0657fb@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbcITPsX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 20 Sep 2016 11:48:23 -0400
In-Reply-To: <20160919110247.4e0657fb@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yadi Hu <yadi.hu@windriver.com>, linux-i2c@vger.kernel.org

Hi all,

On Mon, 19 Sep 2016 11:02:47 +0200, Jean Delvare wrote:
> My own proposal was checking __i2c_first_dynamic_bus_num. To be honest
> I can't see the added value of relying on i2c_get_adapter() instead.
> Would the result not be exactly the same? Plus it seems racy, just
> because i2c_get_adapter() returns NULL at one point in time doesn't
> mean the bus numbers will not have been assigned by the time you call
> i2c_add_numbered_adapter().
> (...)
> If you consider it a workaround, what would be the "real fix" for you?
> 
> I was wondering if selecting one of these drivers could set a Kconfig
> option to initialize __i2c_first_dynamic_bus_num to a non-zero value.
> Unfortunately there does not seem to be a way to set a numeric value to
> a Kconfig option using select. We would have to do it indirectly as
> with CONFIG_HZ:
> 
> choice
> 	default I2C_RESERVED_BUS_NR_0
> 	config I2C_RESERVED_BUS_NR_0
> 	config I2C_RESERVED_BUS_NR_2
> endchoice
> 
> config I2C_RESERVED_BUS_NR
> 	int
> 	default 0 if I2C_RESERVED_BUS_NR_0
> 	default 2 if I2C_RESERVED_BUS_NR_2
> 
> config I2C_EG20T
> 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
> 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
> 	select I2C_RESERVED_BUS_NR_2
> 
> And in i2c-core.c:
> 
> __i2c_first_dynamic_bus_num = I2C_RESERVED_BUS_NR;
> 
> If that's possible at all... I'm not sure if select works on choice
> config options.
> 
> Alternatively we could set the default directly based on driver
> selection:
> 
> config I2C_RESERVED_BUS_NR
> 	int
> 	default 0
> 	default 2 if I2C_EG20T
> 
> This is more simple but a little harder to maintain. One possible
> problem is if the number of buses isn't known at build time but could
> change depending on the hardware, for example. Also I don't know if
> more than one such driver can be included in the same kernel.
> 
> Or we can make it a user-visible option and leave it on whoever
> configures the kernel to get it right. In all cases it would move the
> decision to build-time instead of being set dynamically at run-time. 
> 
> Note that I am not claiming this is necessarily better than my initial
> proposal. I just wanted to mention the possibility.

I slept over it and start wondering if we aren't trying to address the
problem at the wrong end.

The initial reason why i2c_add_numbered_adapter() was used in the
i2c-eg20t driver (and, I suppose, i2c-pasemi and all other bus drivers)
is because the platform initialization code/data (native or OF-based)
may be declaring slave I2C devices on these buses. This bumps
__i2c_first_dynamic_bus_num, and the bus driver needs to call
i2c_add_numbered_adapter() to get bus numbers below that.

Maybe in that case the bus driver should ALSO get the static bus number
information from the platform initialization code/data. Then the bus
driver would check that information, and use it to call
i2c_add_numbered_adapter() as appropriate if present, or simply call
i2c_add_adapter() if not (or ask i2c_add_numbered_adapter for bus
number -1, which has the same result.)

Looks like drivers i2c-s3c2410, i2c-designware-*, i2c-kempld and
i2c-pxa are already getting this right. So maybe we don't need to
introduce another mechanism, but instead use what is already in place?

-- 
Jean Delvare
SUSE L3 Support
