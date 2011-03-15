From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Date: Tue, 15 Mar 2011 10:44:30 -0500
Message-ID: <D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com> <20101220145954.GA1126@trinity.fluff.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101220145954.GA1126-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Dec 20, 2010, at 8:59 AM, Ben Dooks wrote:

> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
>> Currently I2C_MPC supports 32bit system only, then this
>> modification makes it support 32bit and 64bit system both.
>> 
>> Signed-off-by: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> This been build or run tested?

Yes, Any issues with me applying this via the powerpc.git tree?

> 
>> ---
>> drivers/i2c/busses/Kconfig |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 9c6170c..3392f4b 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -422,7 +422,7 @@ config I2C_IXP2000
>> 
>> config I2C_MPC
>> 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
>> -	depends on PPC32
>> +	depends on PPC32 || PPC64
>> 	help
>> 	  If you say yes to this option, support will be included for the
>> 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
>> -- 
>> 1.7.0.4
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/
> 
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
