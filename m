From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
Date: Sat, 19 Apr 2008 14:04:32 +1000
Message-ID: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
References: <4808AEC7.8040000@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755941AbYDSEEs@vger.kernel.org>
In-Reply-To: <4808AEC7.8040000@scram.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Kumar Gala <galak@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>, David Miller <davem@davemloft.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-i2c@vger.kernel.org

Jochen Friedrich writes:

> Fix build breakage introduced in commit
> "[POWERPC] i2c: OF helpers for the i2c API".
> If i2c-core is compiled as module, the helper needs to be
> compiled as module, as well. Rename i2c.c to of_i2c.c to
> avoid name space conflict.

Actually, since only powerpc has irq_of_parse_and_map, I'm now
inclined to think that drivers/of/i2c.c should live under arch/powerpc
for now, or at the least its option should depend on PPC_OF.

Paul.
