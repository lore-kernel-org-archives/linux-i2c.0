From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH RFC/RFT] i2c/busses: Fix build error if
 CONFIG_I2C_DESIGNWARE_PLATFORM=y && CONFIG_I2C_DESIGNWARE_PCI=y
Date: Fri, 27 Jul 2012 18:39:51 +0200
Message-ID: <20120727183951.4d9aab34@endymion.delvare>
References: <1339591897.9672.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339591897.9672.6.camel@phoenix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Axel,

On Wed, 13 Jun 2012 20:51:37 +0800, Axel Lin wrote:
> This patch adds config I2C_DESIGNWARE_CORE in Kconfig, and let
> I2C_DESIGNWARE_PLATFORM and I2C_DESIGNWARE_PCI select I2C_DESIGNWARE_CORE.
> 
> Because both I2C_DESIGNWARE_PLATFORM and I2C_DESIGNWARE_PCI can be built as
> built-in or module, we also need to export the functions in i2c-designware-core.
> 
> This fixes below build error when CONFIG_I2C_DESIGNWARE_PLATFORM=y && CONFIG_I2C_DESIGNWARE_PCI=y:
> 
>   LD      drivers/i2c/busses/built-in.o
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_clear_int':
> i2c-designware-core.c:(.text+0xa10): multiple definition of `i2c_dw_clear_int'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x928): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_init':
> i2c-designware-core.c:(.text+0x178): multiple definition of `i2c_dw_init'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x90): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `dw_readl':
> i2c-designware-core.c:(.text+0xe8): multiple definition of `dw_readl'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x0): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_isr':
> i2c-designware-core.c:(.text+0x724): multiple definition of `i2c_dw_isr'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x63c): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_xfer':
> i2c-designware-core.c:(.text+0x4b0): multiple definition of `i2c_dw_xfer'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x3c8): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_is_enabled':
> i2c-designware-core.c:(.text+0x9d4): multiple definition of `i2c_dw_is_enabled'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x8ec): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `dw_writel':
> i2c-designware-core.c:(.text+0x124): multiple definition of `dw_writel'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x3c): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_xfer_msg':
> i2c-designware-core.c:(.text+0x2e8): multiple definition of `i2c_dw_xfer_msg'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x200): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_enable':
> i2c-designware-core.c:(.text+0x9c8): multiple definition of `i2c_dw_enable'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x8e0): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_read_comp_param':
> i2c-designware-core.c:(.text+0xa24): multiple definition of `i2c_dw_read_comp_param'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x93c): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_disable':
> i2c-designware-core.c:(.text+0x9dc): multiple definition of `i2c_dw_disable'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x8f4): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_func':
> i2c-designware-core.c:(.text+0x710): multiple definition of `i2c_dw_func'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x628): first defined here
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_disable_int':
> i2c-designware-core.c:(.text+0xa18): multiple definition of `i2c_dw_disable_int'
> drivers/i2c/busses/i2c-designware-platform.o:i2c-designware-platdrv.c:(.text+0x930): first defined here
> make[3]: *** [drivers/i2c/busses/built-in.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> I don't have this hardware, just try to fix the build error I found.

Good catch. I can't test it either but your patch looks sane. Wolfram,
I think these drivers are mostly used on embedded platforms so it would
make more sense that you (or Ben) pick it. Please let me know if you
want _me_ to take it for whatever reason.

I also think this patch should go to stable kernel trees 3.2 and later,
as it fixes a build bug.

-- 
Jean Delvare
