From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: i2c-stm32: remove extra spaces
Date: Thu, 21 Mar 2019 09:28:28 +0100
Message-ID: <7ed05148-7719-0fed-989f-21428b9a7d88@st.com>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
 <1551885100-22207-2-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551885100-22207-2-git-send-email-bich.hemon@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bich HEMON <bich.hemon@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

On 3/6/19 4:11 PM, Bich HEMON wrote:
> Remove extra spaces before colons.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 26 +++++++++++-----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> index 69240e1..7d054f1 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> @@ -1,11 +1,11 @@
>  * I2C controller embedded in STMicroelectronics STM32 I2C platform
>  
> -Required properties :
> -- compatible : Must be one of the following
> +Required properties:
> +- compatible: Must be one of the following
>    - "st,stm32f4-i2c"
>    - "st,stm32f7-i2c"
> -- reg : Offset and length of the register set for the device
> -- interrupts : Must contain the interrupt id for I2C event and then the
> +- reg: Offset and length of the register set for the device
> +- interrupts: Must contain the interrupt id for I2C event and then the
>    interrupt id for I2C error.
>  - resets: Must contain the phandle to the reset controller.
>  - clocks: Must contain the input clock of the I2C instance.
> @@ -14,25 +14,25 @@ Required properties :
>  - #address-cells = <1>;
>  - #size-cells = <0>;
>  
> -Optional properties :
> -- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
> +Optional properties:
> +- clock-frequency: Desired I2C bus clock frequency in Hz. If not specified,
>    the default 100 kHz frequency will be used.
>    For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
>    100000 and 400000.
>    For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
>    possible values are 100000, 400000 and 1000000.
> -- i2c-scl-rising-time-ns : Only for STM32F7, I2C SCL Rising time for the board
> +- i2c-scl-rising-time-ns: Only for STM32F7, I2C SCL Rising time for the board
>    (default: 25)
> -- i2c-scl-falling-time-ns : Only for STM32F7, I2C SCL Falling time for the board
> +- i2c-scl-falling-time-ns: Only for STM32F7, I2C SCL Falling time for the board
>    (default: 10)
>    I2C Timings are derived from these 2 values
> -- st,syscfg-fmp:  Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
> +- st,syscfg-fmp: Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
>    whether Fast Mode Plus speed is selected by slave.
> -	1st cell : phandle to syscfg
> -	2nd cell : register offset within SYSCFG
> -	3rd cell : register bitmask for FMP bit
> +	1st cell: phandle to syscfg
> +	2nd cell: register offset within SYSCFG
> +	3rd cell: register bitmask for FMP bit
>  
> -Example :
> +Example:
>  
>  	i2c@40005400 {
>  		compatible = "st,stm32f4-i2c";
> 
