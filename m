From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/15] i2c: Add Device Tree support to the Nomadik I2C driver
Date: Wed, 20 Jun 2012 21:30:17 +0200
Message-ID: <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew@mail.gmail.com>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
	<1340197011-5435-8-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340197011-5435-8-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 20, 2012 at 2:56 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:

> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver. We also apply a fall-back
> configuration in case either one is not provided, or a required
> element is missing from the one supplied.
>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Pls Cc Srinidhi on these patches, and I would prefer to get his ACK on =
this.

Srinidhi, could you propose a patch to MAINTAINERS adding yourself as
explicit maintainer for this driver?

> +static struct nmk_i2c_controller u8500_i2c =3D {
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Slave data setup time; 250ns, 100ns, and 10ns, whi=
ch
> + =A0 =A0 =A0 =A0* is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 .slsu =A0 =A0 =A0 =A0 =A0 =3D 0xe,
> + =A0 =A0 =A0 .tft =A0 =A0 =A0 =A0 =A0 =A0=3D 1, =A0 =A0 =A0/* Tx FIF=
O threshold */
> + =A0 =A0 =A0 .rft =A0 =A0 =A0 =A0 =A0 =A0=3D 8, =A0 =A0 =A0/* Rx FIF=
O threshold */
> + =A0 =A0 =A0 .clk_freq =A0 =A0 =A0 =3D 100000, /* std. mode operatio=
n */

As per earlier discussion, change this default value to 400000.

> + =A0 =A0 =A0 .timeout =A0 =A0 =A0 =A0=3D 200, =A0 =A0/* Slave respon=
se timeout(ms) */
> + =A0 =A0 =A0 .sm =A0 =A0 =A0 =A0 =A0 =A0 =3D I2C_FREQ_MODE_FAST,
> +};

Thanks,
Lmims Walleij
