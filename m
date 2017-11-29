From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] dt-bindings: eeprom: rename to at24.txt
Date: Wed, 29 Nov 2017 10:11:29 +0100
Message-ID: <CAMuHMdVgypQUG5ApL9hNPb8Vyesb4+u_iQtJVDH412ALFq0WNA@mail.gmail.com>
References: <20171129090442.2865-1-wsa@the-dreams.de> <20171129090442.2865-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45785 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdK2JLa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 04:11:30 -0500
In-Reply-To: <20171129090442.2865-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

CC devicetree

On Wed, Nov 29, 2017 at 10:04 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> This binding documentation is for the at24 driver, so the filename
> should reflect it. This avoids confusion because we also have an
> "eeprom" driver in Linux but it doesn't support DT even.
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/eeprom/eeprom.txt
> rename to Documentation/devicetree/bindings/eeprom/at24.txt

Gr{oetje,eeting}s,

                        Geert
