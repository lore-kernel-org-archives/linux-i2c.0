From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 25 Apr 2017 12:21:04 +1000
Message-ID: <1493086864.25766.266.camel@kernel.crashing.org>
References: <20170424181818.2754-1-brendanhiggins@google.com>
         <20170424181818.2754-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50699 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964926AbdDYCWG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Apr 2017 22:22:06 -0400
In-Reply-To: <20170424181818.2754-5-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Mon, 2017-04-24 at 11:18 -0700, Brendan Higgins wrote:
> +static int __aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> +                                struct platform_device *pdev)
> +{

Minor nit ... I'm really not fan of those underscores.

We use __ functions in some cases in the kernel for low level
helpers, usually when it's a low level variant of an existing
function or an "unlocked" variant, but I don't think generalizing
it to pretty much everything in the driver is worthwhile here.

If you want to be explicit about locking, I would suggest you
use a comment in front of the function explaining if it
expects to be called with the lock held.

We tend to only do that when *both* functions exist and one is
implemented in term of the other.

Cheers,
Ben.
