From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
Date: Mon, 14 May 2012 09:45:16 +0100
Message-ID: <4FB0C61C.9020509@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-12-git-send-email-lee.jones@linaro.org> <20120511101233.GH1214@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120511101233.GH1214@sortiz-mobl>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sam,

> On Fri, May 04, 2012 at 07:23:21PM +0100, Lee Jones wrote:
>> This patch will allow the ab8500-core driver to be probed and set up
>> when booting when Device Tree is enabled. This includes platform ID
>> look-up which identifies the machine it is currently running on. If
>> we are undergoing a DT enabled boot, we will refuse to setup each of
>> the other ab8500-* devices, as they will be probed individually by D=
T.
> This one doesn't apply to my for-next branch. Which tree/branch did y=
ou use to
> generate it ?

I've been using the latest Mainline -rc, but one of my first jobs today=
=20
is to rebase this patch-set against -next and resubmit.

Sorry for any confusion caused.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
