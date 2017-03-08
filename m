From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/12] i2c: meson: series with improvements
Date: Wed, 08 Mar 2017 10:34:00 +0100
Message-ID: <1488965640.2514.14.camel@baylibre.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36303 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdCHNoH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 08:44:07 -0500
Received: by mail-wr0-f176.google.com with SMTP id u108so23533106wrb.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 05:43:04 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-03-08 at 07:41 +0100, Heiner Kallweit wrote:
> This patch series includes several improvements for the i2c-meson
> driver.

Heiner, Could give us a some details about how you tested this series (platform,
board, i2c devices, exemple of transfers, etc ...). The more details you give,
the easiest it is to be confident about the patches.

Personally, I don't have test case representative enough to test this series
thoroughly.

> 
> Heiner Kallweit (12):
>   i2c: meson: use min instead of min_t where min_t isn't needed
>   i2c: meson: remove member irq from struct meson_i2c
>   i2c: meson: use i2c core for DT clock-frequency parsing
>   i2c: meson: use full 12 bits for clock divider
>   i2c: meson: set clock divider in probe instead of setting it for each
> transfer
>   i2c: meson: remove variable count from meson_i2c_xfer
>   i2c: meson: improve interrupt handler and detect spurious interrupts
>   i2c: meson: explicitly ignore messages with length zero
>   i2c: meson: don't create separate token chain just for the stop command
>   i2c: meson: remove meson_i2c_write_tokens
>   i2c: meson: improve and simplify interrupt handler
>   i2c: meson: use state in meson_i2c_prepare_xfer
> 
>  drivers/i2c/busses/i2c-meson.c | 157 ++++++++++++++++----------------------
> ---
>  1 file changed, 62 insertions(+), 95 deletions(-)
> 
