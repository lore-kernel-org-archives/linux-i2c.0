From: Peter Rosin <peda@axentia.se>
Subject: struct i2c_mux_pinctrl_platform_data for the i2c-mux-pinctrl driver
Date: Mon, 22 May 2017 10:24:48 +0200
Message-ID: <264eee82-8e0f-7d63-5c2f-e4070bf56c63@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:61360
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752343AbdEVIZA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 22 May 2017 04:25:00 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Stephen,

I was looking at the i2c-mux-pinctrl driver and noticed that it has
code to feed it platform data from C code. There has never been any
in-kernel users of this interface and I would like to remove it. I
wonder if you added it way back when just because the i2c-mux-gpio
driver have such an interface or if, to your knowledge, any external
platform exists that depends on this?

I.e. I'm talking about removing include/linux/i2c-mux-pinctrl.h and
the code supporting it in the driver, thus only allowing devicetree
as source for the platform data.

Cheers,
peda
