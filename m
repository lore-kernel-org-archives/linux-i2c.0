From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 16:29:42 +0800
Message-ID: <CAFRkauC4YeuewDGRWbhhBWCG=XbMuNyNL+Lj2jv-nb5EWzaO-Q@mail.gmail.com>
References: <1460619774.4294.1.camel@ingics.com>
	<20160414082456.GK10108@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32914 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbcDNI3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 04:29:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id p64so11067675lfg.0
        for <linux-i2c@vger.kernel.org>; Thu, 14 Apr 2016 01:29:43 -0700 (PDT)
In-Reply-To: <20160414082456.GK10108@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>

2016-04-14 16:24 GMT+08:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello Axel,
>
> On Thu, Apr 14, 2016 at 03:42:54PM +0800, Axel Lin wrote:
>> Make sure we don't OOPS in case clock-frequency is set to 0 in a DT.=
 The
>> variable set here is later used as a divisor.
>
> This is correct in principle. I thought it's ok to misbehave if the D=
T
> is broken? In this case the current code is just fine.

Current code hit division by zero if clock-frequency is 0.
clkdiv =3D DIV_ROUND_UP(rate, 8 * ddata->frequency) - 1;
Is it ok?
