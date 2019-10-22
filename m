From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: remove warning when compiling with
 W=1
Date: Tue, 22 Oct 2019 15:41:10 +0200
Message-ID: <c10c0652-3f9e-ea5c-98f2-206af86b0fe4@st.com>
References: <1571145118-3522-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571145118-3522-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Hello

Looks good

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thx
Regards

On 10/15/19 3:11 PM, Alain Volmat wrote:
> Remove the following warning:
> 
> drivers/i2c/busses/i2c-stm32f7.c:315:
> warning: cannot understand function prototype:
> 'struct stm32f7_i2c_spec i2c_specs[] =
> 
> Replace a comment starting with /** by simply /* to avoid having
> it interpreted as a kernel-doc comment.
> 
> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
> Changes in v2: update commit description
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index d36cf08461f7..7aa4a47792a7 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -305,7 +305,7 @@ struct stm32f7_i2c_dev {
>  	struct regmap *regmap;
>  };
>  
> -/**
> +/*
>   * All these values are coming from I2C Specification, Version 6.0, 4th of
>   * April 2014.
>   *
> 
