From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv6 08/11] i2c: match vendorless strings on the internal
 string length
Date: Wed, 26 Oct 2016 09:53:16 +0100
Message-ID: <20161026085316.GK8574@dell>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
 <1477413715-22894-9-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477413715-22894-9-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 25 Oct 2016, Kieran Bingham wrote:

> If a user provides a shortened string to match a device to the sysfs i2c
> interface it will match on the first string that contains that string
> prefix.
> 
> for example:
>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
> 
> will match as3711, as3722, and ak8975 incorrectly.
> 
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

Acked-by: Lee Jones <lee.jones@linaro.org>
  
> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 01bce56f733a..50c9cfdb87b7 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1708,7 +1708,7 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
>  		else
>  			name++;
>  
> -		if (!strncasecmp(client->name, name, strlen(client->name)))
> +		if (!strncasecmp(client->name, name, strlen(name)))
>  			return matches;
>  	}
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
