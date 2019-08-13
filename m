From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 2/4] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Tue, 13 Aug 2019 11:49:05 +0200
Message-ID: <fa145f84-4249-44da-57dc-10cfe25dbde3@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190812235237.21797-2-max@enpas.org>
 <CAMuHMdX3NtKwxb6BJzJR1qLs5vC9zhU3d+cdrrHx4B9r1opkvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX3NtKwxb6BJzJR1qLs5vC9zhU3d+cdrrHx4B9r1opkvQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On 08/13/2019 09:03 AM, Geert Uytterhoeven wrote:
> Hi Max,
> 
> On Tue, Aug 13, 2019 at 1:53 AM Max Staudt <max@enpas.org> wrote:
>> Since the 2019 a1k.org community re-print of these PCBs sports an
>> LTC2990 hwmon chip as an example use case, let this driver autoprobe
>> for that as well. If it is present, modprobing ltc2990 is sufficient.
>>
>> Signed-off-by: Max Staudt <max@enpas.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/i2c/busses/i2c-icy.c
>> +++ b/drivers/i2c/busses/i2c-icy.c
>> @@ -160,6 +180,8 @@ static void icy_remove(struct zorro_dev *z)
>>  {
>>         struct icy_i2c *i2c = dev_get_drvdata(&z->dev);
>>
>> +       i2c_unregister_device(i2c->client_ltc2990);
> 
> Is this needed?
> In my understanding, i2c_del_adapter() below takes care of that.
It seems to do that in i2c_del_adapter():

  device_for_each_child(&adap->dev, NULL, __unregister_dummy);


However, I'm not sure I'm supposed to do that. I went by Documentation/i2c/instantiating-devices, which in "Method 2" says:

  The driver which instantiated the I2C device is responsible for destroying
  it on cleanup. This is done by calling i2c_unregister_device() on the
  pointer that was earlier returned by i2c_new_device() or
  i2c_new_probed_device().


So, what is preferred and why?


Thanks!

Max
