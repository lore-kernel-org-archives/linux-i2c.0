From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: check the return value of nvmem_unregister()
Date: Thu, 28 Dec 2017 22:42:21 +0100
Message-ID: <CAMRc=MfQvQ+PEcQZRcs8baHPgyrXQ_=m6YXCtbqDseYHMGOZtw@mail.gmail.com>
References: <20171227141038.31646-1-brgl@bgdev.pl> <20171228112845.GB3729@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228112845.GB3729@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-28 12:28 GMT+01:00 Johan Hovold <johan@kernel.org>:
> On Wed, Dec 27, 2017 at 03:10:38PM +0100, Bartosz Golaszewski wrote:
>> This function can fail with -EBUSY, but we don't check its return
>> value in at24_remove(). Bail-out of remove() if nvmem_unregister()
>> doesn't succeed.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index e79833d62284..fb21e1c45115 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -684,11 +684,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>  static int at24_remove(struct i2c_client *client)
>>  {
>>       struct at24_data *at24;
>> -     int i;
>> +     int i, ret;
>>
>>       at24 = i2c_get_clientdata(client);
>>
>> -     nvmem_unregister(at24->nvmem);
>> +     ret = nvmem_unregister(at24->nvmem);
>> +     if (ret)
>> +             return ret;
>
> I don't this makes much sense as a driver cannot refuse an unbind by
> returning an errno from remove(). The return value is simply ignored,
> remove() will never be called again, and you'd leave everything in an
> inconsistent state.
>

Cc: Srinivas

Hi Johan,

I blindly assumed that if there's a return value in remove() then
someone cares about it. In that case all users of nvmem_unregister()
that check the return value and bail-out of remove() on failure are
wrong and in the (very unlikely) event that this routine fails, we
leak all resources.

> It looks like the nvmem code grabs a reference to the owning module
> in __nvmem_device_get() which would at least prevent a module unload
> while another driver is using the device. And the (sysfs) userspace
> interface should be fine as device removal is handled by the kernfs
> code.

Indeed. I believe we should remove the -EBUSY return case from
nvmem_register() and just do what gpiolib does - scream loud
(dev_crit()) when someone forces a module unload or otherwise
unregisters the device if some cells are still requested. This would
also allow us to eventually add a devres variant for nvmem_register().

What do you think Srinivas?

Best regards,
Bartosz Golaszewski
