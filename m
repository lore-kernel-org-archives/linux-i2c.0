From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 0/2] ARM: pxa: move pxa-i2c.h to platform_data
Date: Tue, 07 Nov 2017 08:21:05 +0100
Message-ID: <87efpa8sgu.fsf@belgarion.home>
References: <20171105141226.13624-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:55078 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbdKGHVI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 7 Nov 2017 02:21:08 -0500
In-Reply-To: <20171105141226.13624-1-wsa@the-dreams.de> (Wolfram Sang's
        message of "Sun, 5 Nov 2017 15:12:24 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> As discussed previously, we move the declarations now to devices.h and the
> platform_data to the platform_data directory. Only build tested, but buildbot
> is happy.
>
> Wolfram Sang (2):
>   ARM: pxa: move declarations to proper place
>   ARM: pxa: move header file out of I2C realm

Hi Wolfram,

This serie looks nice to me.
I'll throw it at my testbench today for a safety check and to see the bissection
is all right.

Meanwhile you can safely prepare your v2.

Cheers.
