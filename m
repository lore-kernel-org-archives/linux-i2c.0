From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v2 04/13] eeprom: at24: make locking more fine-grained
Date: Tue, 3 May 2016 19:55:31 +0200
Message-ID: <CAMpxmJWHo6sMPBek7j4fDtpiRLHQEyGobA4MGSW0FM6as+m8+Q@mail.gmail.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
	<1460401049-25459-5-git-send-email-bgolaszewski@baylibre.com>
	<20160416205655.GB1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160416205655.GB1522@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-i2c@vger.kernel.org

2016-04-16 22:56 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Mon, Apr 11, 2016 at 11:57:20AM -0700, Bartosz Golaszewski wrote:
>> The only field in struct at24_data that needs locking in the module
>> code is u8 *writebuf. Other data is already protected by i2c core.
>>
>> Rename the lock in at24_data to wrbuf_lock and only use it where
>> writebuf is accessed.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Did you run some tests to verify our assumption?
>

Hi Wolfram,

I had done concurrent read/write tests on a chip using i2c operations,
but I carried this patch over from before porting at24 to nvmem. I
didn't notice previously, but currently all read/write operations are
protected by the regmap lock in regmap_raw_write()/read().

There's no need for any locking in the driver anymore. I'll remove the
mutex altogether in the next version of the patchset.

Speaking of which: I don't think I'll find the time to complete the
driver rework before the next merge window. Would you mind picking up
patches [2/13] & [3/13] for 4.7?

Best regards,
Bartosz Golaszewski
