From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] i2c: core: Use GPIO descriptors for recovery
Date: Fri, 8 Dec 2017 14:05:46 +0100
Message-ID: <CACRpkdaXYEaQOyj3Y7Lzv4FhONgms8=LnN+62HxoK1g3CiD=EA@mail.gmail.com>
References: <20171208102002.26456-1-linus.walleij@linaro.org>
 <20171208105010.xn6m4bl3hiaxhizq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171208105010.xn6m4bl3hiaxhizq@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 8, 2017 at 11:50 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Dec 08, 2017 at 11:20:02AM +0100, Linus Walleij wrote:
>> The I2C core contains code for handling a fallback recovery
>> using GPIO when a piece of I2C hardware fails in duty.
>>
>> This code passes GPIO numbers from the global GPIO
>> numberspace around and we want to get rid of this and use
>> GPIO descriptors associated with the devices.
>>
>> After some digging it turns out that there are two users
>> of the mechanism in the entire kernel:
>>
>> - i.MX that simply define "scl-gpios" and "sda-gpios" in
>>   the device tree which is already creating descriptors
>>   associated with the device, that we can pick up and use.
>>
>> - Two DaVinci boards that pass the SCL and SDA GPIOs using
>>   custom platform data.
>>
>> Refactor the core to grab the SCL and SDA GPIO descriptors
>> on-demand when doing recovery, and release them when
>> recovery is done. Grab the named descriptors "scl" and
>> "sda" which will make the i.MX method work out of the
>> box.
>>
>> Augment the two DaVinci board files to pass descriptors
>> using static tables.
>>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> We have this in i2c/for-next:
>
> 3991c5c80beaf7 ("i2c: Switch to using gpiod interface for gpio bus recovery")
>
> Sorry, I just noticed you were not on CC. I wrongly remembered you took
> part in that discussion, too.

Haha OK no problem, I'll go review the other patch.

Yours,
Linus Walleij
