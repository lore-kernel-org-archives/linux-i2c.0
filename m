From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c
 driver
Date: Thu, 7 Aug 2014 15:18:42 +0200
Message-ID: <20140807151842.1dddaf24@ipc1.ka-ro>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
	<1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
	<41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
	<14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
	<31f8f5504fc24d999f5af74338602bed@BLUPR03MB373.namprd03.prod.outlook.com>
	<c9727eaf22dc40f796793c6b127dfb9e@BL2PR03MB338.namprd03.prod.outlook.com>
	<6537011f698c4c7faaf5b66b870afbd2@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6537011f698c4c7faaf5b66b870afbd2-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> From: Yuan Yao-B46683 Data: Thursday, August 07, 2014 4:05 PM
> >To: Duan Fugang-B38611; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org
> >Cc: LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; shawn.guo@linaro.o=
rg;
> >linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; =
linux-
> >i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596
> >Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale =
i2c
> >driver
> >
> >Hi Fugang,
> >
> >> >> >+	/* Waiting for Transfer complete. */
> >> >> >+	while (timeout--) {
> >> >> >+		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >> >> >+		if (temp & I2SR_ICF)
> >> >> >+			break;
> >> >> >+		udelay(10);
> >> >> >+	}
> >> >> Whether there have better method like interrupt to avoid dead w=
ait
> >> >> here until timeout ?
> >> >
> >> >Can you give me more suggestion? We have discussed it with our te=
am,
> >> >It seems the short query wait is necessary.
> >> >
> >> At least, you can use schdule_timeout() instead of udelay() ?
> >
> >In fact, the waiting time normally is less than 10-50us, but the min=
imum
> >time interval for schdule_timeout() is 1 jiffies.
> >So maybe schdule_timeout() is not very necessary?
> >
> Oh, if the waiting time is 10 ~ 50us, you can use usleep_range(10, 50=
).
>
The loop is not meant to generate a certain delay, but to wait for some
HW flag to change within a certain time frame. So usleep_range() is
rather inadequate here!


But looking a little closer at the function, the timeout value seems to
be rather bogus to me. The loop counter 'timeout' is initialized from=20
the constant IMX_I2C_DMA_TIMEOUT which is also used in
|wait_for_completion_interruptible_timeout(
|                               &i2c_imx->dma->cmd_complete,
|                               msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
 				                 ^^^^^^^^^^^^^^^^^^^
as a number of milliseconds to wait for DMA completion.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
