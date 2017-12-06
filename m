From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/2] eeprom: at24: use a common prefix for all symbols
 in at24.c
Date: Wed, 6 Dec 2017 14:40:00 +0100
Message-ID: <5cffa160-7371-c71a-d3b7-ba01edb408e3@axentia.se>
References: <20171206130131.13438-1-brgl@bgdev.pl>
 <20171206130131.13438-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0094.outbound.protection.outlook.com ([104.47.1.94]:22400
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751453AbdLFNkF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 6 Dec 2017 08:40:05 -0500
In-Reply-To: <20171206130131.13438-3-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi!

Some nits...

On 2017-12-06 14:01, Bartosz Golaszewski wrote:
> There are a couple symbols defined in the driver source file which are
> missing the at24_ prefix. This patch fixes that.
> 
> For module params: use module_param_named() in order not to break the
> userspace.

I'd write that as "...in order to not break userspace"

> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2426f2c111c7..dd0903c7df39 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -93,17 +93,17 @@ struct at24_data {
>   *
>   * This value is forced to be a power of two so that writes align on pages.
>   */
> -static unsigned int io_limit = 128;
> -module_param(io_limit, uint, 0000);
> -MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
> +static unsigned int at24_io_limit = 128;
> +module_param_named(io_limit, at24_io_limit, uint, 0000);
> +MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)");
>  
>  /*
>   * Specs often allow 5 msec for a page write, sometimes 20 msec;
>   * it's important to recover from write timeouts.
>   */
> -static unsigned int write_timeout = 25;
> -module_param(write_timeout, uint, 0000);
> -MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
> +static unsigned int at24_write_timeout = 25;
> +module_param_named(write_timeout, at24_write_timeout, uint, 0000);
> +MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
>  
>  #define AT24_SIZE_BYTELEN 5
>  #define AT24_SIZE_FLAGS 8
> @@ -126,8 +126,9 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>   * iteration of processing the request. Both should be unsigned integers
>   * holding at least 32 bits.
>   */
> -#define loop_until_timeout(tout, op_time)				\
> -	for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
> +#define at24_tool_until_timeout(tout, op_time)				\

s/tool/loop/

.oO(hmm, is that a figure skating jump? naaah, guess not...)

Cheers,
peda

> +	for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),	\
> +	     op_time = 0;						\
>  	     op_time ? time_before(op_time, tout) : true;		\
>  	     usleep_range(1000, 1500), op_time = jiffies)
>  
> @@ -290,13 +291,13 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>  	regmap = at24_client->regmap;
>  	client = at24_client->client;
>  
> -	if (count > io_limit)
> -		count = io_limit;
> +	if (count > at24_io_limit)
> +		count = at24_io_limit;
>  
>  	/* adjust offset for mac and serial read ops */
>  	offset += at24->offset_adj;
>  
> -	loop_until_timeout(timeout, read_time) {
> +	at24_tool_until_timeout(timeout, read_time) {
>  		ret = regmap_bulk_read(regmap, offset, buf, count);
>  		dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>  			count, offset, ret, jiffies);
> @@ -347,7 +348,7 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
>  	client = at24_client->client;
>  	count = at24_adjust_write_count(at24, offset, count);
>  
> -	loop_until_timeout(timeout, write_time) {
> +	at24_tool_until_timeout(timeout, write_time) {
>  		ret = regmap_bulk_write(regmap, offset, buf, count);
>  		dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
>  			count, offset, ret, jiffies);
> @@ -613,7 +614,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	writable = !(chip.flags & AT24_FLAG_READONLY);
>  	if (writable) {
> -		at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
> +		at24->write_max = min_t(unsigned int,
> +					chip.page_size, at24_io_limit);
>  		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
>  		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
>  			at24->write_max = I2C_SMBUS_BLOCK_MAX;
> @@ -728,12 +730,12 @@ static struct i2c_driver at24_driver = {
>  
>  static int __init at24_init(void)
>  {
> -	if (!io_limit) {
> -		pr_err("at24: io_limit must not be 0!\n");
> +	if (!at24_io_limit) {
> +		pr_err("at24: at24_io_limit must not be 0!\n");
>  		return -EINVAL;
>  	}
>  
> -	io_limit = rounddown_pow_of_two(io_limit);
> +	at24_io_limit = rounddown_pow_of_two(at24_io_limit);
>  	return i2c_add_driver(&at24_driver);
>  }
>  module_init(at24_init);
> 
