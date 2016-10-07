From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PULL REQUEST] i2c for 4.9
Date: Fri, 7 Oct 2016 12:59:34 +0200
Message-ID: <CAMpxmJWmy7hCL5zueVfWoz_OL3zh=rob10hY1qyswVtd=Esd=g@mail.gmail.com>
References: <20161007093226.GA2058@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37092 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbcJGK7f (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 7 Oct 2016 06:59:35 -0400
Received: by mail-it0-f52.google.com with SMTP id z65so3485547itc.0
        for <linux-i2c@vger.kernel.org>; Fri, 07 Oct 2016 03:59:35 -0700 (PDT)
In-Reply-To: <20161007093226.GA2058@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2016-10-07 11:32 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> Linus,
>
> here is the 4.9 pull request from I2C including:
>
> * centralized error messages when registering to the core
> * improved lockdep annotations to prevent false positives
> * DT support for muxes, gates, and arbitrators
> * bus speeds can now be obtained from ACPI
> * i2c-octeon got refactored and now supports ThunderX SoCs, too
> * i2c-tegra and i2c-designware got a bigger bunch of updates
> * a couple of standard driver fixes and improvements
>
> Please pull.
>
> Thanks,
>
>    Wolfram
>
>
> The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:
>
>   Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.9
>
> for you to fetch changes up to 662786a5429c3a992c6f884a647ee32424822358:
>
>   i2c: axxia: disable clks in case of failure in probe (2016-09-24 11:26:55 +0200)
>
> ----------------------------------------------------------------
> Alexey Khoroshilov (1):
>       i2c: axxia: disable clks in case of failure in probe
>
> Andy Shevchenko (2):
>       i2c: core: put literals on one line in dev_*() calls
>       i2c: i801: Add support for Kaby Lake PCH-H
>
> Bartosz Golaszewski (5):
>       eeprom: at24: check if the chip is functional in probe()
>       i2c: export i2c_adapter_depth()
>       lockdep: make MAX_LOCKDEP_SUBCLASSES unconditionally visible
>       i2c: add a warning to i2c_adapter_depth()
>       gpio: pca953x: fix an incorrect lockdep warning
>

Hi Wolfram,

I see you didn't pick up the follow-up patch ("gpio: pca953x: add a
comment explaining the need for a lockdep subclass"). Linus acked it
in the end and I'd really prefer for it to go into 4.9, as I don't
know if I'll have time to complete the solution for the lockdep issue
in the next development cycle. Without this explanation, the random
lockdep_set_subclass() call looks out of place.

Thanks,
Bartosz
