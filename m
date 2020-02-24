From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 03/89] i2c: brcmstb: Support BCM2711 HDMI BSC controllers
Date: Mon, 24 Feb 2020 09:44:56 -0800
Message-ID: <da7943a6-8fcc-6c79-e54e-c8d59dacf24c@gmail.com>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <1ed75ec6dc9310afd768c0bbfd8e73268e8cdfa9.1582533919.git-series.maxime@cerno.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42181 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgBXRpE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Feb 2020 12:45:04 -0500
In-Reply-To: <1ed75ec6dc9310afd768c0bbfd8e73268e8cdfa9.1582533919.git-series.maxime@cerno.tech>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Maxime Ripard <maxime@cerno.tech>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, Tim Gover <tim.gover@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2/24/20 1:06 AM, Maxime Ripard wrote:
> The HDMI blocks in the BCM2771 have an i2c controller to retrieve the
> EDID. This block is split into two parts, the BSC and the AUTO_I2C,
> lying in two separate register areas.
> 
> The AUTO_I2C block has a mailbox-like interface and will take away the
> BSC control from the CPU if enabled. However, the BSC is the actually
> the same controller than the one supported by the brcmstb driver, and
> the AUTO_I2C doesn't really bring any immediate benefit.
> 
> Let's use the BSC then, but let's also tie the AUTO_I2C registers with a
> separate compatible so that we can enable AUTO_I2C if needed in the
> future.
> 
> The AUTO_I2C is enabled by default at boot though, so we first need to
> release the BSC from the AUTO_I2C control.
> 
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

[snip]

> @@ -705,6 +737,7 @@ static SIMPLE_DEV_PM_OPS(brcmstb_i2c_pm, brcmstb_i2c_suspend,
>  static const struct of_device_id brcmstb_i2c_of_match[] = {
>  	{.compatible = "brcm,brcmstb-i2c"},
>  	{.compatible = "brcm,brcmper-i2c"},
> +	{.compatible = "brcm,bcm2711-hdmi-i2c"},

You could have added the bcm2711_release_bsc here as a function attached
with the of_device_id::data member of the structure and do:

if (data && data->init_func)
	rc = data->init_func(dev);

But we can defer that until we have a second compatible string that
requires the same approach.

Akked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
