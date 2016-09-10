From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] Drivers: i2c: busses: Use max macro instead of ternary operator
Date: Sun, 11 Sep 2016 00:54:30 +0530
Message-ID: <CAOH+1jFgt9He7z0YXUJHmXAJeUP0SmnZ3pD2bJd3F1XyPSPRdA@mail.gmail.com>
References: <1473534490-16592-1-git-send-email-bhumirks@gmail.com> <1473535309.19464.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34491 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbcIJTYd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 10 Sep 2016 15:24:33 -0400
In-Reply-To: <1473535309.19464.5.camel@perches.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 11, 2016 at 12:51 AM, Joe Perches <joe@perches.com> wrote:
> On Sun, 2016-09-11 at 00:38 +0530, Bhumika Goyal wrote:
>> Replace ternary operators with macro 'max' as it is shorter
>> and thus increases code readability. Macro max returns
>> the  maximum of the two compared values.
>> Done using coccinelle:
>>
>> @@
>> type T;
>> T x;
>> T y;
>> @@
>> (
>> - x < y ? x : y
>> + min(x,y)
>> - x > y ? x : y
>> + max(x,y)
>> )
>
> Hello.
>
> Please make sure to inspect and if appropriate modify the coccinelle
> output for the 'best' coding style, for whatever definition of 'best'
> you might use, before submitting automatically produced patches.
>
>> diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
> []
>> @@ -133,10 +133,10 @@ static const char * const jz4780_i2c_abrt_src[] = {
>>
>> #define JZ4780_I2C_ENB_I2C            BIT(0)
>>
>> -#define JZ4780_I2CSHCNT_ADJUST(n)    (((n) - 8) < 6 ? 6 : ((n) - 8))
>> -#define JZ4780_I2CSLCNT_ADJUST(n)    (((n) - 1) < 8 ? 8 : ((n) - 1))
>> -#define JZ4780_I2CFHCNT_ADJUST(n)    (((n) - 8) < 6 ? 6 : ((n) - 8))
>> -#define JZ4780_I2CFLCNT_ADJUST(n)    (((n) - 1) < 8 ? 8 : ((n) - 1))
>> +#define JZ4780_I2CSHCNT_ADJUST(n)    (max(6, (n) - 8))
>> +#define JZ4780_I2CSLCNT_ADJUST(n)    (max(8, (n) - 1))
>> +#define JZ4780_I2CFHCNT_ADJUST(n)    (max(6, (n) - 8))
>> +#define JZ4780_I2CFLCNT_ADJUST(n)    (max(8, (n) - 1))
>
> For instance: the parentheses are unnecessary and could be removed
> like the BIT macro above.

Thanks for pointing it out. I will resend the patch.

Thanks,
Bhumika
>>
