From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] iio: light: cm36651: convert to
 i2c_new_dummy_device
Date: Sat, 27 Jul 2019 20:56:40 +0100
Message-ID: <20190727205640.2686db5f@archlinux>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
        <20190722172613.3890-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172613.3890-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 22 Jul 2019 19:26:11 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi,

Hmm. I've been rather busy recently so the IIO tree is based before this
got introduced.

Meh, it's early in the cycle so I'm just going to rebase and hope it
doesn't cause anyone too much pain.  I suspect the number of people
tracking my togreg branch is very small to 0.

Applied to a rebase version of the togreg branch of iio.git and
pushed out as testing for the autobuilders to poke at it.

Thanks,

Jonathan


> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/iio/light/cm36651.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 7702c2bcbcfa..1019d625adb1 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -646,18 +646,18 @@ static int cm36651_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  
>  	cm36651->client = client;
> -	cm36651->ps_client = i2c_new_dummy(client->adapter,
> +	cm36651->ps_client = i2c_new_dummy_device(client->adapter,
>  						     CM36651_I2C_ADDR_PS);
> -	if (!cm36651->ps_client) {
> +	if (IS_ERR(cm36651->ps_client)) {
>  		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
> -		ret = -ENODEV;
> +		ret = PTR_ERR(cm36651->ps_client);
>  		goto error_disable_reg;
>  	}
>  
> -	cm36651->ara_client = i2c_new_dummy(client->adapter, CM36651_ARA);
> -	if (!cm36651->ara_client) {
> +	cm36651->ara_client = i2c_new_dummy_device(client->adapter, CM36651_ARA);
> +	if (IS_ERR(cm36651->ara_client)) {
>  		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
> -		ret = -ENODEV;
> +		ret = PTR_ERR(cm36651->ara_client);
>  		goto error_i2c_unregister_ps;
>  	}
>  
