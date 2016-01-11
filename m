From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 5/6] Add Advantech iManager Backlight driver
Date: Mon, 11 Jan 2016 10:23:02 +0000
Message-ID: <20160111102302.GV14104@x1>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-6-git-send-email-richard.dorsch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35484 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869AbcAKKXG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Jan 2016 05:23:06 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so205116214wmf.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 Jan 2016 02:23:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452468675-5827-6-git-send-email-richard.dorsch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net, wim@iguana.be, jo.sunga@advantech.com

On Sun, 10 Jan 2016, richard.dorsch@gmail.com wrote:

> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
>=20
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>  drivers/video/backlight/Kconfig          |  12 ++
>  drivers/video/backlight/Makefile         |   2 +
>  drivers/video/backlight/imanager-bl.c    | 198 +++++++++++++++++++++=
++++++++++
>  drivers/video/backlight/imanager-ec-bl.c | 118 ++++++++++++++++++
>  include/linux/mfd/imanager/backlight.h   |  37 ++++++
>  5 files changed, 367 insertions(+)
>  create mode 100644 drivers/video/backlight/imanager-bl.c
>  create mode 100644 drivers/video/backlight/imanager-ec-bl.c
>  create mode 100644 include/linux/mfd/imanager/backlight.h

How do you expect this to be reviewed if you don't send it to the
reviewer?

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
