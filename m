From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number read
Date: Mon, 21 Dec 2015 15:29:53 +0100
Message-ID: <CAMpxmJW5GZ=HaA71Oo_HVTj02MLZEJsjYmyocuH7cvLtE4THJw@mail.gmail.com>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
	<20151211120831.GA2742@katana>
	<CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2015-12-11 14:55 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> 2015-12-11 13:08 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>> On Wed, Dec 02, 2015 at 11:25:17AM +0100, Bartosz Golaszewski wrote:
>>> Chips from the at24cs EEPROM series have an additional read-only memory area
>>> containing a factory pre-programmed serial number. In order to access it, a
>>> dummy write must be executed before reading the serial number bytes.
>>
>> Can't you instantiate a read-only EEPROM on this second address? Or a
>> seperate driver attaching to this address? What is the advantage of
>> having this in at24?
>>
>
> The regular memory area and serial number read-only block share the
> internal address pointer. We must ensure that there's no race
> conditions between normal EEPROM reads/writes and serial number reads.
>
> Best regards,
> Bartosz Golaszewski

Hi Wolfram,

any chance of getting it in for 4.5?

Best regards,
Bartosz Golaszewski
