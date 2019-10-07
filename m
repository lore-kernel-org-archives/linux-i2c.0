From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH] i2c: i2c-stm32f7: remove warning when compiling with W=1
Date: Mon, 7 Oct 2019 09:59:22 +0200
Message-ID: <a5093a73-ba62-ae37-10dc-3434c9da40f7@st.com>
References: <1570200954-17919-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570200954-17919-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de
Cc: alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Hi Alain

Fixes tag is missing in your patch.
[ i.e ==> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver") ]

Nonetheless patch only consists in removing a comment character ?

Thanks

On 10/4/19 4:55 PM, Alain Volmat wrote:
> Remove the following warning:
> 
> drivers/i2c/busses/i2c-stm32f7.c:315:
> warning: cannot understand function prototype:
> 'struct stm32f7_i2c_spec i2c_specs[] =
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index d36cf08..7aa4a47 100644
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
