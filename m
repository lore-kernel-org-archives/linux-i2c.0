From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: improve loopback in timing algorithm
Date: Thu, 7 Mar 2019 11:22:25 +0100
Message-ID: <04076973-8512-e4bc-21d9-28f04006c7f6@st.com>
References: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
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
> This avoids useless loops inside the I2C timing algorithm.
> Actually, we support only one possible solution per prescaler value.
> So after finding a solution with a prescaler, the algorithm can
> switch directly to the next prescaler value.
> 
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 4284fc9..48337be 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -476,8 +476,12 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
>  
>  					list_add_tail(&v->node,
>  						      &solutions);
> +					break;
>  				}
>  			}
> +
> +			if (p_prev == p)
> +				break;
>  		}
>  	}
>  
> 
