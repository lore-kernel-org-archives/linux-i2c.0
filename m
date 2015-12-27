From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] DT: i2c: Update vendor prefix for 24c00
Date: Sun, 27 Dec 2015 16:57:48 +0200
Message-ID: <CAHp75VfvLJu+aL233izR3jh7UQg7ewEmS2Z3EhAg2WPZ9s1gyg@mail.gmail.com>
References: <1450898335-22814-1-git-send-email-akshay.bhat@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35463 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbL0O5t (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 27 Dec 2015 09:57:49 -0500
In-Reply-To: <1450898335-22814-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: ktsai@capellamicro.com, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, justin.waters@timesys.com

On Wed, Dec 23, 2015 at 9:18 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> "at" is not a valid vendor prefix, correcting the same to "atmel"
>

I'm afraid you can't just do this change alone as it's used in some
DTS. Though you may deprecated it along with update of current users.

> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index c50cf13..c4a01c0 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -20,11 +20,11 @@ adi,adt7476         +/-1C TDM Extended Temp Range I.C
>  adi,adt7490            +/-1C TDM Extended Temp Range I.C
>  adi,adxl345            Three-Axis Digital Accelerometer
>  adi,adxl346            Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
> -at,24c08               i2c serial eeprom  (24cxx)
>  atmel,24c00            i2c serial eeprom  (24cxx)
>  atmel,24c01            i2c serial eeprom  (24cxx)
>  atmel,24c02            i2c serial eeprom  (24cxx)
>  atmel,24c04            i2c serial eeprom  (24cxx)
> +atmel,24c08            i2c serial eeprom  (24cxx)
>  atmel,24c16            i2c serial eeprom  (24cxx)
>  atmel,24c32            i2c serial eeprom  (24cxx)
>  atmel,24c64            i2c serial eeprom  (24cxx)
> --
> 2.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
