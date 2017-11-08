From: Tim Sander <tim@krieglstein.org>
Subject: Re: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
Date: Wed, 08 Nov 2017 09:29:55 +0100
Message-ID: <2970055.FM06l9ul3d@dabox>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509984581.25007.47.camel@linux.intel.com>
 <a0265848-2496-d347-a40f-ce83e7dfd945@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a0265848-2496-d347-a40f-ce83e7dfd945@electromag.com.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, khilman@kernel.org, nsekhar@ti.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi

Sorry for beeing so silent, i have been swept to completly different area
so this thing was swapped out.

Thanks Phil for your work on this!
Am Dienstag, 7. November 2017, 09:02:50 CET schrieb Phil Reid:
> On 7/11/2017 00:09, Andy Shevchenko wrote:
> > On Thu, 2017-11-02 at 10:40 +0800, Phil Reid wrote:
> >> From: Tim Sander <tim@krieglstein.org>
> >> 
> >> This patch contains much input from Phil Reid and has been tested
> >> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> >> SCL and SDA GPIO's.
> >> 
> >> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Shame on me, I totally forgot one important comment on all this.
> > 
> > How do we switch pinctrl back to the native function? Is it guaranteed
> > by pinctrl framework and all underneath drivers?

> That is a good question. I don't have an understanding of how the pinctrl
> framework works with respect to requesting gpios.
> My device (Intel / Altera Cyclone V SOC) doesn't have a pinctrl for the i2c
> / gpio mux as yet.
According to the documentation from Intel/Altera it is not allowed to change 
the pinmux while running. My guess is that they are using a shift chain, so 
the output values of all pins in the chain are not stable. I think they have 
been lazy and just used the io config for fpgas with an jtag controller and 
connected the shift chain for pinconfig to this controller. So unfortunatly it 
is not possible to switch single pins on the run without interfering with 
other pins.
> It's all setup by the bootloader and they don't expect
> you to change it. I'm using two separate GPIO's "wired" to the i2c bus via
> the SOC FPGA for the recovery. Tim was doing the same.
Yes, i think thats the only way. But it is annoying that the i2c controllers 
of 201x have no way to recover from such bus errors >:-(.

Best regards
Tim
