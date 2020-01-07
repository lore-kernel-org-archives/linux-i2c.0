From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 3/5] i2c: highlander: Use proper printk format for iomem
 pointer
Date: Tue, 7 Jan 2020 16:08:17 +0100
Message-ID: <dcfa47af-9c7f-4c57-b178-62611c8c21bc@lucaceresoli.net>
References: <20191230172751.17985-1-krzk@kernel.org>
 <20191230172751.17985-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191230172751.17985-3-krzk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 30/12/19 18:27, Krzysztof Kozlowski wrote:
> iomem pointers should be printed with pointer format to hide the

s/iomem/size_t/ (in the subject too)

The whole commit message needs rewording accordingly.

> actual value and fix warnings when compiling on 64-bit platform (e.g. with
> COMPILE_TEST):
> 
>     drivers/i2c/busses/i2c-highlander.c: In function ‘highlander_i2c_smbus_xfer’:
>     drivers/i2c/busses/i2c-highlander.c:325:22: warning:
>         format ‘%d’ expects argument of type ‘int’,
>         but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/i2c/busses/i2c-highlander.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
> index abfe3094c047..803dad70e2a7 100644
> --- a/drivers/i2c/busses/i2c-highlander.c
> +++ b/drivers/i2c/busses/i2c-highlander.c
> @@ -322,7 +322,7 @@ static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>  		tmp |= (SMMR_MODE0 | SMMR_MODE1);
>  		break;
>  	default:
> -		dev_err(dev->dev, "unsupported xfer size %d\n", dev->buf_len);
> +		dev_err(dev->dev, "unsupported xfer size %zu\n", dev->buf_len);
>  		return -EINVAL;
>  	}
>  
> 

-- 
Luca
