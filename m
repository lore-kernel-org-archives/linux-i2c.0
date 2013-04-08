From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via i2c_smbus_write_byte_data
Date: Mon, 8 Apr 2013 08:56:03 +0200
Message-ID: <CAH9NwWcpXAD7Hm=+ateYXz2bHVbFmJGOH7sRsEh02eeYNyD36w@mail.gmail.com>
References: <1355933229-25865-1-git-send-email-christian.gmeiner@gmail.com>
 <20130124140746.GI12933@pengutronix.de> <CAH9NwWeKFaZEWwK9Dio39pkVqcRUfVi=dxvoXT71csJLA13qzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH9NwWeKFaZEWwK9Dio39pkVqcRUfVi=dxvoXT71csJLA13qzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Christian Gmeiner <c.gmeiner-qzos7lGCgFkk+I/owrrOrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Using the new mail address of wolfram sang - got the following error:


Delivery to the following recipient failed permanently:

     w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

Technical details of permanent failure:
Google tried to deliver your message, but it was rejected by the
server for the recipient domainpengutronix.de by mail.pengutronix.de.
[2001:6f8:1178:4:290:27ff:fe1d:cc33].

The error that the other server returned was:
550 Account closed - please contact info-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org instead


2013/3/27 Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2013/1/24 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
>> On Wed, Dec 19, 2012 at 05:07:09PM +0100, Christian Gmeiner wrote:
>>> I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
>>> bus driver. This bus driver does not support
>>> I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
>>> to be able to write the eeprom. This patch adds support for
>>> I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
>>> It is quite slow, but it works.
>>>
>>> Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/misc/eeprom/at24.c | 35 +++++++++++++++++++++++++++++------
>>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index 2baeec5..723b411 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -56,6 +56,7 @@ struct at24_data {
>>>       struct at24_platform_data chip;
>>>       struct memory_accessor macc;
>>>       int use_smbus;
>>> +     int use_smbuse_write;
>>
>> Can't you use the same 'use_smbus' variable and do a similar switch-case
>> as in the read function?
>>
>
> Sorry for the really late answer.
>
> I am not sure if there exits some i2c buses which have different
> access methods for read and write.
> E.g. I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and I2C_FUNC_SMBUS_READ_BYTE_DATA
>
> If there will never be such a combination then I can reuse the same
> 'use_smbus' variable.
>

--
Christian Gmeiner, MSc
