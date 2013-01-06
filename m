From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via i2c_smbus_write_byte_data
Date: Sun, 6 Jan 2013 19:11:26 +0100
Message-ID: <CAH9NwWfL9-RVRprmY9p4b+PqmUQNukL9J2Ai6xNF+nL2OmOM5Q@mail.gmail.com>
References: <1355933229-25865-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355933229-25865-1-git-send-email-christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Christian Gmeiner <c.gmeiner-qzos7lGCgFkk+I/owrrOrA@public.gmane.org>
Cc: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ping
--
Christian Gmeiner, MSc


2012/12/19 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
> bus driver. This bus driver does not support
> I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
> to be able to write the eeprom. This patch adds support for
> I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
> It is quite slow, but it works.
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2baeec5..723b411 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -56,6 +56,7 @@ struct at24_data {
>         struct at24_platform_data chip;
>         struct memory_accessor macc;
>         int use_smbus;
> +       int use_smbuse_write;
>
>         /*
>          * Lock protects against activities from other Linux tasks,
> @@ -324,7 +325,7 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
>  {
>         struct i2c_client *client;
>         struct i2c_msg msg;
> -       ssize_t status;
> +       ssize_t status = 0;
>         unsigned long timeout, write_time;
>         unsigned next_page;
>
> @@ -365,9 +366,18 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
>         timeout = jiffies + msecs_to_jiffies(write_timeout);
>         do {
>                 write_time = jiffies;
> -               if (at24->use_smbus) {
> -                       status = i2c_smbus_write_i2c_block_data(client,
> -                                       offset, count, buf);
> +               if (at24->use_smbuse_write) {
> +                       switch (at24->use_smbuse_write) {
> +                       case I2C_SMBUS_I2C_BLOCK_DATA:
> +                               status = i2c_smbus_write_i2c_block_data(client,
> +                                               offset, count, buf);
> +                               break;
> +                       case I2C_SMBUS_BYTE_DATA:
> +                               status = i2c_smbus_write_byte_data(client,
> +                                               offset, buf[0]);
> +                               break;
> +                       }
> +
>                         if (status == 0)
>                                 status = count;
>                 } else {
> @@ -484,6 +494,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         struct at24_platform_data chip;
>         bool writable;
>         int use_smbus = 0;
> +       int use_smbus_write = 0;
>         struct at24_data *at24;
>         int err;
>         unsigned i, num_addresses;
> @@ -547,6 +558,18 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 }
>         }
>
> +       /* Use I2C operations unless we're stuck with SMBus extensions. */
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +               if (!i2c_check_functionality(client->adapter,
> +                               I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +                       use_smbus_write = I2C_SMBUS_I2C_BLOCK_DATA;
> +               } else if (i2c_check_functionality(client->adapter,
> +                               I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> +                       use_smbus_write = I2C_SMBUS_BYTE_DATA;
> +                       chip.page_size = 1;
> +               }
> +       }
> +
>         if (chip.flags & AT24_FLAG_TAKE8ADDR)
>                 num_addresses = 8;
>         else
> @@ -562,6 +585,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>
>         mutex_init(&at24->lock);
>         at24->use_smbus = use_smbus;
> +       at24->use_smbuse_write = use_smbus_write;
>         at24->chip = chip;
>         at24->num_addresses = num_addresses;
>
> @@ -579,8 +603,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>
>         writable = !(chip.flags & AT24_FLAG_READONLY);
>         if (writable) {
> -               if (!use_smbus || i2c_check_functionality(client->adapter,
> -                               I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +               if (!use_smbus || use_smbus_write) {
>
>                         unsigned write_max = chip.page_size;
>
> --
> 1.7.12.2.421.g261b511
>
