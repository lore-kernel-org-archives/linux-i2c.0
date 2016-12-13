From: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v6 5/5] ARM: configs: stm32: Add I2C support for STM32
 defconfig
Date: Tue, 13 Dec 2016 11:03:11 +0100
Message-ID: <7a48ebd1-94cc-a0e8-6a6c-25ca76aaeed5@st.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-6-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481559342-6106-6-git-send-email-cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Cedric,

On 12/12/2016 05:15 PM, M'boumba Cedric Madianga wrote:
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Can you please add a commit message.

Thx in advance
Alex

> ---
>  arch/arm/configs/stm32_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index e7b56d4..9494eaf 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -52,6 +52,9 @@ CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_SERIAL_STM32=y
>  CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_STM32F4=y
>  # CONFIG_HWMON is not set
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=y
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
