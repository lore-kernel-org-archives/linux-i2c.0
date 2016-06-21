From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Question about I2C driver upstream from same SoC vendor
Date: Tue, 21 Jun 2016 09:59:24 +0200
Message-ID: <CAOAejn0EaPQK7A-YAN1RC6dVEB5wxtVvWq9Z0D0GnA66N9GoVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34561 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851AbcFUIFp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Jun 2016 04:05:45 -0400
Received: by mail-pa0-f49.google.com with SMTP id bz2so4060372pad.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jun 2016 01:05:25 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

I am currently upstreaming a driver to support the I2C controller
embedded in STM32F4 SoC from ST.
In the meantime, I am thinking how to add the support of the I2C
controller embedded in STM32F7 SoC.
The I2C IP are very different between F4 and F7 SoC in term of IP
engine, registers and so on.
So, I have intended to develop 2 different drivers, the first one
called i2c-stm32f4.c and the second one called i2c-stm32f7.c.
I am wondering if it is the good way of working as I noticed that many
maintainers prefer to have one driver that support all IPs of the same
SoC vendor ?
In our case, I think it will be possible to support both I2C IPs in
one driver called i2c-stm32.c but the code will run of readability and
will be difficult to maintain...

Thanks in advance for your feedback.

BR,
Cedric
