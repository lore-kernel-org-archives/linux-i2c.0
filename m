From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 03/34] iio: light: bh1780: simplify getting the adapter
 of a client
Date: Sat, 8 Jun 2019 12:39:45 +0100
Message-ID: <20190608123945.4bef51e0@archlinux>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
        <20190608105619.593-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  8 Jun 2019 12:55:42 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/iio/light/bh1780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index 340d64d0ac59..a8361006dcd9 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -146,7 +146,7 @@ static int bh1780_probe(struct i2c_client *client,
>  {
>  	int ret;
>  	struct bh1780_data *bh1780;
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct iio_dev *indio_dev;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
