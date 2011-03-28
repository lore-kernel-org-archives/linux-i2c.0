From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH -next resend] i2c: designware-pcidrv depends on PCI
Date: Mon, 28 Mar 2011 20:49:11 +0200
Message-ID: <20110328184725.GA12158@tarshish>
References: <20110328081043.0a71e36b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110328081043.0a71e36b.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-i2c@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Mon, Mar 28, 2011 at 08:10:43AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> i2c-designware-pcidrv is a PCI driver and should depend on PCI.
> Fixes these build errors:
> 
> drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit declaration of function 'pci_request_region'
> drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit declaration of function 'pci_release_region'
> 

Well, I haven't seen these PCI support patches until now, but this seems to be 
OK, so, FWIW:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/i2c/busses/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20110316.orig/drivers/i2c/busses/Kconfig
> +++ linux-next-20110316/drivers/i2c/busses/Kconfig
> @@ -359,6 +359,7 @@ config I2C_DESIGNWARE_PLATFORM
>  
>  config I2C_DESIGNWARE_PCI
>  	tristate "Synopsys DesignWare PCI"
> +	depends on PCI
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  Synopsys DesignWare I2C adapter. Only master mode is supported.
> --

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
