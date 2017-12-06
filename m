From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/2] eeprom: at24: use a common prefix for all symbols
 in at24.c
Date: Wed, 6 Dec 2017 15:29:12 +0100
Message-ID: <CAMRc=MfjGSo0bsmoLJGU_vFyp=E8b6-JJwmS5N5vorDpWhEB-Q@mail.gmail.com>
References: <20171206130131.13438-1-brgl@bgdev.pl> <20171206130131.13438-3-brgl@bgdev.pl>
 <5cffa160-7371-c71a-d3b7-ba01edb408e3@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5cffa160-7371-c71a-d3b7-ba01edb408e3@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-06 14:40 GMT+01:00 Peter Rosin <peda@axentia.se>:
> Hi!
>
> Some nits...
>
> On 2017-12-06 14:01, Bartosz Golaszewski wrote:
>> There are a couple symbols defined in the driver source file which are
>> missing the at24_ prefix. This patch fixes that.
>>
>> For module params: use module_param_named() in order not to break the
>> userspace.
>
> I'd write that as "...in order to not break userspace"
>

I would love to hear an English native speaker's opinion on that. :)

>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
>>  1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 2426f2c111c7..dd0903c7df39 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -93,17 +93,17 @@ struct at24_data {
>>   *
>>   * This value is forced to be a power of two so that writes align on pages.
>>   */
>> -static unsigned int io_limit = 128;
>> -module_param(io_limit, uint, 0000);
>> -MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
>> +static unsigned int at24_io_limit = 128;
>> +module_param_named(io_limit, at24_io_limit, uint, 0000);
>> +MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)");
>>
>>  /*
>>   * Specs often allow 5 msec for a page write, sometimes 20 msec;
>>   * it's important to recover from write timeouts.
>>   */
>> -static unsigned int write_timeout = 25;
>> -module_param(write_timeout, uint, 0000);
>> -MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>> +static unsigned int at24_write_timeout = 25;
>> +module_param_named(write_timeout, at24_write_timeout, uint, 0000);
>> +MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
>>
>>  #define AT24_SIZE_BYTELEN 5
>>  #define AT24_SIZE_FLAGS 8
>> @@ -126,8 +126,9 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>>   * iteration of processing the request. Both should be unsigned integers
>>   * holding at least 32 bits.
>>   */
>> -#define loop_until_timeout(tout, op_time)                            \
>> -     for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
>> +#define at24_tool_until_timeout(tout, op_time)                               \
>
> s/tool/loop/
>

Yep, that's a good idea.

> .oO(hmm, is that a figure skating jump? naaah, guess not...)
>
> Cheers,
> peda
>
>> +     for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
>> +          op_time = 0;                                               \
>>            op_time ? time_before(op_time, tout) : true;               \
>>            usleep_range(1000, 1500), op_time = jiffies)
>>
>> @@ -290,13 +291,13 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>>       regmap = at24_client->regmap;
>>       client = at24_client->client;
>>
>> -     if (count > io_limit)
>> -             count = io_limit;
>> +     if (count > at24_io_limit)
>> +             count = at24_io_limit;
>>
>>       /* adjust offset for mac and serial read ops */
>>       offset += at24->offset_adj;
>>
>> -     loop_until_timeout(timeout, read_time) {
>> +     at24_tool_until_timeout(timeout, read_time) {
>>               ret = regmap_bulk_read(regmap, offset, buf, count);
>>               dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>>                       count, offset, ret, jiffies);
>> @@ -347,7 +348,7 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
>>       client = at24_client->client;
>>       count = at24_adjust_write_count(at24, offset, count);
>>
>> -     loop_until_timeout(timeout, write_time) {
>> +     at24_tool_until_timeout(timeout, write_time) {
>>               ret = regmap_bulk_write(regmap, offset, buf, count);
>>               dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
>>                       count, offset, ret, jiffies);
>> @@ -613,7 +614,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>
>>       writable = !(chip.flags & AT24_FLAG_READONLY);
>>       if (writable) {
>> -             at24->write_max = min_t(unsigned int, chip.page_size, io_limit);
>> +             at24->write_max = min_t(unsigned int,
>> +                                     chip.page_size, at24_io_limit);
>>               if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
>>                   at24->write_max > I2C_SMBUS_BLOCK_MAX)
>>                       at24->write_max = I2C_SMBUS_BLOCK_MAX;
>> @@ -728,12 +730,12 @@ static struct i2c_driver at24_driver = {
>>
>>  static int __init at24_init(void)
>>  {
>> -     if (!io_limit) {
>> -             pr_err("at24: io_limit must not be 0!\n");
>> +     if (!at24_io_limit) {
>> +             pr_err("at24: at24_io_limit must not be 0!\n");
>>               return -EINVAL;
>>       }
>>
>> -     io_limit = rounddown_pow_of_two(io_limit);
>> +     at24_io_limit = rounddown_pow_of_two(at24_io_limit);
>>       return i2c_add_driver(&at24_driver);
>>  }
>>  module_init(at24_init);
>>
>
