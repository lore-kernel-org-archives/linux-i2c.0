From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Thu, 7 Aug 2014 10:01:05 +0000
Message-ID: <6537011f698c4c7faaf5b66b870afbd2@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
 <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
 <31f8f5504fc24d999f5af74338602bed@BLUPR03MB373.namprd03.prod.outlook.com>
 <c9727eaf22dc40f796793c6b127dfb9e@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c9727eaf22dc40f796793c6b127dfb9e-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>
Cc: "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Yuan Yao-B46683 Data: Thursday, August 07, 2014 4:05 PM
>To: Duan Fugang-B38611; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org
>Cc: LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
>linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-
>i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596
>Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c
>driver
>
>Hi Fugang,
>
>> >> >+	/* Waiting for Transfer complete. */
>> >> >+	while (timeout--) {
>> >> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>> >> >+		if (temp & I2SR_ICF)
>> >> >+			break;
>> >> >+		udelay(10);
>> >> >+	}
>> >> Whether there have better method like interrupt to avoid dead wait
>> >> here until timeout ?
>> >
>> >Can you give me more suggestion? We have discussed it with our team,
>> >It seems the short query wait is necessary.
>> >
>> At least, you can use schdule_timeout() instead of udelay() ?
>
>In fact, the waiting time normally is less than 10-50us, but the minimum
>time interval for schdule_timeout() is 1 jiffies.
>So maybe schdule_timeout() is not very necessary?
>
Oh, if the waiting time is 10 ~ 50us, you can use usleep_range(10, 50).
