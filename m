From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
Date: Mon, 19 Mar 2018 13:12:51 +0100
Message-ID: <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
> On 2018-03-19 10:17, Bartosz Golaszewski wrote:
>> Replace the GPL header with an SPDX identifier for GPL-2.0.
>
> Great care should be exercised when dealing with copyrights of others.
>
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 2a4154eeb1bd..0e06201d33c9 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -1,14 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>
> This should be 2.0+

Indeed, thanks.

>
> Also, use a // style comment for the SPDX line in C files.
>
> Cheers,
> Peter

I'm seeing both /* */ and // style comments used for SPDX headers - is
there any reason not to use /* */ here?

Bart
