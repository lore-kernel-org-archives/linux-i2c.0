From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 28 Mar 2017 19:57:50 +1100
Message-ID: <1490691470.3177.114.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46602 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755118AbdC1I65 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Mar 2017 04:58:57 -0400
In-Reply-To: <20170328051226.21677-5-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:
> +/* 0x04 : I2CD Clock and AC Timing Control Register #1 */
> +#define ASPEED_I2CD_TIME_SCL_HIGH_SHIFT                        16
> +#define ASPEED_I2CD_TIME_SCL_HIGH_MASK                 GENMASK(19, 16)
> +#define ASPEED_I2CD_TIME_SCL_LOW_SHIFT                 12
> +#define ASPEED_I2CD_TIME_SCL_LOW_MASK                  GENMASK(15, 12)
> +#define ASPEED_I2CD_TIME_BASE_DIVISOR_MASK             GENMASK(3, 0)
> +#define ASPEED_I2CD_TIME_SCL_REG_MAX                   GENMASK(3, 0)
> +/* 0x08 : I2CD Clock and AC Timing Control Register #2 */
> +#define ASPEED_NO_TIMEOUT_CTRL                         0

Those are slightly different between the 2400 and 2500, allowing
slightly more fine grained settings (faster base clock and thus higher
numbers in high/low counts).

I *think* that using the 2400 values as-is might work ok, at least
it does for 100kHz but I would double check.

I'll review the rest tomorrow.

Cheers,
Ben.
