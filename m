From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data
 buffer
Date: Mon, 12 Jun 2017 12:19:48 +0200
Message-ID: <c1ca8d84-ec5d-b247-0338-f1b7b96999d8@axentia.se>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
 <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com>
 <3d211ade-77e8-0ec7-582b-085686ddd4c1@axentia.se>
 <CAHp75VeJi6etf5cjh1HfJPSEO6Cj07wvnyRKWzGUMa2EszY4Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0121.outbound.protection.outlook.com ([104.47.2.121]:18066
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751970AbdFLKT4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Jun 2017 06:19:56 -0400
In-Reply-To: <CAHp75VeJi6etf5cjh1HfJPSEO6Cj07wvnyRKWzGUMa2EszY4Dg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Song liwei <liwei.song@windriver.com>, Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 2017-06-12 11:38, Andy Shevchenko wrote:
> On Mon, Jun 12, 2017 at 12:28 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2017-06-12 11:11, Andy Shevchenko wrote:
>>> On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
>>>> From: Liwei Song <liwei.song@windriver.com>
> 
>>>> After finished I2C block read/write, when unmap the data buffer,
>>>> a wrong device address was pass to dma_unmap_single(),
> 
>>>> the right
>>>> device address should be "dev" not "&adap->dev", the relation is
>>>> *(&adap->dev) == dev.
>>>
>>> This is confusing. You are telling that there are two copies of struct
>>> device here?
>>
>> Yes, there are two copies.
> 
> No, there is not. See below.

What I meant was that there are the struct device in pci_dev->dev and the
struct device in adap->dev. That seems like two copies of struct device
to me. I didn't mean that they are copies in the sense that they have the
same content, but in the sense that they are both struct device.

I guess we can argue ourselves blue over this point.

> There are two struct devices, 

Hmm, two struct devices, I seem to recall that from somewhere... :-)

>                               one is a real PCI device, which
> represents actual device what *does* DMA.
> This struct should be used according to DMA API.

When you put it like that, it's obvious that the patch is correct. I had
this feeling that little thought had gone into the choice to pick "dev"
over "&adap->dev", that's all.

> Another struct device which is wrongly used is an artificial one that
> represents I2C adapter in terms of Linux kernel.

Cheers,
peda
