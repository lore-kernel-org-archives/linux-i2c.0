From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number read
Date: Thu, 7 Jan 2016 17:10:27 +0100
Message-ID: <CAMpxmJWy3Rx_mY92wQ8+OkAEwHiJYL=n5LNDpaf6u-Ogjiw=NA@mail.gmail.com>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
	<20151211120831.GA2742@katana>
	<CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
	<20160102205041.GC1589@katana>
	<CAMpxmJWmgk+9oJXZnRFRzidLaasoMyuDuZmVWWrs6dwNM=+k6Q@mail.gmail.com>
	<20160105185853.GB1743@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36914 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbcAGQK2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Jan 2016 11:10:28 -0500
Received: by mail-ig0-f176.google.com with SMTP id h5so17434479igh.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 Jan 2016 08:10:28 -0800 (PST)
In-Reply-To: <20160105185853.GB1743@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2016-01-05 19:58 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Mon, Jan 04, 2016 at 03:01:54PM +0100, Bartosz Golaszewski wrote:
>> 2016-01-02 21:50 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>> > On Fri, Dec 11, 2015 at 02:55:10PM +0100, Bartosz Golaszewski wrote:
>> >> 2015-12-11 13:08 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>> >> > On Wed, Dec 02, 2015 at 11:25:17AM +0100, Bartosz Golaszewski wrote:
>> >> >> Chips from the at24cs EEPROM series have an additional read-only memory area
>> >> >> containing a factory pre-programmed serial number. In order to access it, a
>> >> >> dummy write must be executed before reading the serial number bytes.
>> >> >
>> >> > Can't you instantiate a read-only EEPROM on this second address? Or a
>> >> > seperate driver attaching to this address? What is the advantage of
>> >> > having this in at24?
>> >> >
>> >>
>> >> The regular memory area and serial number read-only block share the
>> >> internal address pointer. We must ensure that there's no race
>> >> conditions between normal EEPROM reads/writes and serial number reads.
>> >
>> > I don't get it. Both, regular at24 reads and the serial read, setup the
>> > pointer every time by using two messages, first write to set the
>> > pointer, then read. The per-adapter lock makes sure those two messages
>> > will not get interrupted.
>>
>> If that's correct, then is there any need to have an additional mutex
>> for at24_data?
>
> I can't see a need, yes.

Then I'll see if it can be safely removed in the next iteration.

>> In that case would the preferred method be to access the regular
>> memory area like before - by allocating, for example, a 24c02 device -
>> while allocating a second device - in that case 24cs02 - on the
>> corresponding serial number address would give the user access to the
>> serial number via the eeprom sysfs attribute (which for the latter
>> would be read-only and 16 bytes in size)?
>
> Yes, a seperate driver for the second address is what I meant to suggest
> in the above paragraph. Only that the data should probably be exported
> via the NVMEM framework, not directly via sysfs. We have patches pending
> doing that for at24.

Right, but then these patches keep the driver backwards compatible in
that they keep the 'eeprom' sysfs attribute, so it's still a viable
option.

> What happens if you assign another at24 instance (read-only) to the
> second address? I mean, there is not only the serial number, but also a
> MAC address IIRC.

Nothing - it can't be read with the regular driver. Its protocol
requires certain bits set just like in the function from patch 4/9 in
this series.

As for the MAC address - I can't find anything in the datasheet, and
haven't heard about it.

> Regards,
>
>    Wolfram
>

Best regards,
Bartosz Golaszewski
