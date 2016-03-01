From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] i2c-thunderx: fix compile error for x86_64
Date: Tue, 1 Mar 2016 09:02:21 -0800
Message-ID: <56D5CB1D.7010104@caviumnetworks.com>
References: <25e8960abe506539a230db6d31ab75e7195752b8.1456752497.git.jglauber@cavium.com> <1456840398-9275-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456840398-9275-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/01/2016 05:53 AM, Jan Glauber wrote:
> The i2c-thunderx driver only depends on 64BIT and PCI,
> because there is no reason to limit it to ARM64.
>
> Adjusting the check in the header file that selects Octeon
> or ThunderX values to check for CONFIG_I2C_THUNDERX
> instead of CONFIG_ARCH_THUNDER fixes the compile error
> on x86_64.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Yes, CONFIG_ARCH_THUNDER must die wherever it is encountered.

Acked-by: David Daney <david.daney@cavium.com>

That said, since the previous patch set didn't build under some 
configurations, can you fold this in, and submit a v2 that is complete 
and stand alone?

Thanks,
David Daney

> ---
>   drivers/i2c/busses/i2c-cavium.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
> index 8357997..c7398f4 100644
> --- a/drivers/i2c/busses/i2c-cavium.h
> +++ b/drivers/i2c/busses/i2c-cavium.h
> @@ -8,7 +8,7 @@
>   #include <linux/pci.h>
>
>   /* Register offsets */
> -#ifdef CONFIG_ARCH_THUNDER
> +#ifdef CONFIG_I2C_THUNDERX
>   	#define SW_TWSI			0x1000
>   	#define TWSI_INT		0x1010
>   	#define SW_TWSI_EXT		0x1018
>
