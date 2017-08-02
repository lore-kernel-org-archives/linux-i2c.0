From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] i2c: mux: pinctrl: drop the idle_state member
Date: Wed, 2 Aug 2017 13:06:43 -0600
Message-ID: <15488723-e0ef-62b3-e62f-e74d12d8328d@wwwdotorg.org>
References: <20170802072728.24586-1-peda@axentia.se>
 <20170802072728.24586-3-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802072728.24586-3-peda@axentia.se>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08/02/2017 01:27 AM, Peter Rosin wrote:
> The information is available elsewhere.

> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c

>   static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
>   {
> +	return i2c_mux_pinctrl_select(muxc, muxc->num_adapters);
>   }

> @@ -166,7 +162,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)

>   	/* Do not add any adapter for the idle state (if it's there at all). */
> -	for (i = 0; i < num_names - !!mux->state_idle; i++) {
> +	for (i = 0; i < num_names - !!muxc->deselect; i++) {

I think that "num_names - !!muxc->deselect" could just be 
muxc->num_adapters? Otherwise,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
