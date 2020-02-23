From: Gabriel C <nix.or.die@gmail.com>
Subject: Re: [regression] nct6775 does not load in 5.4 and 5.5, bisected to b84398d6d7f90080
Date: Sun, 23 Feb 2020 18:56:58 +0100
Message-ID: <CAEJqkgipp7ZSerdsqpJKvrfuDQUSYFoUvYwjWCRRA2QS_8Ye_w@mail.gmail.com>
References: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Martin Volf <martin.volf.42@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Am Sa., 22. Feb. 2020 um 12:13 Uhr schrieb Martin Volf
<martin.volf.42@gmail.com>:
>
> Hello,
>

Hello,

> git bisect found out the first bad commit is
> b84398d6d7f900805662b1619223fd644d862d7c,i801_probe
> i2c: i801: Use iTCO version 6 in Cannon Lake PCH and beyond
>
> Unfortunately I am not able to revert it in v5.4 to confirm it is really
> the culprit.

I don't think you need to revert that to test, just move back
Cannon Lake to use iTCO Version 4 in i801_probe().

Something like this:

https://crazy.dev.frugalware.org/CANNONLAKE-use-iTCO-ver4.patch

BR,

Gabriel C
