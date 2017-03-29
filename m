From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c/muxes/i2c-mux-ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Wed, 29 Mar 2017 10:58:33 -0500
Message-ID: <20170329155833.6fop2ihbgy24c5b3@rob-hp-laptop>
References: <1490278978-28357-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34930 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbdC2P6g (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Mar 2017 11:58:36 -0400
Content-Disposition: inline
In-Reply-To: <1490278978-28357-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: michael.hennerich@analog.com
Cc: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 23, 2017 at 03:22:58PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds support for the Analog Devices / Linear Technology
> LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
> The LTC4306 optionally provides two general purpose input/output pins
> (GPIOs) that can be configured as logic inputs, opendrain outputs or
> push-pull outputs via the generic GPIOLIB framework.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |  61 ++++

It's preferred to split bindings to separate patch. In any case,

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   8 +
>  drivers/i2c/muxes/Kconfig                          |  10 +
>  drivers/i2c/muxes/Makefile                         |   1 +
>  drivers/i2c/muxes/i2c-mux-ltc4306.c                | 365 +++++++++++++++++++++
>  5 files changed, 445 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>  create mode 100644 drivers/i2c/muxes/i2c-mux-ltc4306.c
