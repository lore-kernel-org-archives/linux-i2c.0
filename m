From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH] hwmon/ltc2990: Generalise DT to fwnode support
Date: Fri, 16 Aug 2019 14:26:24 +0200
Message-ID: <79f1e829-8fd4-6690-e429-f5b3d1a7c0bd@enpas.org>
References: <5b9b4383-c1e9-91a6-8ab6-8f831b362dca@enpas.org>
 <20190816090731.12809-1-max@enpas.org>
 <CAMuHMdUE_3UEzOv3pmryMwuMRF7RC9-xTG8sXUbpR=r5fKUjrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUE_3UEzOv3pmryMwuMRF7RC9-xTG8sXUbpR=r5fKUjrg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On 08/16/2019 01:07 PM, Geert Uytterhoeven wrote:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you!


> One minor nit: as the driver no longer uses any of_*() symbols, you can replace
> #include <linux/of.h> by #include <linux/property.h>.

I should have thought of that, sorry.

Another patch, or will you do it?


Max
