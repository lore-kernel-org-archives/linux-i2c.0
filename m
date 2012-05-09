From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core driver
Date: Wed, 9 May 2012 11:02:27 +0200
Message-ID: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
	<1336155805-18554-12-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-12-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> This patch will allow the ab8500-core driver to be probed and set up
> when booting when Device Tree is enabled. This includes platform ID
> look-up which identifies the machine it is currently running on. If
> we are undergoing a DT enabled boot, we will refuse to setup each of
> the other ab8500-* devices, as they will be probed individually by DT=
=2E
>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
(...)
> + =A0 =A0 =A0 else if (np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_property_read_u32(np, "steri=
csson,irq-base", &ab8500->irq_base);
> +
> + =A0 =A0 =A0 if (ab8500->irq_base =3D=3D 0) {

Shouldn't this be (av8500->irq_base =3D=3D NO_IRQ) now that we're trani=
sitioning to
use 0 as NO_IRQ?

Apart from that it looks good to me:
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
