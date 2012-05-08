From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 08 May 2012 18:00:20 +0100
Message-ID: <4FA95124.5010309@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-15-git-send-email-lee.jones@linaro.org> <20120507170832.GO17002@opensource.wolfsonmicro.com> <4FA90BE1.3050304@linaro.org> <20120508121940.GL15893@opensource.wolfsonmicro.com> <4FA913BA.30908@linaro.org> <20120508133411.GP15893@opensource.wolfsonmicro.com> <4FA93391.8040905@linaro.org> <20120508145758.GV15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120508145758.GV15893-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/05/12 15:57, Mark Brown wrote:
> On Tue, May 08, 2012 at 03:54:09PM +0100, Lee Jones wrote:
>> On 08/05/12 14:34, Mark Brown wrote:
>
>>> Looking at the usage here it looks like most of this stuff shouldn'=
t be
>>> there even with non-DT stuff, we probably don't want to add DT bind=
ings
>>> for those bits.All the voltage setting is not at all device specifi=
c
>>> and can be done using the generic regulator bindings, the forcing o=
n or
>>> off is similarly generic.
>
>> All the generic properties _are_ set using the generic bindings. The
>> only vendor specific values are the initialisation register values
>> referenced above. I'll see what happens when I remove those from DT.
>> I have a feeling that the regulators will just fail though.
>
> The comments in the arch/arm file indicate otherwise - they were talk=
ing
> about enabling and disabling regulators, and about setting voltages. =
 It
> may be that the comments in the arch/arm code are inaccurate but with=
 it
> being magic numbers you'd really hope they're accurate...

=46ingers crossed. I'll let you know how I get on.

>>> While looking for the original patch I also noticed that you're not=
 CCing
>>> the mailing list either...  please always CC the subsystem mailing =
list
>>> on patches.
>
>> You don't appear to have one. I ran get_maintainer.pl on the patch
>> and the only ML it came up with was LKML. If you do have one, you
>> may need to update the MAINTAINERS file.
>
> LKML is the relevant list here.

Ah, okay. In retrospect I don't know why I didn't add it to be honest.=20
I'll endeavor to do so next time.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
