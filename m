From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF
 helpers
Date: Sat, 19 Apr 2008 21:45:46 +1000
Message-ID: <18441.56170.464016.686497@cargo.ozlabs.ibm.com>
References: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
	<20080418.210933.01471700.davem@davemloft.net>
	<18441.33181.511355.338428@cargo.ozlabs.ibm.com>
	<20080418.231128.97404791.davem@davemloft.net>
	<20080419110934.672648e6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761702AbYDSLqS@vger.kernel.org>
In-Reply-To: <20080419110934.672648e6@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: David Miller <davem@davemloft.net>, jochen@scram.de, sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare writes:

> Guys, you're doing things the wrong way around. Breaking things to fix
> them later is not OK, it's a pain for testers and also when bisecting
> the kernel. Everything should still work after merging the powerpc
> tree. Dave, if you need to loosen the dependency, you should do it
> yourself _after_ having changed whatever needs to be in the sparc32 and
> sparc64 trees so that loosening the dependency doesn't break anything.
> As far as I can see it's only a matter of changing one line in a
> Kconfig file, that's not exactly difficult to do it in the right order.

You're right.  I'll put in a dependency on PPC_OF for now and Dave can
take it out once sparc32/64 have irq_of_parse_and_map etc.

Paul.
