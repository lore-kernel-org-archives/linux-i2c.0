From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/3] i2c: use void pointers for supplying data for
 reads and writes
Date: Mon, 18 Nov 2019 08:43:49 +0100
Message-ID: <20191118074349.ags3c4tmvapguqcp@pengutronix.de>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112203132.163306-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.orgi, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>linux-iio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Dmitry,

On Tue, Nov 12, 2019 at 12:31:30PM -0800, Dmitry Torokhov wrote:
> There is no need to force users of i2c_master_send()/i2c_master_recv()
> and other i2c read/write bulk data API to cast everything into u8 pointers.
> While everything can be considered byte stream, the drivers are usually
> work with more structured data.
> 
> Let's switch the APIs to accept [const] void pointers to cut amount of
> casting needed.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Can you give an example where you save some casts? Given that i2c is a
byte oriented protocol (as opposed to for example spi) I think it's a
good idea to expose this in the API.

> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e7..48ed76a0e83d4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c

This change isn't motivated in the commit log. Is this here by mistake?

> @@ -182,9 +182,9 @@ struct max1363_state {
>  	struct regulator		*vref;
>  	u32				vref_uv;
>  	int				(*send)(const struct i2c_client *client,
> -						const char *buf, int count);
> +						const void *buf, int count);
>  	int				(*recv)(const struct i2c_client *client,
> -						char *buf, int count);
> +						void *buf, int count);
>  };
>  
>  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> @@ -310,27 +310,29 @@ static const struct max1363_mode
>  	return NULL;
>  }
>  
> -static int max1363_smbus_send(const struct i2c_client *client, const char *buf,
> +static int max1363_smbus_send(const struct i2c_client *client, const void *buf,
>  		int count)
>  {
> +	const u8 *data = buf;
>  	int i, err;
>  
>  	for (i = err = 0; err == 0 && i < count; ++i)
> -		err = i2c_smbus_write_byte(client, buf[i]);
> +		err = i2c_smbus_write_byte(client, data[i]);

Isn't this hunk an indicator that keeping char (or u8) as type of the
members of buf is a good idea?
 
>  	return err ? err : count;
>  }
>  
> -static int max1363_smbus_recv(const struct i2c_client *client, char *buf,
> +static int max1363_smbus_recv(const struct i2c_client *client, void *buf,
>  		int count)
>  {
> +	u8 *data = buf;
>  	int i, ret;
>  
>  	for (i = 0; i < count; ++i) {
>  		ret = i2c_smbus_read_byte(client);
>  		if (ret < 0)
>  			return ret;
> -		buf[i] = ret;
> +		data[i] = ret;
>  	}
>  
>  	return count;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
