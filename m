From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data buffer
Date: Mon, 12 Jun 2017 13:29:15 +0300
Message-ID: <CAHp75VeOc8_o9FnpyocujuWcXShAGCxW-PP_Vi1f+o2va7oB=w@mail.gmail.com>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
 <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com>
 <3d211ade-77e8-0ec7-582b-085686ddd4c1@axentia.se> <CAHp75VeJi6etf5cjh1HfJPSEO6Cj07wvnyRKWzGUMa2EszY4Dg@mail.gmail.com>
 <c1ca8d84-ec5d-b247-0338-f1b7b96999d8@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36644 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdFLK3Q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Jun 2017 06:29:16 -0400
In-Reply-To: <c1ca8d84-ec5d-b247-0338-f1b7b96999d8@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Song liwei <liwei.song@windriver.com>, Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 12, 2017 at 1:19 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-06-12 11:38, Andy Shevchenko wrote:
>> On Mon, Jun 12, 2017 at 12:28 PM, Peter Rosin <peda@axentia.se> wrote:
>>> On 2017-06-12 11:11, Andy Shevchenko wrote:
>>>> On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
>>>>> From: Liwei Song <liwei.song@windriver.com>
>>
>>>>> After finished I2C block read/write, when unmap the data buffer,
>>>>> a wrong device address was pass to dma_unmap_single(),
>>
>>>>> the right
>>>>> device address should be "dev" not "&adap->dev", the relation is
>>>>> *(&adap->dev) == dev.
>>>>
>>>> This is confusing. You are telling that there are two copies of struct
>>>> device here?
>>>
>>> Yes, there are two copies.
>>
>> No, there is not. See below.
>
> What I meant was that there are the struct device in pci_dev->dev and the
> struct device in adap->dev. That seems like two copies of struct device
> to me.

They are not copies. That's my point.

> I didn't mean that they are copies in the sense that they have the
> same content, but in the sense that they are both struct device.
>
> I guess we can argue ourselves blue over this point.

See above.

>> There are two struct devices,
>
> Hmm, two struct devices, I seem to recall that from somewhere... :-)

Okay, it's possible bad wording from my side.

>>                               one is a real PCI device, which
>> represents actual device what *does* DMA.
>> This struct should be used according to DMA API.

> When you put it like that, it's obvious that the patch is correct.

I agreed with this in the first place! See my first reply.

>  I had
> this feeling that little thought had gone into the choice to pick "dev"
> over "&adap->dev", that's all.

As I said, my concern is the commit message to the change which is
totally confusing.

-- 
With Best Regards,
Andy Shevchenko
