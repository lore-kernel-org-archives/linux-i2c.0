From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 00/12] i2c: meson: series with improvements
Date: Wed, 8 Mar 2017 21:49:15 +0100
Message-ID: <a809a238-11fe-410b-fee8-a941109d49b9@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
 <1488965640.2514.14.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35593 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdCHVAI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 16:00:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id z63so8013576wmg.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 12:58:31 -0800 (PST)
In-Reply-To: <1488965640.2514.14.camel@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 08.03.2017 um 10:34 schrieb Jerome Brunet:
> On Wed, 2017-03-08 at 07:41 +0100, Heiner Kallweit wrote:
>> This patch series includes several improvements for the i2c-meson
>> driver.
> 
> Heiner, Could give us a some details about how you tested this series (platform,
> board, i2c devices, exemple of transfers, etc ...). The more details you give,
> the easiest it is to be confident about the patches.
> 
Sure. System is Odroid C2 and I test with a DS3231-based RTC module connected
to I2C-A (driver rtc-ds1307). Bus speed is set to 400 kHz.

That's the debug messages (with the patch series applied) from the interrupt
handler when booting the system and setting the system clock from RTC.

meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 2, ctrl 07869251
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 2, ctrl 07869051
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 8, ctrl 078698b1
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 7, ctrl 078697a1
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 7, ctrl 078697a1
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 7, ctrl 078697a1
meson-i2c c1108500.i2c: irq: state 2, pos 0, count 1, ctrl 05869031
meson-i2c c1108500.i2c: irq: state 1, pos 0, count 1, ctrl 07869141


> Personally, I don't have test case representative enough to test this series
> thoroughly.
> 
>>
>> Heiner Kallweit (12):
>>   i2c: meson: use min instead of min_t where min_t isn't needed
>>   i2c: meson: remove member irq from struct meson_i2c
>>   i2c: meson: use i2c core for DT clock-frequency parsing
>>   i2c: meson: use full 12 bits for clock divider
>>   i2c: meson: set clock divider in probe instead of setting it for each
>> transfer
>>   i2c: meson: remove variable count from meson_i2c_xfer
>>   i2c: meson: improve interrupt handler and detect spurious interrupts
>>   i2c: meson: explicitly ignore messages with length zero
>>   i2c: meson: don't create separate token chain just for the stop command
>>   i2c: meson: remove meson_i2c_write_tokens
>>   i2c: meson: improve and simplify interrupt handler
>>   i2c: meson: use state in meson_i2c_prepare_xfer
>>
>>  drivers/i2c/busses/i2c-meson.c | 157 ++++++++++++++++----------------------
>> ---
>>  1 file changed, 62 insertions(+), 95 deletions(-)
>>
> 
