From: Matthias Kaehlcke <matthias-RprLehDfhQ3k1uMJSBkQmQ@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data vs scheduled routine calls
	(add_timer) - kernel crash
Date: Tue, 4 Aug 2009 21:45:07 +0200
Message-ID: <20090804194506.GA30151@darwin>
References: <4A788121.8020601@seti.kr.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A788121.8020601-z9XQkeP78BxUq1AO9QMCaQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NiTr0 <nitr0-z9XQkeP78BxUq1AO9QMCaQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

El Tue, Aug 04, 2009 at 09:42:41PM +0300 NiTr0 ha dit:

> I tried to improve voltage/FSB manipulation module for EeePC  
> (http://code.google.com/p/eeepc-linux) - and I found that  
> i2c_smbus_write_block_data will cause kernel panic when is called from  
> function called by timer. I can't see kernel panic message because  
> system print very long call trace. Also on EeePC there is no RS232 port  
> - but I have USB->RS232 dongle, can it be used as terminal for debug  
> messages?
>
> All variables are declared as static, all data is prepared correctly -  
> so IMHO trouble is outside of my driver.
> There is a part of code:
>
> static struct i2c_client eee_pll_smbus_client = {
>        .adapter = NULL,
>        .addr = 0x69,
>        .flags = 0,
> };
> static char eee_pll_data[I2C_SMBUS_BLOCK_MAX];
> static int eee_pll_datalen = 0;
> .......................
>        i2c_smbus_write_block_data(&eee_pll_smbus_client,0,  
> eee_pll_datalen, eee_pll_data);

a possible source of problems is that i2c_smbus_xfer() (invoked by
i2c_smbus_write_block_data()) tries to aquire a mutex if
adapter->algo->smbus_xfer is set.

http://lxr.linux.no/linux+v2.6.30/drivers/i2c/i2c-core.c#L1994

timers are executed in a softirq, ie in interrupt context, but mutexes
must not be used within interrupts.

i'm neither an i2c-core nor an kernel expert, but this point looks
conflictive to me and might be the reason for the kernel panic you
get.

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

        They that can give up essential liberty to obtain a little
           temporary safety deserve neither liberty nor safety
                         (Benjamin Franklin)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
