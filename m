From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] video: adp8860: move header file out of I2C realm
Date: Mon, 29 May 2017 11:22:52 +0200
Message-ID: <3553710.Yr6b9bAIsl@amdc3058>
References: <20170521220953.2602-1-wsa@the-dreams.de>
        <CGME20170521222746epcas2p46ba3b0a4c8e3cb864cfc1b3b385e9af6@epcas2p4.samsung.com>
        <20170521220953.2602-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17281 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdE2JW5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 29 May 2017 05:22:57 -0400
In-reply-to: <20170521220953.2602-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday, May 22, 2017 12:09:52 AM Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
>  drivers/video/backlight/adp8860_bl.c           | 2 +-
>  include/linux/{i2c => platform_data}/adp8860.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/{i2c => platform_data}/adp8860.h (100%)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
