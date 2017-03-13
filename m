From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 14:34:39 +0100
Message-ID: <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:7209
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750907AbdCMNew (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Mar 2017 09:34:52 -0400
In-Reply-To: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: MikeB <mabnhdev@gmail.com>, linux-i2c@vger.kernel.org

On 2017-03-13 14:14, MikeB wrote:
> The current naming scheme for i2c-mux adapters "i2c-<parent adapter
> id>-mux (chan_id <id>)" results in duplicate names if there is more
> than one mux device on an i2c adapter since each device will have the
> same <parent adapter id>.
> 
> For example:
> 
>                   +--------+
>                   |PCA9548 |
>                   |  0x70  |
>                   |01234567|
>                   +--------+
>                    |
>         +-----------------------------+
>         |             |               |
>     +--------+    +--------+     +--------+
>     |PCA9548 |    |PCA9548 |     |PCA9548 |
>     |  0x73  |    |  0x74  |     |  0x75  |
>     |01234567|    |01234567|     |01234567|
>     +--------+    +--------+     +--------+
> 
> 
> will result in eight sets of duplicate names for the channels coming
> off the lower three muxes.

I think it's fairly common for adapters from the same driver to have
the same 'name'. E.g. the .../busses/i2c-at91.c driver uses "AT91" for
all adapters it instantiates.

> Any suggestions on how to modify i2c-mux.c to make these names unique?

Why do they have to be unique?

Cheers,
peda
