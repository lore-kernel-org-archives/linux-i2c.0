From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Questions rgd. patch "eeprom: at24: support eeproms that do not
 auto-rollover reads"
Date: Fri, 8 Dec 2017 23:19:32 +0100
Message-ID: <ae0d6cc8-70ac-1f7a-7ef5-dab4c57ad05d@gmail.com>
References: <c00c4e31-fee0-5666-d0a2-a3d53fd146c0@googlemail.com>
 <CAGngYiXh6AH1GaU1cJNayv213ki=Ui6BesV6qNat7nyiZRRPAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:45868 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdLHWTm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 17:19:42 -0500
Received: by mail-wm0-f51.google.com with SMTP id 9so5427120wme.4
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 14:19:41 -0800 (PST)
In-Reply-To: <CAGngYiXh6AH1GaU1cJNayv213ki=Ui6BesV6qNat7nyiZRRPAw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Bartosz Golaszewski <brgl@bgdev.pl>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 08.12.2017 um 21:09 schrieb Sven Van Asbroeck:
> On Fri, Dec 8, 2017 at 2:33 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> In at24_adjust_read_count() there is the line
>> remainder = BIT(bits) - offset;
>>
>> AFAICS we can have the case offset > BIT(bits). Imagine a 8 bit chip
>> with size 512 (2 addresses) and we try to read a few bytes from
>> offset 300. Then the line in question doesn't do what it's supposed
>> to do.
> 
> I don't think offset can be > BIT(bits). In at24_regmap_read(), we have:
> 
> at24_client = at24_translate_offset(at24, &offset);
> regmap = at24_client->regmap;
> client = at24_client->client;
> count = at24_adjust_read_count(at24, offset, count);
> 
> at24_translate_offset() will translate the general offset to an offset
> within a subchip. E.g. offset 300 will be translated to offset 44
> into the second subchip.
> 
Ahh, I see that I misunderstood the issue being addressed by this change.
Forget about my comments and sorry for the noise.

>> And a more general aspect: If the size is 512 but only 256 byte are
>> accessible then I doubt it's nice to create a nvmem provider with
>> size 512. Wouldn't it be better to adjust byte_len to reflect the
>> accessible size? Then we also wouldn't need the check in
>> at24_adjust_read_count.
> 
> I'm not sure if I understand. Could you clarify a bit Heiner?
> If the size is 512 and it's a multi-address chip with 8-bit
> addresses, we simply have two 256-byte subchips.
> The size is 512. All 512 bytes are accessible.
> 
