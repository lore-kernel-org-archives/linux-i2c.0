From: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 20/24] iio: imu: inv_mpu6050: change the i2c gate to be mux-locked
Date: Mon, 18 Apr 2016 10:37:44 +0300
Message-ID: <CAEnQRZBEUC4DUmZci0MrXWzEBFXDR0bLN_taDuWR+mt6LMe-5w@mail.gmail.com>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
	<1459673574-11440-21-git-send-email-peda@lysator.liu.se>
	<5700F648.1010804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5700F648.1010804-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus@int>
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 3, 2016 at 1:54 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 03/04/16 09:52, Peter Rosin wrote:
>> From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>>
>> The root i2c adapter lock is then no longer held by the i2c mux during
>> accesses behind the i2c gate, and such accesses need to take that lock
>> just like any other ordinary i2c accesses do.
>>
>> So, declare the i2c gate mux-locked, and zap the code that makes the
>> unlocked i2c accesses and just use ordinary regmap_write accesses.
>>
>> This also happens to fix the deadlock described in
>> http://patchwork.ozlabs.org/patch/584776/ authored by
>> Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and submitted by
>> Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> ----------8<----------
>> iio: imu: inv_mpu6050: Fix deadlock between i2c adapter lock and mpu lock
>>
>> This deadlock occurs if the accel/gyro and the sensor on the auxiliary
>> I2C (in my setup it's an ak8975) are working at the same time.
>>
>> Scenario:
>>
>>       T1                                      T2
>>      ====                                    ====
>> inv_mpu6050_read_fifo                  aux sensor op (eg. ak8975_read_raw)
>>         |                                     |
>> mutex_lock(&indio_dev->mlock)           i2c_transfer
>>         |                                     |
>> i2c transaction                         i2c adapter lock
>>         |                                     |
>> i2c adapter lock                        i2c_mux_master_xfer
>>                                               |
>>                                         inv_mpu6050_select_bypass
>>                                               |
>>                                         mutex_lock(&indio_dev->mlock)
>>
>> When we operate on an mpu sensor the order of locking is mpu lock
>> followed by the i2c adapter lock. However, when we operate the auxiliary
>> sensor the order of locking is the other way around.
>>
>> ...
>> ----------8<----------
>>
>> The reason this patch fixes the deadlock is that T2 does not grab the
>> i2c adapter lock until the very end (and grabs the newfangled i2c mux
>> lock where it previously grabbed the i2c adapter lock).
>>
>> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> This one obviously wants a ack from Adriana or Daniel in addition to mine.
> I'm more than happy for these to go through the i2c tree btw.
>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


>> ---
>>  Documentation/i2c/i2c-topology            |  2 +-
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 56 +++++++------------------------
>>  2 files changed, 13 insertions(+), 45 deletions(-)
>>
>> diff --git a/Documentation/i2c/i2c-topology b/Documentation/i2c/i2c-topology
>> index 7a10edd0874f..346623a80bd1 100644
>> --- a/Documentation/i2c/i2c-topology
>> +++ b/Documentation/i2c/i2c-topology
>> @@ -50,7 +50,7 @@ i2c-mux-pinctrl           Normally parent-locked, mux-locked iff
>>  i2c-mux-reg               Parent-locked
>>
>>  In drivers/iio/
>> -imu/inv_mpu6050/          Parent-locked
>> +imu/inv_mpu6050/          Mux-locked
>>
>>  In drivers/media/
>>  dvb-frontends/m88ds3103   Parent-locked
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> index 0d429d788106..71ad31a275c9 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>> @@ -24,45 +24,16 @@ static const struct regmap_config inv_mpu_regmap_config = {
>>       .val_bits = 8,
>>  };
>>
>> -/*
>> - * The i2c read/write needs to happen in unlocked mode. As the parent
>> - * adapter is common. If we use locked versions, it will fail as
>> - * the mux adapter will lock the parent i2c adapter, while calling
>> - * select/deselect functions.
>> - */
>> -static int inv_mpu6050_write_reg_unlocked(struct i2c_client *client,
>> -                                       u8 reg, u8 d)
>> -{
>> -     int ret;
>> -     u8 buf[2] = {reg, d};
>> -     struct i2c_msg msg[1] = {
>> -             {
>> -                     .addr = client->addr,
>> -                     .flags = 0,
>> -                     .len = sizeof(buf),
>> -                     .buf = buf,
>> -             }
>> -     };
>> -
>> -     ret = __i2c_transfer(client->adapter, msg, 1);
>> -     if (ret != 1)
>> -             return ret;
>> -
>> -     return 0;
>> -}
>> -
>>  static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>>  {
>> -     struct i2c_client *client = i2c_mux_priv(muxc);
>> -     struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
>> +     struct iio_dev *indio_dev = i2c_mux_priv(muxc);
>>       struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>       int ret = 0;
>>
>>       /* Use the same mutex which was used everywhere to protect power-op */
>>       mutex_lock(&indio_dev->mlock);
>>       if (!st->powerup_count) {
>> -             ret = inv_mpu6050_write_reg_unlocked(client,
>> -                                                  st->reg->pwr_mgmt_1, 0);
>> +             ret = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
>>               if (ret)
>>                       goto write_error;
>>
>> @@ -71,10 +42,9 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>>       }
>>       if (!ret) {
>>               st->powerup_count++;
>> -             ret = inv_mpu6050_write_reg_unlocked(client,
>> -                                                  st->reg->int_pin_cfg,
>> -                                                  INV_MPU6050_INT_PIN_CFG |
>> -                                                  INV_MPU6050_BIT_BYPASS_EN);
>> +             ret = regmap_write(st->map, st->reg->int_pin_cfg,
>> +                                INV_MPU6050_INT_PIN_CFG |
>> +                                INV_MPU6050_BIT_BYPASS_EN);
>>       }
>>  write_error:
>>       mutex_unlock(&indio_dev->mlock);
>> @@ -84,18 +54,16 @@ write_error:
>>
>>  static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>>  {
>> -     struct i2c_client *client = i2c_mux_priv(muxc);
>> -     struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
>> +     struct iio_dev *indio_dev = i2c_mux_priv(muxc);
>>       struct inv_mpu6050_state *st = iio_priv(indio_dev);
>>
>>       mutex_lock(&indio_dev->mlock);
>>       /* It doesn't really mattter, if any of the calls fails */
>> -     inv_mpu6050_write_reg_unlocked(client, st->reg->int_pin_cfg,
>> -                                    INV_MPU6050_INT_PIN_CFG);
>> +     regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
>>       st->powerup_count--;
>>       if (!st->powerup_count)
>> -             inv_mpu6050_write_reg_unlocked(client, st->reg->pwr_mgmt_1,
>> -                                            INV_MPU6050_BIT_SLEEP);
>> +             regmap_write(st->map, st->reg->pwr_mgmt_1,
>> +                          INV_MPU6050_BIT_SLEEP);
>>       mutex_unlock(&indio_dev->mlock);
>>
>>       return 0;
>> @@ -133,15 +101,15 @@ static int inv_mpu_probe(struct i2c_client *client,
>>               return result;
>>
>>       st = iio_priv(dev_get_drvdata(&client->dev));
>> -     st->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0, 0,
>> -                                    0, 0, 0,
>> +     st->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0,
>> +                                    I2C_MUX_LOCKED, 0, 0, 0,
>>                                      inv_mpu6050_select_bypass,
>>                                      inv_mpu6050_deselect_bypass);
>>       if (IS_ERR(st->muxc)) {
>>               result = PTR_ERR(st->muxc);
>>               goto out_unreg_device;
>>       }
>> -     st->muxc->priv = client;
>> +     st->muxc->priv = dev_get_drvdata(&client->dev);
>>
>>       result = inv_mpu_acpi_create_mux_client(client);
>>       if (result)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
