From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/7] eeprom: at24: don't explicitely include header files
 which are implicitely included
Date: Thu, 30 Nov 2017 20:32:41 +0100
Message-ID: <172da7fb-40a5-ef36-cbc7-ee6aa5d62e5f@gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
 <5fd1ad39-db94-e774-b77c-8081bfed7817@gmail.com>
 <b058a205-8ea9-cc3c-9153-c428f31eee48@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45556 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdK3Tcr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 14:32:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id h1so7733955wre.12
        for <linux-i2c@vger.kernel.org>; Thu, 30 Nov 2017 11:32:46 -0800 (PST)
In-Reply-To: <b058a205-8ea9-cc3c-9153-c428f31eee48@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 30.11.2017 um 16:56 schrieb Peter Rosin:
> On 2017-11-30 07:48, Heiner Kallweit wrote:
>> Don't explicitely include header files which are implicitely included.
> 
> That's backwards. It hinders future header rearrangement. Things that
> are used directly (e.g. the BIT macro) should have its respective
> include specified (bitops.h in that case).
> 
> It's not a competition for the shortest file, the goal is easy
> maintenance.
> 
Understood ..

@Bartosz: then you can ignore this one.

Rgds, Heiner


> Cheers,
> Peter
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/misc/eeprom/at24.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index cd87f1b21..c75bb9b45 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -10,15 +10,10 @@
>>   * (at your option) any later version.
>>   */
>>  #include <linux/kernel.h>
>> -#include <linux/init.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> -#include <linux/mutex.h>
>> -#include <linux/mod_devicetable.h>
>> -#include <linux/log2.h>
>> -#include <linux/bitops.h>
>>  #include <linux/jiffies.h>
>>  #include <linux/property.h>
>>  #include <linux/acpi.h>
>>
> 
> 
