From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/2] I2C support for NXP LPC18xx family
Date: Wed, 19 Aug 2015 17:30:24 +0200
Message-ID: <CAGhQ9VxEOMg7hG=L4A9QZLQOfZQgtBhgs2PH1zajxqbrZpi3Wg@mail.gmail.com>
References: <1439748617-7683-1-git-send-email-manabian@gmail.com>
	<20150819151838.GC1634@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150819151838.GC1634@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 19 August 2015 at 17:18, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Sun, Aug 16, 2015 at 08:10:15PM +0200, Joachim Eastwood wrote:
>> This patch set adds a I2C driver and documentation for the I2C
>> peripheral found on many NXP LPC MCUs.
>>
>> The driver is a rework of an old driver by Kevin Wells. It has been
>> modified to support modern resource allocation, device tree and
>> generally cleaned up. Driver was originally written to support the
>> LPC2xxx platforms.
>>
>> Patches based on i2c/for-next and tested on Embedded Artists' LPC4357
>> Dev Kit and Hitex LPC4350 Eval board with several I2C devices.
>>
>> This version address comments from Wolfram Sang.
>>
>> Changes since v1:
>>  - remove dev_dbg() leftovers from development/debugging
>>  - use i2c_add_adapter
>>  - change return value on NACK and arb lost
>>    (I think all the others should be okay as they are)
>>  - fix 80 char warnings (involved s/reg_base/base)
>>  - rebase on i2c/for-next
>>
>> Joachim Eastwood (2):
>>   i2c: add i2c-lpc2k driver
>>   doc: dt: add documentation for nxp,lpc1788-i2c
>
> Applied to for-next, thanks!

Thanks, Wolfram.

> Changes regarding readl_poll_timeout() can be sent incrementally.

Got it. I'll see if I can figure out a way to test the code path properly.

regards,
Joachim Eastwood
