Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72613C433EF
	for <linux-i2c@archiver.kernel.org>; Thu, 16 Jun 2022 01:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiFPBYf (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbiFPBYc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2022 21:24:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A5369F8;
        Wed, 15 Jun 2022 18:24:29 -0700 (PDT)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0B90040005;
        Thu, 16 Jun 2022 01:24:25 +0000 (UTC)
Message-ID: <b3a98835-8ecb-761b-2a1b-4dec0a3b6fed@zago.net>
Date:   Wed, 15 Jun 2022 20:24:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/3] mfd: ch341: add core driver for the WCH CH341 in
 I2C/SPI/GPIO mode
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, linux-usb@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20220401023306.79532-1-frank@zago.net>
 <20220401023306.79532-2-frank@zago.net>
 <Youukx+7oieeDVCE@hovoldconsulting.com>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <Youukx+7oieeDVCE@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Johan,

On 5/23/22 10:56, Johan Hovold wrote:

>> +
>> +	dev = devm_kzalloc(&iface->dev, sizeof(*dev), GFP_KERNEL);
>> +	if (!dev)
>> +		return -ENOMEM;
>> +
>> +	dev->usb_dev = usb_get_dev(interface_to_usbdev(iface));
> 
> No need to grab a reference unless you're going to hold on to it past
> disconnect().

I removed that.


>> +
>> +	endpoints = iface->cur_altsetting->endpoint;
>> +	if (!usb_endpoint_is_bulk_in(&endpoints[0].desc) ||
>> +	    !usb_endpoint_is_bulk_out(&endpoints[1].desc) ||
>> +	    !usb_endpoint_xfer_int(&endpoints[2].desc)) {
>> +		rc = -ENODEV;
>> +		goto free_dev;
>> +	}
> 
> Please use usb_find_common_endpoints() for the above.

Thanks. I wasn't aware on that API. It simplifies things a bit.

Regards,
  Frank.
