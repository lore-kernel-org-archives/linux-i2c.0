From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 08/24] iio: imu: inv_mpu6050: convert to use an
 explicit i2c mux core
Date: Sun, 3 Apr 2016 11:51:00 +0100
Message-ID: <5700F594.9090105@kernel.org>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
 <1459673574-11440-9-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459673574-11440-9-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt Ranostay <matt.ranostay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/04/16 09:52, Peter Rosin wrote:
> From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> 
> Allocate an explicit i2c mux core to handle parent and child adapters
> etc. Update the select/deselect ops to be in terms of the i2c mux core
> instead of the child adapter.
> 
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
I'm mostly fine with this (though one unrelated change seems to have snuck
in).  However, I'm not set up to test it - hence other than fixing the change
you can have my ack, but ideal would be a tested by from someone with
relevant hardware...  However, it looks to be a fairly mechanical change so
if no one is currently setup to test it, then don't let it hold up the
series too long!

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  1 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 32 +++++++++++++-----------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 ++-
>  4 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 2771106fd650..f62b8bd9ad7e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -183,7 +183,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
>  			} else
>  				return 0; /* no secondary addr, which is OK */
>  		}
> -		st->mux_client = i2c_new_device(st->mux_adapter, &info);
> +		st->mux_client = i2c_new_device(st->muxc->adapter[0], &info);
>  		if (!st->mux_client)
>  			return -ENODEV;
>  	}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index d192953e9a38..0c2bded2b5b7 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -23,7 +23,6 @@
>  #include <linux/kfifo.h>
>  #include <linux/spinlock.h>
>  #include <linux/iio/iio.h>
> -#include <linux/i2c-mux.h>
>  #include <linux/acpi.h>
>  #include "inv_mpu_iio.h"
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index f581256d9d4c..0d429d788106 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -15,7 +15,6 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-mux.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include "inv_mpu_iio.h"
> @@ -52,10 +51,9 @@ static int inv_mpu6050_write_reg_unlocked(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
> -				     u32 chan_id)
> +static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  {
> -	struct i2c_client *client = mux_priv;
> +	struct i2c_client *client = i2c_mux_priv(muxc);
>  	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int ret = 0;
> @@ -84,10 +82,9 @@ write_error:
>  	return ret;
>  }
>  
> -static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
> -				       void *mux_priv, u32 chan_id)
> +static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  {
> -	struct i2c_client *client = mux_priv;
> +	struct i2c_client *client = i2c_mux_priv(muxc);
>  	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
> @@ -136,16 +133,15 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		return result;
>  
>  	st = iio_priv(dev_get_drvdata(&client->dev));
> -	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
> -					      &client->dev,
> -					      client,
> -					      0, 0, 0,
> -					      inv_mpu6050_select_bypass,
> -					      inv_mpu6050_deselect_bypass);
> -	if (!st->mux_adapter) {
> -		result = -ENODEV;
> +	st->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0, 0,
> +				       0, 0, 0,
> +				       inv_mpu6050_select_bypass,
> +				       inv_mpu6050_deselect_bypass);
> +	if (IS_ERR(st->muxc)) {
> +		result = PTR_ERR(st->muxc);
>  		goto out_unreg_device;
>  	}
> +	st->muxc->priv = client;
>  
>  	result = inv_mpu_acpi_create_mux_client(client);
>  	if (result)
> @@ -154,7 +150,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	return 0;
>  
>  out_del_mux:
> -	i2c_del_mux_adapter(st->mux_adapter);
> +	i2c_mux_del_adapters(st->muxc);
>  out_unreg_device:
>  	inv_mpu_core_remove(&client->dev);
>  	return result;
> @@ -162,11 +158,11 @@ out_unreg_device:
>  
>  static int inv_mpu_remove(struct i2c_client *client)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
Why this change?  Seems unrelated.
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	inv_mpu_acpi_delete_mux_client(client);
> -	i2c_del_mux_adapter(st->mux_adapter);
> +	i2c_mux_del_adapters(st->muxc);
>  
>  	return inv_mpu_core_remove(&client->dev);
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index e302a49703bf..bb3cef6d7059 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -11,6 +11,7 @@
>  * GNU General Public License for more details.
>  */
>  #include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
>  #include <linux/kfifo.h>
>  #include <linux/spinlock.h>
>  #include <linux/iio/iio.h>
> @@ -127,7 +128,7 @@ struct inv_mpu6050_state {
>  	const struct inv_mpu6050_hw *hw;
>  	enum   inv_devices chip_type;
>  	spinlock_t time_stamp_lock;
> -	struct i2c_adapter *mux_adapter;
> +	struct i2c_mux_core *muxc;
>  	struct i2c_client *mux_client;
>  	unsigned int powerup_count;
>  	struct inv_mpu6050_platform_data plat_data;
> 
