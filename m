Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96963C43334
	for <linux-i2c@archiver.kernel.org>; Thu, 16 Jun 2022 01:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiFPB3j (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFPB3i (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2022 21:29:38 -0400
X-Greylist: delayed 643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 18:29:37 PDT
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD752E53;
        Wed, 15 Jun 2022 18:29:37 -0700 (PDT)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BD55B60004;
        Thu, 16 Jun 2022 01:29:32 +0000 (UTC)
Message-ID: <9b5b8cb4-7c05-b3cf-ca68-85d334a7f0b0@zago.net>
Date:   Wed, 15 Jun 2022 20:29:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/3] gpio: ch341: add GPIO MFD cell driver for the
 CH341
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
 <20220401023306.79532-3-frank@zago.net>
 <YouzaO6ogxYj40Bp@hovoldconsulting.com>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <YouzaO6ogxYj40Bp@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 5/23/22 11:16, Johan Hovold wrote:

>> +static void ch341_complete_intr_urb(struct urb *urb)
>> +{
>> +	struct ch341_gpio *dev = urb->context;
>> +	int rc;
>> +
>> +	if (urb->status) {
>> +		usb_unanchor_urb(dev->irq_urb);
> 
> URBs are unanchored by USB core on completion.

Fixed.

> 
>> +static void ch341_gpio_irq_enable(struct irq_data *data)
>> +{
>> +	struct ch341_gpio *dev = irq_data_get_irq_chip_data(data);
>> +	int rc;
>> +
>> +	/*
>> +	 * The URB might have just been unlinked in
>> +	 * ch341_gpio_irq_disable, but the completion handler hasn't
>> +	 * been called yet.
>> +	 */
>> +	if (!usb_wait_anchor_empty_timeout(&dev->irq_urb_out, 5000))
>> +		usb_kill_anchored_urbs(&dev->irq_urb_out);
>> +
>> +	usb_anchor_urb(dev->irq_urb, &dev->irq_urb_out);
>> +	rc = usb_submit_urb(dev->irq_urb, GFP_ATOMIC);
>> +	if (rc)
>> +		usb_unanchor_urb(dev->irq_urb);
> 
> This looks confused and broken.
> 
> usb_kill_anchored_urbs() can sleep so either calling it is broken or
> using GFP_ATOMIC is unnecessary.

Right, that function can sleep. I changed GFP_ATOMIC to GFP_KERNEL.

> 
> And isn't this function called multiple times when enabling more than
> one irq?!

There's only one IRQ, so only one URB will be posted at a time. It
is reposted as soon as it comes back unless the IRQ is disabled or
the device stops.


> 
>> +}
>> +
>> +static void ch341_gpio_irq_disable(struct irq_data *data)
>> +{
>> +	struct ch341_gpio *dev = irq_data_get_irq_chip_data(data);
>> +
>> +	usb_unlink_urb(dev->irq_urb);
> 
> Same here...
> 
>> +}
>> +
>> +static int ch341_gpio_remove(struct platform_device *pdev)
>> +{
>> +	struct ch341_gpio *dev = platform_get_drvdata(pdev);
>> +
>> +	usb_kill_anchored_urbs(&dev->irq_urb_out);
> 
> You only have one URB...
> 
> And what prevents it from being resubmitted here?

I don't see what would resubmit it here. The gpio is being released.

Frank.
