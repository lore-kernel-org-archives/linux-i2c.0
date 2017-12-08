From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH RESEND v6 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Fri, 8 Dec 2017 17:01:47 +0100
Message-ID: <CAMRc=Mdt1uX5VHdy4xYYNTFWba0vOWP-syY0uoDjZaEGvCwnhA@mail.gmail.com>
References: <1512747445-5817-1-git-send-email-svendev@arcx.com> <1512747445-5817-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36173 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbdLHQBt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 11:01:49 -0500
Received: by mail-ot0-f195.google.com with SMTP id d5so9524589oti.3
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 08:01:48 -0800 (PST)
In-Reply-To: <1512747445-5817-3-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

2017-12-08 16:37 GMT+01:00 Sven Van Asbroeck <svendev@arcx.com>:
> Adds an optional property for at24 eeproms.
> This parameterless property indicates that the multi-address eeprom
> does not automatically roll over reads to the next slave address.
>
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index 27f2bc1..5bfc0ac 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -38,6 +38,11 @@ Optional properties:
>
>    - size: total eeprom size in bytes
>
> +  - no-read-rollover:
> +                       This parameterless property indicates that the multi-address
> +                       eeprom does not automatically roll over reads to the next
> +                       slave address. Please consult the manual of your device.
> +
>  Example:
>
>  eeprom@52 {
> --
> 1.9.1
>

Ugh this patch doesn't apply because I already applied the patch from
Wolfram which renamed the bindings document from eeprom.txt to
at24.txt. Please send another version rebased on top of my at24/devel
branch. I didn't notice it before.

Thanks,
Bartosz
