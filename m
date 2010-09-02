From: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Thu, 2 Sep 2010 15:17:41 -0700
Message-ID: <AANLkTinQ9nWP2a1bdhAv+r58nHoYKzgttj--7H+aOnqB@mail.gmail.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<4C6168E9.1070405@compulab.co.il>
	<AANLkTimd2D+_xQ_CH-e+jgn+rZgMpJY6Zkc-SSVdFzMt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimd2D+_xQ_CH-e+jgn+rZgMpJY6Zkc-SSVdFzMt-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 2, 2010 at 2:54 PM, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, Aug 10, 2010 at 7:57 AM, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> =
wrote:
>> Hi Colin,
>> Two more comments.
>>
>> Colin Cross wrote:
>>>
>>> From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
>>>
>>> CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>> =A0drivers/i2c/busses/Kconfig =A0 =A0 | =A0 =A07 +
>>> =A0drivers/i2c/busses/Makefile =A0 =A0| =A0 =A01 +
>>> =A0drivers/i2c/busses/i2c-tegra.c | =A0665
>>> ++++++++++++++++++++++++++++++++++++++++
>>> =A0include/linux/i2c-tegra.h =A0 =A0 =A0| =A0 25 ++
>>
>> This should probably go to arch/arm/mach-tegra/include/mach/ to mini=
mize the
>> pollution in include/linux
> The existing standard seems to be to use include/linux
>
>>> =A04 files changed, 698 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 drivers/i2c/busses/i2c-tegra.c
>>> =A0create mode 100644 include/linux/i2c-tegra.h
>>>
>>
>> [ snip ]
>>
>>> +
>>> +static int __init tegra_i2c_init_driver(void)
>>> +{
>>> + =A0 =A0 =A0 return platform_driver_register(&tegra_i2c_driver);
>>> +}
>>> +module_init(tegra_i2c_init_driver);
>>
>> subsys_initcall would be better here.
> This can be compiled as a module, subsys_initcall would break that.
I stand corrected - subsys_initcall becomes module_init if it's
compiled as a module.  I'll fix it.
