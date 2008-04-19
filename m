From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF
 helpers
Date: Fri, 18 Apr 2008 23:11:28 -0700 (PDT)
Message-ID: <20080418.231128.97404791.davem@davemloft.net>
References: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
	<20080418.210933.01471700.davem@davemloft.net>
	<18441.33181.511355.338428@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760002AbYDSGLu@vger.kernel.org>
In-Reply-To: <18441.33181.511355.338428@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org
Cc: jochen@scram.de, sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 19 Apr 2008 15:22:37 +1000

> David Miller writes:
> > From: Paul Mackerras <paulus@samba.org>
> > Date: Sat, 19 Apr 2008 14:04:32 +1000
> > 
> > It's OK if this breaks the sparc64 allmodconfig build, I'll take
> > care of this once it's merged in.
> 
> It breaks the sparc32 allmodconfig build, which seems to be a
> concern.  How do you suggest we fix that?

I'll fix both sparc64 and sparc32 builds when I merge my sparc
tree in.
