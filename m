From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] DT: i2c: Add Epson RX8010 to list of trivial devices
Date: Sun, 27 Dec 2015 17:02:48 +0200
Message-ID: <CAHp75VfakA8SykeMSxAKJiDpge9xtMLk=dcemuw=9uU81pk2Lw@mail.gmail.com>
References: <1450895938-21631-1-git-send-email-akshay.bhat@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450895938-21631-1-git-send-email-akshay.bhat-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akshay Bhat <akshay.bhat-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
Cc: ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, justin.waters-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 23, 2015 at 8:38 PM, Akshay Bhat <akshay.bhat-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org> wrote:
> This adds devicetree documentation for the bindings of rtc-rx8010
> driver.
>
> Signed-off-by: Akshay Bhat <akshay.bhat-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index c50cf13..0f9c1de 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -49,6 +49,7 @@ dallas,ds4510         CPU Supervisor with Nonvolatile Memory and Programmable I/O
>  dallas,ds75            Digital Thermometer and Thermostat
>  dlg,da9053             DA9053: flexible system level PMIC with multicore support
>  dlg,da9063             DA9063: system PMIC for quad-core application processors
> +epson,rx8010           I2C-BUS INTERFACE REAL TIME CLOCK MODULE

Is it indeed required to have all those capital letters together?

>  epson,rx8025           High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
>  epson,rx8581           I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>  fsl,mag3110            MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
> --
> 2.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
