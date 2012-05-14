From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 14 May 2012 21:38:27 +0100
Message-ID: <4FB16D43.2040301@linaro.org>
References: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ@mail.gmail.com> <20120514180619.GH25668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120514180619.GH25668-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 14/05/12 19:06, Mark Brown wrote:
> On Mon, May 14, 2012 at 06:39:00PM +0100, Lee Jones wrote:
>
>> Okay, so can you suggest a way to marry up the constraints found in =
DT to
>> the remainder of the settings found in the driver without pointlessl=
y
>> applying it all to the DT itself (which is was some of the other dri=
ves
>> have done)?
>
> That's what people are using regulator_of_match() for - it's for mapp=
ing
> the init data in DT array to a handle the driver can use for its
> internal data (and vice versa).  See how tps65910 is using it for an
> example.

Ah, I see it now. Looks like that's what I'm after.

I'll sort it out and try to get the new patch off tomorrow.

Thanks Mark.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
