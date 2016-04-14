From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH v2] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 22:17:45 +0800
Message-ID: <CAFRkauC+JamMAM4YAunmqzggK7X4dDUAU8O0LTbcOEGHdD48uQ@mail.gmail.com>
References: <1460627375.17638.1.camel@ingics.com>
	<20160414114041.GS10108@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33569 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbcDNORr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 10:17:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id p64so12489271lfg.0
        for <linux-i2c@vger.kernel.org>; Thu, 14 Apr 2016 07:17:46 -0700 (PDT)
In-Reply-To: <20160414114041.GS10108@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>

2016-04-14 19:40 GMT+08:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello Axel,
>
> On Thu, Apr 14, 2016 at 05:49:35PM +0800, Axel Lin wrote:
>> Make sure we don't OOPS in case clock-frequency is set to 0 in a DT.=
 The
>> variable set here is later used as a divisor.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>> If my understand is correct, you prefer to make it return error rath=
er
>> than using default frequency setting if DT setting is wrong.
>
> No, I'd say it doesn't matter that the driver crashes if something
> invalid is specified in the device tree. This is not a driver bug, bu=
t a
> dt bug. So if it happens, fix the device tree, no need to modify the
> driver.

I know that such case is a DT bug.
But the intention of this patch is to avoid oops rather than fix dt.
Make probe return error is enough to inform developer fixing dt.
