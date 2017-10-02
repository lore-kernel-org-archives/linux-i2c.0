From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Date: Mon, 2 Oct 2017 17:11:00 +0100
Message-ID: <3100653b-21b7-0a84-6379-7c38e18e2dd6@codethink.co.uk>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
 <CACRpkdZ=BZHp3mjccUYaPTuMbXgwGSErvLprnp4j0H+7C5NYJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CACRpkdZ=BZHp3mjccUYaPTuMbXgwGSErvLprnp4j0H+7C5NYJQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, Vincent Sanders <vincent.sanders@collabora.co.uk>, Vincent Sanders <vince@kyllikki.org>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Magnus Damm <magnus.damm@gmail.com>, Heiko Schocher <hs@denx.de>
List-Id: linux-i2c@vger.kernel.org

On 02/10/17 02:05, Linus Walleij wrote:
> On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> - The MFD Silicon Motion SM501 is a special case. It dynamically
>>    spawns an I2C bus off the MFD using sm501_create_subdev().
>>    We use an approach to dynamically create a machine descriptor
>>    table and attach this to the "SM501-LOW" or "SM501-HIGH"
>>    gpiochip. We use chip-local offsets to grab the right lines.
>>    We can get rid of two local static inline helpers as part
>>    of this refactoring.
> (...)
>> SM501 users: requesting Tested-by on this patch.
> 
> Paging Simtec (if it reaches anyone), Vincent Sanders,
> Teddy Wang at Silicon Motion:

I'm fairly sure Simtec is not currently active. See below.
I have no idea if the SM501 is even available for current designs.

> Does any of you have an "Anubis" board so you can test GPIO
> on this board before/after this patch and see if it checks out right?
> 
> I guess it's this board:
> http://www.simtec.co.uk/products/BBD20EUROA/

I think that's fairly close.
We did have a couple of other designs done for clients, but they may
not have been available to the general public.

> 
> Does anyone know of a commercially obtainable product using
> SM501 with reasonable mainline Linux support so I can test it myself?
> 
> Getting a bit desperate...

At the moment I have no time to go through the boxes of ex-Simtec stuff
that I still have... quite a lot of my old Simtec stuff has already been
recycled as it has been over five years since leaving.

> Yours,
> Linus Walleij
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
