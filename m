From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 2/2] eeprom: at24: use a common prefix for all symbols in at24.c
Date: Wed, 6 Dec 2017 12:21:26 +0100
Message-ID: <CAMRc=McDZRxzgjFBRo6C_wbnw32ARDQ+ztoa1LOAtqH48u170w@mail.gmail.com>
References: <20171206101926.14995-1-brgl@bgdev.pl> <20171206101926.14995-3-brgl@bgdev.pl>
 <20171206110349.zjxadfdxgo5qcmex@pengutronix.de> <CAMRc=McAD78rOPjybObjxcabD3suhrcitDZJje9wmW3ykXfmEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37401 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbdLFLV1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 06:21:27 -0500
Received: by mail-oi0-f67.google.com with SMTP id y75so2309409oie.4
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 03:21:27 -0800 (PST)
In-Reply-To: <CAMRc=McAD78rOPjybObjxcabD3suhrcitDZJje9wmW3ykXfmEg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-06 12:05 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2017-12-06 12:03 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de>:
>> On Wed, Dec 06, 2017 at 11:19:26AM +0100, Bartosz Golaszewski wrote:
>>> There are a couple symbols defined in the driver source file which are
>>> missing the at24_ prefix. This patch fixes that.
>>>
>>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>> ---
>>>  drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++----------------
>>>  1 file changed, 18 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index 2426f2c111c7..4ead21d0dcc5 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -93,17 +93,17 @@ struct at24_data {
>>>   *
>>>   * This value is forced to be a power of two so that writes align on p=
ages.
>>>   */
>>> -static unsigned int io_limit =3D 128;
>>> -module_param(io_limit, uint, 0000);
>>> -MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
>>> +static unsigned int at24_io_limit =3D 128;
>>> +module_param(at24_io_limit, uint, 0000);
>>> +MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)")=
;
>>
>> You change the names of the module parameters here. I think this is not
>> a good idea as now you have to pass
>>
>>         at24.at24_io_limit=3D...
>>
>> on the kernel command line. If you still want this change, I think there
>> is some documentation that needs adaption, too.
>>
>> Best regards
>> Uwe
>>
>>
>> --
>> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig      =
      |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/ =
 |
>
> Ugh, right, this must stay as it was. Thanks!
>

Actually we can use module_param_named() here. I'll send a v2.

Thanks,
Bartosz
