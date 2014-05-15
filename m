From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: Fixup system suspend
Date: Thu, 15 May 2014 09:15:06 +0200
Message-ID: <CAPDyKFqxa3ZveRUWseT25cSOcn-6vUVBR0q515qsha1z0WfdNQ@mail.gmail.com>
References: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
	<CACRpkdb8VJ_Qqype4uP_YJ5=RncJndFUZv_yDxmZwq5S=_yZ2g@mail.gmail.com>
	<CAPDyKFo6K-mbtKcs8wPmc=E-t=Djs-ufi_+SLLpCKej+bEwbDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFo6K-mbtKcs8wPmc=E-t=Djs-ufi_+SLLpCKej+bEwbDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6 May 2014 11:31, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 10 April 2014 20:49, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Thu, Apr 10, 2014 at 3:59 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>
>>> For !CONFIG_PM_RUNTIME, the device were never put back into active
>>> state while resuming.
>>>
>>> For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
>>> while we were about to handle it at suspend late, which is just too
>>> optimistic.
>>>
>>> Even if the driver uses pm_runtime_put_sync() after each tranfer to
>>> return it's runtime PM resources, there are no guarantees this will
>>> actually mean the device will inactivated. The reason is that the PM
>>> core will prevent runtime suspend during system suspend, and thus when
>>> a transfer occurs during the early phases of system suspend the device
>>> will be kept active after the transfer.
>>>
>>> To handle both issues above, use pm_runtime_force_suspend|resume() from
>>> the system suspend|resume callbacks.
>>>
>>> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
>>> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Hi Wolfram,
>
> This patch as has been around for a while (in some other versions as
> well), would you mind picking it up for 3.16?
>

Ping.

I noticed you merged my other i2c-nomadik patch yesterday - thought I
might remind you about this one as well.

Kind regards
Ulf Hansson
