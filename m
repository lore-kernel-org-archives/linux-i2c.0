From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/4] i2c: mux: ltc4306: switch to using .probe_new
Date: Sat, 19 May 2018 23:55:58 +0200
Message-ID: <ab7bece4-ff89-3889-615c-7b0b085c3e03@axentia.se>
References: <20180417143233.25145-1-peda@axentia.se>
 <20180417143233.25145-2-peda@axentia.se>
 <bc5637c3-5e09-b01f-8b9d-f7dcb3b578e1@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc5637c3-5e09-b01f-8b9d-f7dcb3b578e1@analog.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: michael.hennerich@analog.com, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-04-18 11:26, Michael Hennerich wrote:
> On 17.04.2018 16:32, Peter Rosin wrote:
>> Use the new probe style for i2c drivers.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Thanks Peter,
> 
> Don't know why i2c needs a new probe style to save one function parameter...
> But this patch looks otherwise good to me.
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Thanks, added this patch to i2c-mux/for-next

Cheers,
Peter

>> ---
>>   drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> index 311b1cced0c0..a9af93259b19 100644
>> --- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> @@ -206,8 +206,7 @@ static const struct of_device_id ltc4306_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, ltc4306_of_match);
>>   
>> -static int ltc4306_probe(struct i2c_client *client,
>> -			 const struct i2c_device_id *id)
>> +static int ltc4306_probe(struct i2c_client *client)
>>   {
>>   	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>>   	const struct chip_desc *chip;
>> @@ -221,7 +220,7 @@ static int ltc4306_probe(struct i2c_client *client,
>>   	chip = of_device_get_match_data(&client->dev);
>>   
>>   	if (!chip)
>> -		chip = &chips[id->driver_data];
>> +		chip = &chips[i2c_match_id(ltc4306_id, client)->driver_data];
>>   
>>   	idle_disc = device_property_read_bool(&client->dev,
>>   					      "i2c-mux-idle-disconnect");
>> @@ -310,7 +309,7 @@ static struct i2c_driver ltc4306_driver = {
>>   		.name	= "ltc4306",
>>   		.of_match_table = of_match_ptr(ltc4306_of_match),
>>   	},
>> -	.probe		= ltc4306_probe,
>> +	.probe_new	= ltc4306_probe,
>>   	.remove		= ltc4306_remove,
>>   	.id_table	= ltc4306_id,
>>   };
>>
> 
> 
