From: Peter Rosin <peda@axentia.se>
Subject: Getting at gpio- and pinctrl-devices as a consumer
Date: Thu, 24 Nov 2016 22:35:32 +0100
Message-ID: <b481ed92-c9d2-b4da-b484-6d8bec6038f0@axentia.se>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana>
 <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
 <20161124195230.GA1666@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:8211
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750698AbcKYAKV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 19:10:21 -0500
In-Reply-To: <20161124195230.GA1666@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org

On 2016-11-24 20:52, Wolfram Sang wrote:
>> Yes, I never liked that include, but I don't know how to get
>> from struct gpio_desc * to the relevant struct device *
>> without it...
> 
> Looks to me like we should ask the GPIO maintainers if they are willing
> to export this value? I am probably not as good as you in explaining the
> details why, though...

Right. Adding Linus, Alexandre and the gpio list.

The background is that the gpio- and pinctrl-based i2c-mux drivers
need to know if the device that is used to control the mux of the
i2c-bus is also sitting on that very same i2c-bus. If it is, the
locking has to be different and a bit more relaxed. This relaxed
mode cannot be used always, as that would change the mux behavior
in an unacceptable way for stuff expecting the (traditional)
stricter locking. See Documentation/i2c/i2c-topology for more
details if you need it.

To check this, the i2c mux drivers dig out the device connected to
each gpio-pin (or pinctrl-state) and walks up the device tree to see
if the root i2c adapter that is muxed is in the loop.

When I wrote this code, I could not find a clean way to go from a
struct gpio_desc * to the relevant device, short of doing

	#include "../../gpio/gpiolib.h"

	gpio_dev = &gpio_desc->gdev->dev;

And similarly for pinctrl:

	#include "../../pinctrl/core.h"

	struct pinctrl_setting *setting;
	pinctrl_dev = setting->pctldev->dev;

I'm not very proud of that, and wonder if there is a better way
to get at the needed struct device? If not, then perhaps there
should be?

Cheers,
Peter
