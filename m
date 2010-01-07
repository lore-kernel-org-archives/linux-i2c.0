From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 1/3] MIPS: Octeon: Add I2C platform driver.
Date: Thu, 07 Jan 2010 23:35:47 +0300
Message-ID: <4B4645A3.30401@ru.mvista.com>
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262894061-32613-1-git-send-email-ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

David Daney wrote:

> Signed-off-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> CC: Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>
>   
[...]
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 20698a6..f2c0602 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -165,6 +165,78 @@ out:
>  }
>  device_initcall(octeon_rng_device_init);
>  
> +
> +#define OCTEON_I2C_IO_BASE 0x1180000001000ull
> +#define OCTEON_I2C_IO_UNIT_OFFSET 0x200
> +
> +static struct octeon_i2c_data octeon_i2c_data[2];
> +
> +static int __init octeon_i2c_device_init(void)
> +{
> +	struct platform_device *pd;
> +	int ret = 0;
> +	int port, num_ports;
> +
> +	struct resource i2c_resources[] = {
> +		{
> +			.flags	= IORESOURCE_MEM,
> +		}, {
> +			.flags	= IORESOURCE_IRQ,
> +		}
> +	};
> +
> +	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
> +		num_ports = 2;
> +	else
> +		num_ports = 1;
> +
> +	for (port = 0; port < num_ports; port++) {
> +		octeon_i2c_data[port].sys_freq = octeon_get_clock_rate();
> +		/*FIXME: should be examined. At the moment is set for 100Khz */
> +		octeon_i2c_data[port].i2c_freq = 100000;
> +
> +		pd = platform_device_alloc("i2c-octeon", port);
> +		if (!pd) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		pd->dev.platform_data = octeon_i2c_data + port;
> +
> +		i2c_resources[0].start =
> +			OCTEON_I2C_IO_BASE + (port * OCTEON_I2C_IO_UNIT_OFFSET);
> +		i2c_resources[0].end = i2c_resources[0].start + 0x20;
>   

   Not 0x1F?

WBR, Sergei
