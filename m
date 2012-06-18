From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device
 Tree for DB8500 based devices
Date: Mon, 18 Jun 2012 12:37:53 +0100
Message-ID: <4FDF1311.1050207@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com> <4FD8BAE4.4050606@linaro.org> <CACRpkda2pH1by2hajpP20CJgdg+mWFF=QaGbeNdY=c8iOVtLUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkda2pH1by2hajpP20CJgdg+mWFF=QaGbeNdY=c8iOVtLUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 18/06/12 12:29, Linus Walleij wrote:
> On Wed, Jun 13, 2012 at 6:08 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wro=
te:
>
>> +                       clock-frequency =3D<100000>;
>> +                       stericsson,slsu =3D<0xe>;
>> +                       stericsson,tft =3D<1>;
>> +                       stericsson,rft =3D<8>;
>> +                       stericsson,timeout =3D<200>;
>> +                       stericsson,i2c_freq_mode_fast;
>
> In the context of my patch to the board file, we conclude that the
> clock-frequency should be set to 400000 instead.

Right, I have already changed that in my patch-set.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
