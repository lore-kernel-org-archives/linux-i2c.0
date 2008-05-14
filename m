From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [i2c] [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Wed, 14 May 2008 23:46:05 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805142309190.15223@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130353250.535@cliff.in.clinika.pl>
 <20080514213841.GC16881@fluff.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080514213841.GC16881@fluff.org.uk>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ben Dooks <ben@fluff.org>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 14 May 2008, Ben Dooks wrote:

> My recollection is that the return of ioremap() was meant to be
> used with read{b,w,l} and not their __raw_xxx() counterparts.

 Well, what would the definition of the cookie passed to these raw MMIO
access calls be then?

 They have to be used here, because SOC on-chip registers are accessed by
the driver and therefore data transferred must never be swapped in any
way.  The internal registers always have the same numerical value (bit
positions) regardless of the endianness configured when the SOC's on-chip
CPU cores are reset.

 For the external buses the arrangement varies, for example the PCI
interface is always little-endian and the Generic Bus is always
big-endian.  To access these, cooked MMIO calls would normally be used
(these without a prefix) which swap bytes as necessary to preserve bit
positions.  The notable exception are PIO-style data transfers, such as
ones used by some IDE drivers (including the GenBus one), where the
ultimate destination is system memory (which is endian-neutral) and thus
bit positions do not matter but addresses of individual bytes do --
__mem_xxx() calls have been defined for this purpose, which swap bytes as
necessary.  See include/asm-mips/mach-generic/mangle-port.h for details.

  Maciej
