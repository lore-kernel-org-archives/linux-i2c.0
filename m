From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] i2c: at91: support atomic write xfer
Date: Sun, 15 Mar 2020 23:46:33 +0300
Message-ID: <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
References: <c05f76f74cd6a7ec2735c96861f9d5933631c112.1584296795.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39509 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgCOUqi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 15 Mar 2020 16:46:38 -0400
In-Reply-To: <c05f76f74cd6a7ec2735c96861f9d5933631c112.1584296795.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

15.03.2020 21:27, Michał Mirosław пишет:
> Implement basic support for atomic write - enough to get a simple
> write to PMIC on shutdown. Only for chips having ALT_CMD register,
> eg. SAMA5D2.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---

Hello Michał,

...
> +	ret = pm_runtime_get_sync(dev->dev);
> +	if (ret < 0)
> +		goto out;

Runtime PM can't be used while interrupts are disabled, unless
pm_runtime_irq_safe() is used and driver's RPM callback is IRQ-safe.

...
> +	timeout = jiffies + (2 + msg->len) * HZ/1000;
> +	for (;;) {
> +		stat = at91_twi_read(dev, AT91_TWI_SR);
> +		if (stat & AT91_TWI_TXCOMP)
> +			break;
> +		if (time_after(jiffies, timeout)) {
> +			ret = -ETIMEDOUT;
> +			goto out;
> +		}
> +		udelay(100);
> +	}

Jiffies can't be used with the disabled interrupts because jiffies are
updated by timer's interrupt.

Either ktime() API or iterator-based loop should be used.
