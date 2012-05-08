From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/15] drivers/regulator: ab8500: Split up probe() into
 manageable pieces
Date: Tue, 08 May 2012 12:08:36 +0100
Message-ID: <4FA8FEB4.2030201@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-13-git-send-email-lee.jones@linaro.org> <20120507165838.GN17002@opensource.wolfsonmicro.com> <CAF2Aj3h7pgh=Kbt+M5Xd_RDRbJN7K+WbaH1+8nM2Eakb1QNpsg@mail.gmail.com> <20120507184453.GQ17002@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120507184453.GQ17002-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/05/12 19:44, Mark Brown wrote:
> On Mon, May 07, 2012 at 07:04:59PM +0100, Lee Jones wrote:
>> On 7 May 2012 17:58, Mark Brown<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>=
  wrote:
>
>>> This doesn't apply against current regulator code.
>
>> It doesn't? I rebased it onto -rc5 which was the latest at time of
>> submission.
>
> This isn't a bugfix that should be rushed into Linus' tree for 3.4!
> You're missing the best part of a release cycle of development here,
> including at least one incompatible API change.
>
> If you're developing new code you should always submit against the tr=
ee
> it's supposed to be applied to; as a rule of thumb -next is a good
> approximation though subsystems do things slightly differently,
> especially in the creation of topic branches.  Even where the code wi=
ll
> get applied to Linus' tree then merged as a new topic branch you shou=
ld
> verify that there aren't any other changes in -next that affect it (e=
g,
> an API you rely on having changed or other changes to the same file
> which conflict with yours).

Okay, I will pull these patches out of the patch-set and rebase them=20
against -next before re-sending.

>>> Please also at least
>>> try to use changelogs that match the subsystem you're submitting
>>> against.
>
>> What do you mean? Isn't "drivers/regulator" in the subject line enou=
gh?
>
> As I said you should use changelogs that match the subsystem you are
> submitting against.  Essentially nothing in the regulator tree uses
> this, as you should be able to see from inspection of the changelogs:
>
> $ git shortlog next/master drivers/regulator | wc -l
> 1059
> $ git shortlog drivers/regulator | grep drivers/regulator | wc -l
> 6
>
> Generally everything uses "regulator: ".  You should always make an
> effort to do this for whatever subsystem you're working with.

I am happy to change the subject line to make you happy. :)

I'll make the requested changes and re-send early next week - as I'm of=
f=20
this week.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
