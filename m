From: Max Staudt <max@enpas.org>
Subject: Re: [RFC PATCH 02/12] i2c: icy: convert to i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:33:30 +0100
Message-ID: <6c979da5-d913-e2d9-9766-478a50d905f7@enpas.org>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 11/06/2019 10:50 AM, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-icy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-icy.c b/drivers/i2c/busses/i2c-icy.c
> index 8382eb64b424..07baa4d8de39 100644
> --- a/drivers/i2c/busses/i2c-icy.c
> +++ b/drivers/i2c/busses/i2c-icy.c
> @@ -188,10 +188,10 @@ static int icy_probe(struct zorro_dev *z,
>  		ltc2990_info.fwnode = new_fwnode;
>  
>  		i2c->ltc2990_client =
> -			i2c_new_probed_device(&i2c->adapter,
> -					      &ltc2990_info,
> -					      icy_ltc2990_addresses,
> -					      NULL);
> +			i2c_new_scanned_device(&i2c->adapter,
> +					       &ltc2990_info,
> +					       icy_ltc2990_addresses,
> +					       NULL);

Looks good, thank you for patching this!

i2c_unregister_device() checks the pointer using IS_ERR_OR_NULL(), so the simple logic in i2c-icy (where the pointer is not checked on i2c_new_scanned_device()) still works.


Acked-by: Max Staudt <max@enpas.org>
