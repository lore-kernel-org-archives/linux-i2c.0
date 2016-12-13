From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v6 4/5] ARM: dts: stm32: Add I2C1 support for STM32429
 eval board
Date: Tue, 13 Dec 2016 11:02:28 +0100
Message-ID: <a5a701ed-4073-87f6-3ff5-923445f97014@st.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-5-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481559342-6106-5-git-send-email-cedric.madianga@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>, wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Cedric,

On 12/12/2016 05:15 PM, M'boumba Cedric Madianga wrote:
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

Can you please add a commit message.

> ---
>  arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index afb90bc..74e0045 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -141,3 +141,9 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&i2c1 {
> +	pinctrl-0 = <&i2c1_pins_b>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
>
