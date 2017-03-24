From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: i2c-stm32: Document the STM32F7 I2C
 bindings
Date: Fri, 24 Mar 2017 08:46:15 -0500
Message-ID: <20170324134615.o3vpwgmisrpkwswj@rob-hp-laptop>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-2-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34590 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdCXNqS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Mar 2017 09:46:18 -0400
Content-Disposition: inline
In-Reply-To: <1489744738-21632-2-git-send-email-cedric.madianga@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: wsa@the-dreams.de, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, pierre-yves.mordret@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Mar 17, 2017 at 10:58:54AM +0100, M'boumba Cedric Madianga wrote:
> This patch adds the documentation of device tree bindings for STM32F7 I2C
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> index 78eaf7b..8288724 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> @@ -1,7 +1,9 @@
>  * I2C controller embedded in STMicroelectronics STM32 I2C platform
>  
>  Required properties :
> -- compatible : Must be "st,stm32f4-i2c"
> +- compatible : Must be one of the following
> +  - "st,stm32f4-i2c"
> +  - "st,stm32f7-i2c"
>  - reg : Offset and length of the register set for the device
>  - interrupts : Must contain the interrupt id for I2C event and then the
>    interrupt id for I2C error.
> @@ -14,8 +16,22 @@ Required properties :
>  
>  Optional properties :
>  - clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
> -  the default 100 kHz frequency will be used. As only Normal and Fast modes
> -  are supported, possible values are 100000 and 400000.
> +  the default 100 kHz frequency will be used.
> +  For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
> +  100000 and 400000.
> +  For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
> +  possible values are 100000, 400000 and 1000000.
> +- st,i2c-timing : A 32-bit I2C timing refister value.

s/refister/register/

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +  This value is only required for "st,stm32f7-i2c".
> +  A specific external tool delivered by ST is used to compute the value to be
> +  set here according to i2C speed frequency, i2c clock source frequency,
> +  i2c rise time and i2c fall time inputs.
> +  - bit 31:28: PRESC[3:0]: Timing prescaler
> +  - bit 27:24: Reserved
> +  - bit 23:20: SCLDEL[3:0]: Data setup time
> +  - bit 19:16: SDADEL[3:0]: Data hold time
> +  - bit 15:8:  SCLH[7:0]: SCL high period
> +  - bit 7:0:   SCLL[7:0]: SCL low period
>  
>  Example :
>  
> -- 
> 1.9.1
> 
