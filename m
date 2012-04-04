From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv5 16/18] I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153
Date: Wed, 4 Apr 2012 23:15:19 +0530
Message-ID: <CAM=Q2cu8k8n2w8_=8VCFcFTTgywqc_Vk_eM_DDTap3YeYyAH2g@mail.gmail.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
	<1333468957-5999-17-git-send-email-shubhrajyoti@ti.com>
	<4F7C7780.7040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F7C7780.7040807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, Tasslehoff Kjappfot <tasskjapp@gmail.com>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,


>> + =A0 =A0 =A0 if (dev->flags& =A0OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->errata |=3D I2C_OMAP_ERRATA_I207;
>> +
>> =A0 =A0 =A0 =A0if (dev->rev<=3D OMAP_I2C_REV_ON_3430_3530)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->errata |=3D I2C_OMAP3_1P153;
>
>
> The errata ID is not correct. I believe that 1P153 is referring to th=
e
> section number in the errata doc and not the errata ID. The errata ID=
 should
> be i451 in the latest OMAP34xx and OMAP36xx docs.
>
> Please can you update this? The section number changed in the latest =
errata
> docs and it took me a minute to find this.

Do you mind if that is a separate patch?

>
> Cheers
> Jon
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
