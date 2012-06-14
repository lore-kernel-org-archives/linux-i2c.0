From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
 for DB8500 based devices
Date: Thu, 14 Jun 2012 19:13:02 +0200
Message-ID: <CACRpkdaxoQGukJHy_JUKGu5CRFq5=9NcR-jqjPetMp85kAa-iQ@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
	<1339428307-3850-10-git-send-email-lee.jones@linaro.org>
	<CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
	<4FD8BAE4.4050606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FD8BAE4.4050606-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2012 at 6:08 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Wed, 13 Jun 2012 16:21:14 +0100
> Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device=
 Tree
> =A0for DB8500 based devices
>
> For correct operation of the i2c-nomadik driver, it requires some
> information surrounding clock-frequencies, delay times and thresholds=
=2E
> Here we apply those configurations to be used when a platform is
> booted via the device Tree.
>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Splendid,
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
