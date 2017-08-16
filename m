From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: 2 Questions about "i2c-tools (3.1.1)"
Date: Wed, 16 Aug 2017 09:23:51 +0200
Message-ID: <20170816072351.3mrjcmr4hv3g6dlf@pengutronix.de>
References: <CAFz8etO28fsVkYkcw8ZxAX2sh69B+EHS8oL08tjBpWbwTew3Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36751 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751620AbdHPHXx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Aug 2017 03:23:53 -0400
Content-Disposition: inline
In-Reply-To: <CAFz8etO28fsVkYkcw8ZxAX2sh69B+EHS8oL08tjBpWbwTew3Rw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tarker Hu <tarkerhu@gmail.com>
Cc: linux-i2c@vger.kernel.org

Hello,

On Tue, Aug 15, 2017 at 05:42:55PM +0800, Tarker Hu wrote:
> 　　We are using "i2c-tools (3.1.1)" and we have 2 questions:
> 
> 　　(01 ) When I send cmd “i2cdetect -y -r 2”, I find that some device
> address always shows “UU”.
> 
>         What “UU” means?

Did you read the man page of i2cdetect. There is a section "INTERPRETING
THE OUTPUT" that describes UU.
 
> 　　　　When I used i2cdump to that address (showing “UU”), it always came
> out “XXXX”. Can I i2cdump it?

You should unbind the driver first.

> 　　　　Is there any document about that?
> 
> 　　(02 ) If I need to i2cget/i2cset to an device with “word-address
> (address with 16 bits)”, how can I do?
> 
> 　　　　Is there any document?

Yes, the man page for i2cget and i2cset.

> 　　　　Can you show me a real example?

I don't have something handy. If you find that i2cset/get are not
flexible enough, you should be able to do whatever you want with
i2ctransfer (which doesn't exist yet in 3.1.1 though).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
