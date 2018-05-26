From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: i2c-gpio and boards conversions to GPIO descriptors
Date: Sat, 26 May 2018 18:38:43 +0200
Message-ID: <CACRpkdb26T7JNHOPSFxmPLyNnMDqpNYnMZxKEHGL8gPo9V2Sjg@mail.gmail.com>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Guinot <simon.guinot@sequanux.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux MIPS <linux-mips@linux-mips.org>, Wolfram Sang <wsa@the-dreams.de>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 25, 2018 at 5:41 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> Hi Linus,
>
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
>
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.

Yeah what a mess, I'm sending patches to fix it up, the ARM
patch already sent, I will send a separate one for the MIPS
machines.

Sorry for the mess! :(

Yours,
Linus Walleij
