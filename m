From: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/8] i2c: Add pointer dereference protection to i2c_match_id()
Date: Fri, 11 Sep 2015 10:48:44 +0100
Message-ID: <CAB3z_RrSzBqjfpyOTXwpWggrQYUr-ugLVX=P5BOOqpkiAw-1hA@mail.gmail.com>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
	<1441823627-6227-2-git-send-email-kieranbingham@gmail.com>
	<20150911093154.GQ3260@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150911093154.GQ3260@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

On 11 September 2015 at 10:31, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, 09 Sep 2015, Kieran Bingham wrote:
>
>> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Here we're providing dereference protection for i2c_match_id(), whic=
h
>> saves us having to do it each time it's called.  We're also strippin=
g
>> out the (now) needless checks in i2c_device_match().  This patch pav=
es
>> the way for other, similar code trimming.
>>
>> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> SoB?


My apologies, I only added SOB to the patches I had modified ...
I didn't realise it should go on the ones I didn't touch as well.

I'll update and resend.

--
Regards

>
>> ---
>>  drivers/i2c/i2c-core.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index c83e4d1..30d8a77 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -450,6 +450,9 @@ static inline int acpi_i2c_install_space_handler=
(struct i2c_adapter *adapter)
>>  static const struct i2c_device_id *i2c_match_id(const struct i2c_de=
vice_id *id,
>>                                               const struct i2c_clien=
t *client)
>>  {
>> +     if (!(id && client))
>> +             return NULL;
>> +
>>       while (id->name[0]) {
>>               if (strcmp(client->name, id->name) =3D=3D 0)
>>                       return id;
>> @@ -463,8 +466,6 @@ static int i2c_device_match(struct device *dev, =
struct device_driver *drv)
>>       struct i2c_client       *client =3D i2c_verify_client(dev);
>>       struct i2c_driver       *driver;
>>
>> -     if (!client)
>> -             return 0;
>>
>>       /* Attempt an OF style match */
>>       if (of_driver_match_device(dev, drv))
>> @@ -475,9 +476,10 @@ static int i2c_device_match(struct device *dev,=
 struct device_driver *drv)
>>               return 1;
>>
>>       driver =3D to_i2c_driver(drv);
>> -     /* match on an id table if there is one */
>> -     if (driver->id_table)
>> -             return i2c_match_id(driver->id_table, client) !=3D NUL=
L;
>> +
>> +     /* Finally an I2C match */
>> +     if (i2c_match_id(driver->id_table, client))
>> +             return 1;
>>
>>       return 0;
>>  }
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
