From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/5]  i2c: meson-axg: add I2C controller driver
Date: Tue, 16 Jan 2018 16:28:43 -0800
Message-ID: <7ho9ltba6c.fsf@baylibre.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:40484 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeAQA24 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 19:28:56 -0500
Received: by mail-pg0-f43.google.com with SMTP id g16so3740860pgn.7
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jan 2018 16:28:56 -0800 (PST)
In-Reply-To: <20171120145415.6581-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Mon, 20 Nov 2017 22:54:10 +0800")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Yixun Lan <yixun.lan@amlogic.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Wolfram,

Yixun Lan <yixun.lan@amlogic.com> writes:

> This patch set try to add I2C controller driver for
> the Amlogic's Meson-AXG SoC.
>
> Changes since v1 [1]
>  - update dt-bindings doc (Neil Armstrong)
>  - make meson_i2c_data const (Martin Blumenstingl)
>  - DTS: adjust naming, change from the 'i2c_m0' to 'i2c0' style
>
> [1] http://lkml.kernel.org/r/20171117080236.32504-1-yixun.lan@amlogic.com
>
> Jian Hu (5):
>   dt-bindings: i2c: update documentation for the Meson-AXG
>   i2c: meson: add configurable divider factors

Could you have a look at these two patches?  They've been
acked/reviewed/tested and are just waiting your review/merge.

>   ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
>   ARM64: dts: meson-axg: describe pin DT info for I2C controller
>   ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

Once you've merged, I'll take the DT patches through my amlogic tree.

Thanks,

Kevin
