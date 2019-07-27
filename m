From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] iio: light: veml6070: convert to
 i2c_new_dummy_device
Date: Sat, 27 Jul 2019 20:58:11 +0100
Message-ID: <20190727205811.7beba748@archlinux>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
        <20190722172613.3890-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172613.3890-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 22 Jul 2019 19:26:12 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to do something random with it.

Thanks,

Jonathan

> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/iio/light/veml6070.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index a3138e1b5803..0be553ad5989 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -158,10 +158,10 @@ static int veml6070_probe(struct i2c_client *client,
>  	indio_dev->name = VEML6070_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	data->client2 = i2c_new_dummy(client->adapter, VEML6070_ADDR_DATA_LSB);
> -	if (!data->client2) {
> +	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
> +	if (IS_ERR(data->client2)) {
>  		dev_err(&client->dev, "i2c device for second chip address failed\n");
> -		return -ENODEV;
> +		return PTR_ERR(data->client2);
>  	}
>  
>  	data->config = VEML6070_IT_10 | VEML6070_COMMAND_RSRVD |
