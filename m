From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 2/2] dt-bindings: i2c-stm32: update optional properties
 for stm32h7/stm32mp1
Date: Thu, 21 Mar 2019 09:28:52 +0100
Message-ID: <678d91ed-ffda-878e-feea-40a2f3e32295@st.com>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
 <1551885100-22207-3-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551885100-22207-3-git-send-email-bich.hemon@st.com>
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
> Add STM32H7 and STM32MP1 in the list of compatible socs for each
> optional property.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> index 7d054f1..f334738 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
> @@ -19,18 +19,19 @@ Optional properties:
>    the default 100 kHz frequency will be used.
>    For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
>    100000 and 400000.
> -  For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
> -  possible values are 100000, 400000 and 1000000.
> -- i2c-scl-rising-time-ns: Only for STM32F7, I2C SCL Rising time for the board
> -  (default: 25)
> -- i2c-scl-falling-time-ns: Only for STM32F7, I2C SCL Falling time for the board
> -  (default: 10)
> +  For STM32F7, STM32H7 and STM32MP1 SoCs, Standard-mode, Fast-mode and Fast-mode
> +  Plus are supported, possible values are 100000, 400000 and 1000000.
> +- i2c-scl-rising-time-ns: I2C SCL Rising time for the board (default: 25)
> +  For STM32F7, STM32H7 and STM32MP1 only.
> +- i2c-scl-falling-time-ns: I2C SCL Falling time for the board (default: 10)
> +  For STM32F7, STM32H7 and STM32MP1 only.
>    I2C Timings are derived from these 2 values
> -- st,syscfg-fmp: Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
> -  whether Fast Mode Plus speed is selected by slave.
> +- st,syscfg-fmp: Use to set Fast Mode Plus bit within SYSCFG when Fast Mode
> +  Plus speed is selected by slave.
>  	1st cell: phandle to syscfg
>  	2nd cell: register offset within SYSCFG
>  	3rd cell: register bitmask for FMP bit
> +  For STM32F7, STM32H7 and STM32MP1 only.
>  
>  Example:
>  
> 
