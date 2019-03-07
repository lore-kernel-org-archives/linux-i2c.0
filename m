From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date: Thu, 7 Mar 2019 09:29:57 +0100
Message-ID: <3a2ceff7-5634-6305-5d54-356af524de7a@st.com>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 3/6/19 4:12 PM, Bich HEMON wrote:
> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> 
> It conforms with Reference Manual I2C timing section.
> 
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 13e1213..4284fc9 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -432,7 +432,7 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
>  		 STM32F7_I2C_ANALOG_FILTER_DELAY_MAX : 0);
>  	dnf_delay = setup->dnf * i2cclk;
>  
> -	sdadel_min = setup->fall_time - i2c_specs[setup->speed].hddat_min -
> +	sdadel_min = i2c_specs[setup->speed].hddat_min + setup->fall_time -
>  		af_delay_min - (setup->dnf + 3) * i2cclk;
>  
>  	sdadel_max = i2c_specs[setup->speed].vddat_max - setup->rise_time -
> 
