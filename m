From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/4] eeprom: at24: Allow passing gpiodesc from pdata
Date: Thu, 23 Aug 2018 13:14:32 +0200
Message-ID: <CAMRc=MeR242hFhk4Nts9Fo2110NYAKoULDZPpe_mTrpdA2CNSw@mail.gmail.com>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
 <20180823103332.32047-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180823103332.32047-2-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>, dev@lists.96boards.org, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andy@infradead.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-08-23 12:33 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> This makes it possible to pass an initialized GPIO descriptor
> to the driver through platform data.
>
> This is useful when we are dealing with EEPROMs on expansion
> boards where the GPIO has to be looked up indirectly using a
> connector abstraction (several systems using the same
> connector) so the machine descriptor tables cannot be used
> to associate the descriptor with the device and we then want
> to pass this descriptor on to the EEPROM driver this way
> instead.
>

Ugh I don't like this at all. In fact I'm right now trying to *get
rid* of platform_data from at24 in favor of device properties[1].

Part of the changes from my series actually removes the setup function
from at24 and replaces it with a notifier fired by the nvmem
framework.

I would really prefer that we introduce some generic way of handling
write-protect mechanisms in nvmem. Maybe starting by moving the
wp_gpio to nvmem and then passing it in nvmem_config?

Best regards,
Bartosz Golaszewski

[1] https://patchwork.kernel.org/cover/10562365/
