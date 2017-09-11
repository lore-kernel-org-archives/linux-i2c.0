From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Mon, 11 Sep 2017 21:37:16 +0200
Message-ID: <CACRpkdb4LQAqyWpRAWGRxUOcTbWVksNc3FTWdPnYNE-AUHtfgg@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Steven Miao <realmz6@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>, "arm@kernel.org" <arm@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 11, 2017 at 1:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> This converts the GPIO-based I2C-driver to using GPIO
>> descriptors instead of the old global numberspace-based
>> GPIO interface. We:
>>
>> - Convert the driver to unconditionally grab two GPIOs
>>   from the device by index 0 (SDA) and 1 (SCL) which
>>   will work fine with device tree and descriptor tables.
>>   The existing device trees will continue to work just
>>   like before, but without any roundtrip through the
>>   global numberspace.
>
> FYI, I recently posted a series to deprecate (at least for DT) this error
> prone indexing, in favor of using named GPIOs:
>
>     [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
>     http://www.spinics.net/lists/devicetree/msg191936.html

Nice.

If Wolfram likes this series, I volunteer to rebase your patch
(oh well rewrite patch 2 from scratch, haha) on top of it as well
so he can apply the whole thing.

They will need some adjustments, I volunteer to do them.
Will provide feedback in the patches.

Yours.
Linus Walleij
