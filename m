From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number read
Date: Mon, 11 Jan 2016 14:57:12 +0100
Message-ID: <CAMpxmJVjieC6C=1YUEZ-ZAy0xXYhFJB=NiyHB=pVSS74O+fp8A@mail.gmail.com>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
	<20151211120831.GA2742@katana>
	<CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
	<20160102205041.GC1589@katana>
	<CAMpxmJWmgk+9oJXZnRFRzidLaasoMyuDuZmVWWrs6dwNM=+k6Q@mail.gmail.com>
	<20160105185853.GB1743@katana>
	<CAMpxmJWy3Rx_mY92wQ8+OkAEwHiJYL=n5LNDpaf6u-Ogjiw=NA@mail.gmail.com>
	<20160109210946.GA1526@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160109210946.GA1526@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-01-09 22:09 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> >> If that's correct, then is there any need to have an additional mutex
>> >> for at24_data?
>> >
>> > I can't see a need, yes.
>>
>> Then I'll see if it can be safely removed in the next iteration.
>
> That would be great, thanks!
>
>> > Yes, a seperate driver for the second address is what I meant to suggest
>> > in the above paragraph. Only that the data should probably be exported
>> > via the NVMEM framework, not directly via sysfs. We have patches pending
>> > doing that for at24.
>>
>> Right, but then these patches keep the driver backwards compatible in
>> that they keep the 'eeprom' sysfs attribute, so it's still a viable
>> option.
>
> Yes, they do it for backwards compatibility. If you do something new,
> you can't really claim that ;)
>
>> > What happens if you assign another at24 instance (read-only) to the
>> > second address? I mean, there is not only the serial number, but also a
>> > MAC address IIRC.
>>
>> Nothing - it can't be read with the regular driver. Its protocol
>> requires certain bits set just like in the function from patch 4/9 in
>> this series.
>
> Maybe it might work if you seek to the right offset and read the right
> number of bytes, but this is clumsy, I agree.

You not only need to reset the address pointer to the right value, but
also prefix the word address with the right sequence just like in the
following snippet:

200         if (at24->chip.flags & AT24_FLAG_ADDR16) {
201                 /*
202                  * For 16 bit address pointers, the word address
must contain
203                  * a '10' sequence in bits 11 and 10 regardless of the
204                  * intended position of the address pointer.
205                  */
206                 addrbuf[0] = 0x08;
207                 addrbuf[1] = offset;
208                 msg[0].len = 2;
209         } else {
210                 /*
211                  * Otherwise the word address must begin with a
'10' sequence,
212                  * regardless of the intended address.
213                  */
214                 addrbuf[0] = 0x80 + offset;
215                 msg[0].len = 1;
216         }

>> As for the MAC address - I can't find anything in the datasheet, and
>> haven't heard about it.
>
> http://www.atmel.com/images/atmel-8807-seeprom-at24mac402-602-datasheet.pdf
>
> That was the first data sheet I found when looking for documentation.
> So, we should keep in mind that there might be more than a serial number
> in this extra memory space.

Right. I'll keep that in mind, but unfortunately I have no means of testing it.

Best regards,
Bartosz Golaszewski

> Thanks,
>
>    Wolfram
>
