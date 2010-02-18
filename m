From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Thu, 18 Feb 2010 09:45:52 -0800
Message-ID: <4B7D7CD0.7080202@oracle.com>
References: <4B73DAEE.5080400@compulab.co.il> <4B73DB4B.40501@compulab.co.il> <4B7D7C13.20703@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B7D7C13.20703-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/18/10 09:42, Denis Turischev wrote:
> Intel Poulsbo (SCH) chipset LPC bridge controller contains several
> functions. Creating and MFD driver for the LPC bridge controller allows
> simultaneous use of SMBus and GPIO interfaces on the SCH.
> 
> v2 version contains "select MFD_CORE" line.
> 
> Signed-off-by: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> 
> diff -Nru linux-2.6.33-rc7.orig/drivers/mfd/Kconfig
> linux-2.6.33-rc7/drivers/mfd/Kconfig
> --- linux-2.6.33-rc7.orig/drivers/mfd/Kconfig    2010-02-07
> 00:17:12.000000000 +0200
> +++ linux-2.6.33-rc7/drivers/mfd/Kconfig    2010-02-18
> 19:32:01.000000000 +0200
> @@ -348,6 +348,15 @@
>        read/write functions for the devices to get access to this chip.
>        This chip embeds various other multimedia funtionalities as well.
> 
> +config LPC_SCH
> +    tristate "Intel SCH LPC"
> +    default m

Please don't default random modules to be enabled/built.
That could be done via defconfig .. if at all.

> +    depends on PCI
> +    select MFD_CORE
> +    help
> +      LPC bridge function of the Intel SCH provides support for
> +      System Management Bus and General Purpose I/O.
> +
>  endmenu
> 
>  menu "Multimedia Capabilities Port drivers"


-- 
~Randy
