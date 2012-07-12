From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: Build error with [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c
Date: Thu, 12 Jul 2012 06:52:18 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EA1AA99@wm021.weinmann.com>
References: <CAFLc3brYJGkQoW5mGi9XaujNBMBdGX6RxfkNRbBZJQz_axz_Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFLc3brYJGkQoW5mGi9XaujNBMBdGX6RxfkNRbBZJQz_axz_Jg@mail.gmail.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Stefano Salati' <stef.salati@gmail.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Stefano,

Stefano Salati wrote on 2012-07-11:
> Thank you for publishing your patches! I'm using a at91sam9x5 board and I've
> been trying to patch the TWI so to be able to use the physical I2C module.
> When compiling, I get this error:
> 
> |   CC      drivers/i2c/busses/i2c-at91.o |
> drivers/i2c/busses/i2c-at91.c: In function 'at91_twi_probe': |
> drivers/i2c/busses/i2c-at91.c:350:2: error: implicit declaration of
> function 'clk_prepare' | drivers/i2c/busses/i2c-at91.c:394:2: error:
> implicit declaration of function 'clk_unprepare'
> 
> I tried to grep these these 2 functions in the whole /linux-2.6.39 but I had
> no luck, I cannot find any declaration (even in files belonging to the board
> you've designed the patch for).
> Where I'm missing something?

the driver is designed for kernel 3.2 or newer, nevertheless it should work
on older kernels with slight modifications. You can simply delete the
clk_prepare()/unprepare() stuff for your kernel version.

Please report the SoC and I2C clients you tested the driver with, preferably
with a Tested-by tag, so I can include it in newer versions of the driver
to improve the chance of mainlining the driver.

Niko
