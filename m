Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB13C433FE
	for <linux-i2c@archiver.kernel.org>; Fri,  1 Apr 2022 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345604AbiDALvr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDALvr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Apr 2022 07:51:47 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959241D41A2;
        Fri,  1 Apr 2022 04:49:55 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 44FB420E819C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v5 3/3] i2c: ch341: add I2C MFD cell driver for the CH341
To:     frank zago <frank@zago.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Johan Hovold" <johan@kernel.org>, <linux-usb@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-i2c@vger.kernel.org>
References: <20220401023306.79532-1-frank@zago.net>
 <20220401023306.79532-4-frank@zago.net>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fdf1eb97-d711-4074-6e24-0bdccf779121@omp.ru>
Date:   Fri, 1 Apr 2022 14:49:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220401023306.79532-4-frank@zago.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hello!

On 4/1/22 5:33 AM, frank zago wrote:

> The I2C interface can run at 4 different speeds. This driver currently
> only offer 100MHz. Tested with a variety of I2C sensors, and the IIO

   Maybe 100 KHz? It's a more common I2C speed. :-)

> subsystem.
> 
> Signed-off-by: frank zago <frank@zago.net>
[...]

MBR,  Sergey
