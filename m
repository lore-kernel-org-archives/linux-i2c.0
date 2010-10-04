From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix Kconfig dependencies
Date: Tue, 5 Oct 2010 00:30:20 +0200
Message-ID: <20101004223020.GA14702@sepie.suse.cz>
References: <1286199093-3576-1-git-send-email-mmarek@suse.cz>
 <20101004180346.59b10af7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101004180346.59b10af7-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(Sorry, I missed the patch in your message before)

On Mon, Oct 04, 2010 at 06:03:46PM +0200, Jean Delvare wrote:
> On Mon,  4 Oct 2010 15:31:33 +0200, Michal Marek wrote:
> [...] selects I2C_ALGOBIT which has unmet direct dependencies (I2C && !I2C_HELPER_AUTO)
> > [...]
> 
> This message is obscure. The actual problem is that I2C_ALGOBIT is
> selected but doesn't exist, isn't it?.

I2C_ALGOBIT does exist, but depends on a false value if I2C_HELPER_AUTO
is set. Yes, in this case it does not matter, there won't be any
unresolved symbols during link, but Kconfig has no way to find out what
are hard dependencies and what are tricks to improve the user
experience. 


> I would prefer the fix below, which seems to work for me (but I am no
> Kconfig expert) and preserves the submenu for algo drivers. Only the
> indentation is missing, would be nice to solve.
> 
> ---
>  drivers/i2c/Kconfig       |    3 ++-
>  drivers/i2c/algos/Kconfig |   15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.36-rc6.orig/drivers/i2c/algos/Kconfig	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc6/drivers/i2c/algos/Kconfig	2010-10-04 17:33:10.000000000 +0200
> @@ -2,16 +2,25 @@
>  # I2C algorithm drivers configuration
>  #
>  
> +config I2C_ALGOBIT
> +	tristate
> +
> +config I2C_ALGOPCF
> +	tristate
> +
> +config I2C_ALGOPCA
> +	tristate
> +
>  menu "I2C Algorithms"
>  	depends on !I2C_HELPER_AUTO
>  
>  config I2C_ALGOBIT
> -	tristate "I2C bit-banging interfaces"
> +	prompt "I2C bit-banging interfaces"
>  
>  config I2C_ALGOPCF
> -	tristate "I2C PCF 8584 interfaces"
> +	prompt "I2C PCF 8584 interfaces"
>  
>  config I2C_ALGOPCA
> -	tristate "I2C PCA 9564 interfaces"
> +	prompt "I2C PCA 9564 interfaces"
>  
>  endmenu

Unfortunatelly, this fix does not help. Symbol properties are merged
together, so this just first defines three tristate symbols and later
makes them depend on !I2C_HELPER_AUTO :-(.

Michal
