From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC Patch v0 2/3] i2c-smbus: Allow building with
 I2C_HELPER_AUTO support
Date: Thu, 27 Mar 2014 07:57:12 +0100
Message-ID: <20140327075712.5121d6ed@endymion.delvare>
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1395880932-19124-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395880932-19124-2-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 26 Mar 2014 17:42:11 -0700, Srinivas Pandruvada wrote:
> Currentlty the config is conditional on !I2C_HELPER_AUTO.
> I don't know their dependency, but without this we can't build.

Nack. Just because you don't understand something and did not bother
looking into it, is no good reason to break a perfectly working and
valid mechanism.

Just read the Kconfig help text for I2C_HELPER_AUTO and you should be
able to figure it out. Also grep the kernel tree for "select I2C_SMBUS".

As a summary: any driver which depends on i2c-smbus, should select it
in Kconfig.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 7b7ea32..212ed73 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -74,7 +74,7 @@ config I2C_HELPER_AUTO
>  	  In doubt, say Y.
>  
>  config I2C_SMBUS
> -	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
> +	tristate "SMBus-specific protocols"
>  	help
>  	  Say Y here if you want support for SMBus extensions to the I2C
>  	  specification. At the moment, the only supported extension is


-- 
Jean Delvare
SUSE L3 Support
