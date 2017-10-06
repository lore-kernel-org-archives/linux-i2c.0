From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v4 5/5] ARM: dts: stm32: Add I2C1 support for STM32F746
 eval board
Date: Fri, 6 Oct 2017 15:00:40 +0200
Message-ID: <965ffea2-a90a-411f-17c2-08786985ac68@st.com>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-6-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505399319-14782-6-git-send-email-pierre-yves.mordret@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 09/14/2017 04:28 PM, Pierre-Yves MORDRET wrote:
> This patch adds I2C1 support for STM32F746 eval board
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>      v4:
>      v3:
>          * None
> 
>      v2:
>          * Add SCL Rising/Falling time for eval board
> ---
> ---
>   arch/arm/boot/dts/stm32746g-eval.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
> index 69a9579..9288c7a 100644
> --- a/arch/arm/boot/dts/stm32746g-eval.dts
> +++ b/arch/arm/boot/dts/stm32746g-eval.dts

Applied on stm32-dt-for-v4.15 branch.

Thanks
Alex

> @@ -102,3 +102,11 @@
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> +
> +&i2c1 {
> +	pinctrl-0 = <&i2c1_pins_b>;
> +	pinctrl-names = "default";
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +};
> 
