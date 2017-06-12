From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data buffer
Date: Mon, 12 Jun 2017 12:38:13 +0300
Message-ID: <CAHp75VeJi6etf5cjh1HfJPSEO6Cj07wvnyRKWzGUMa2EszY4Dg@mail.gmail.com>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
 <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com> <3d211ade-77e8-0ec7-582b-085686ddd4c1@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33262 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFLJiO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Jun 2017 05:38:14 -0400
In-Reply-To: <3d211ade-77e8-0ec7-582b-085686ddd4c1@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Song liwei <liwei.song@windriver.com>, Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 12, 2017 at 12:28 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-06-12 11:11, Andy Shevchenko wrote:
>> On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
>>> From: Liwei Song <liwei.song@windriver.com>

>>> After finished I2C block read/write, when unmap the data buffer,
>>> a wrong device address was pass to dma_unmap_single(),

>>> the right
>>> device address should be "dev" not "&adap->dev", the relation is
>>> *(&adap->dev) == dev.
>>
>> This is confusing. You are telling that there are two copies of struct
>> device here?
>
> Yes, there are two copies.

No, there is not. See below.

> There's the local dev variable that is like
> this:
>         struct device *dev = &priv->pci_dev->dev;
>
> And then there's the adapter device in adap->dev (inlined in adap, so
> the explanation that the relations is "*(&adap->dev) == dev" is doubly
> wrong).

I got the idea, but your explanation is not a penny better.

There are two struct devices, one is a real PCI device, which
represents actual device what *does* DMA.
This struct should be used according to DMA API.

Another struct device which is wrongly used is an artificial one that
represents I2C adapter in terms of Linux kernel.

The relation ship (if designed correctly) *should be* adap->dev.parent
== &pci_dev->dev.

> The bug is that the first argument to dma_unmap_single is not the
> same as the first argument to dma_map_single that appears a few lines
> up.

I understand that.

> I cannot tell if that argument should be "dev" or "&adap->dev"
> though, but the two calls must refer to the same struct device *.

See above. It's a simple choice.

-- 
With Best Regards,
Andy Shevchenko
