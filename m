From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C driver
Date: Mon, 11 Jun 2012 22:37:14 +0200
Message-ID: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
	<1339428307-3850-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339428307-3850-10-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:

> As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
(...)
> +static struct nmk_i2c_controller u8500_i2c =3D {
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* slave data setup time, which is
> + =A0 =A0 =A0 =A0* 250 ns,100ns,10ns which is 14,6,2
> + =A0 =A0 =A0 =A0* respectively for a 48 Mhz
> + =A0 =A0 =A0 =A0* i2c clock
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .slsu =A0 =A0 =A0 =A0 =A0 =3D 0xe,
> + =A0 =A0 =A0 /* Tx FIFO threshold */
> + =A0 =A0 =A0 .tft =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 /* Rx FIFO threshold */
> + =A0 =A0 =A0 .rft =A0 =A0 =A0 =A0 =A0 =A0=3D 8,
> + =A0 =A0 =A0 /* std. mode operation */
> + =A0 =A0 =A0 .clk_freq =A0 =A0 =A0 =3D 100000,
> + =A0 =A0 =A0 /* Slave response timeout(ms) */
> + =A0 =A0 =A0 .timeout =A0 =A0 =A0 =A0=3D 200,
> + =A0 =A0 =A0 .sm =A0 =A0 =A0 =A0 =A0 =A0 =3D I2C_FREQ_MODE_FAST,
> +};

So why don't we create proper device tree bindings for the above platfo=
rm
data?

=46or example several driver under
Documentation/devicetree/bindings/i2c/*
define the .clk_freq above as "clock-frequency"

samsung-i2c even has this:
samsung,i2c-sda-delay =3D <100>;
samsung,i2c-max-bus-freq =3D <100000>;

Where i2c-sda-delay corresponds to slsu above.

I suspect .sm can be derived from the frequency so it
is "FAST" whenever the frequency > 100000.

This looks to me like a way to push the burden of doing the real
device tree binding for the above to the next user.
(Which will likely be me, so therefore I care a bit ...)

Yours,
Linus Walleij
