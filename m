From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] eeprom/at24: use device_property_*() functions instead
 of of_get_property()
Date: Thu, 9 Feb 2017 23:30:42 +0200
Message-ID: <CAHp75VdmVcfzv0NUKJjAmb7Q5_s3+jNygSzAmj6Z=UX8O8s3BA@mail.gmail.com>
References: <1486654433-20148-1-git-send-email-gardner.ben@gmail.com> <201702100424.gYk6PzId%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35183 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbdBIVdQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 9 Feb 2017 16:33:16 -0500
In-Reply-To: <201702100424.gYk6PzId%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Ben Gardner <gardner.ben@gmail.com>, kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 9, 2017 at 10:35 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Ben,
>
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on v4.10-rc7 next-20170209]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Optimistic way of thinking: kbuild bot was fast enough.
Pessimistic: it wasn't too slow enough.

P.S. I think it against older version of the patch, thus, we may
safely ignore this.

>
> url:    https://github.com/0day-ci/linux/commits/Ben-Gardner/eeprom-at24-use-device_property_-functions-instead-of-of_get_property/20170210-025938
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/misc/eeprom/at24.c: In function 'at24_get_pdata':
>>> drivers/misc/eeprom/at24.c:580:7: error: 'chip' is a pointer; did you mean to use '->'?
>       chip.page_size = 1;
>           ^
>           ->
>
> vim +580 drivers/misc/eeprom/at24.c
>
>    574          } else {
>    575                  /*
>    576                   * This is slow, but we can't know all eeproms, so we better
>    577                   * play safe. Specifying custom eeprom-types via platform_data
>    578                   * is recommended anyhow.
>    579                   */
>  > 580                  chip.page_size = 1;
>    581          }
>    582  }
>    583
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
With Best Regards,
Andy Shevchenko
