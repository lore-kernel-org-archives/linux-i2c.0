From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: Allow selecting BCM2835 I2C controllers on
 ARCH_BRCMSTB
Date: Fri, 10 May 2019 10:12:24 +0200
Message-ID: <20190510101224.3cd5d0f9@endymion>
References: <20190509210438.28223-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509210438.28223-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Eddie James <eajames@linux.vnet.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ajay Gupta <ajayg@nvidia.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  9 May 2019 14:04:36 -0700, Florian Fainelli wrote:
> From: Kamal Dasu <kdasu.kdev@gmail.com>
> 
> ARCH_BRCMSTB platforms have the BCM2835 I2C controllers, allow
> selecting the i2c-bcm2835 driver on such platforms.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 26186439db6b..7277c1051ca2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -435,7 +435,7 @@ config I2C_AXXIA
>  
>  config I2C_BCM2835
>  	tristate "Broadcom BCM2835 I2C controller"
> -	depends on ARCH_BCM2835
> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  BCM2835 I2C controller.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
