From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Date: Thu, 10 Dec 2015 16:06:10 +0100
Message-ID: <2592093.cGKEcKVqLU@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kbuild test robot <lkp@intel.com>
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild-all@01.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 December 2015 22:54:25 kbuild test robot wrote:
> 
>    In file included from arch/x86/include/asm/realmode.h:5:0,
>                     from arch/x86/include/asm/acpi.h:33,
>                     from arch/x86/include/asm/fixmap.h:19,
>                     from arch/x86/include/asm/apic.h:12,
>                     from arch/x86/include/asm/smp.h:12,
>                     from arch/x86/include/asm/mmzone_64.h:10,
>                     from arch/x86/include/asm/mmzone.h:4,
>                     from include/linux/mmzone.h:856,
>                     from include/linux/gfp.h:5,
>                     from include/linux/device.h:29,
>                     from drivers/i2c/busses/i2c-emev2.c:15:
>    drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_irq_handler':
> >> arch/x86/include/asm/io.h:53:3: warning: 'value' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     { asm volatile("mov" size " %0,%1": :reg (val), \
>       ^
>    drivers/i2c/busses/i2c-emev2.c:232:13: note: 'value' was declared here
>      u8 status, value;
>                 ^

The warning was indeed introduced by my change, but I think there
was a preexisting issue:

The slave_cb callback function is supposed to set the 'value'
here, but it might return an error not assign the pointer, which
is something that both the rcar and the emev2 drivers do not handle
correctly.

It might be best to change the callback to return 'void' and not
allow it to fail. At least the eeprom slave cannot fail anyway,
and it is the only implementation we have at the moment.
The inline function would then have to be changed to initialize
the 'value'.

Alternatively, the  inline could return an error, and both bus
drivers check for the error before using 'value'.

	Arnd
