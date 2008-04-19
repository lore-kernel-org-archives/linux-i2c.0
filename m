From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF
 helpers
Date: Sat, 19 Apr 2008 02:12:56 -0700 (PDT)
Message-ID: <20080419.021256.26059313.davem@davemloft.net>
References: <18441.33181.511355.338428@cargo.ozlabs.ibm.com>
	<20080418.231128.97404791.davem@davemloft.net>
	<20080419110934.672648e6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753286AbYDSJNP@vger.kernel.org>
In-Reply-To: <20080419110934.672648e6@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org
Cc: paulus@samba.org, jochen@scram.de, sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Apr 2008 11:09:34 +0200

> Guys, you're doing things the wrong way around. Breaking things to fix
> them later is not OK, it's a pain for testers and also when bisecting
> the kernel. Everything should still work after merging the powerpc
> tree. Dave, if you need to loosen the dependency, you should do it
> yourself _after_ having changed whatever needs to be in the sparc32 and
> sparc64 trees so that loosening the dependency doesn't break anything.
> As far as I can see it's only a matter of changing one line in a
> Kconfig file, that's not exactly difficult to do it in the right order.

Fair enough.

At least don't move this stuff under arch/powerpc as paulus originally
had suggested.
