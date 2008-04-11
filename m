From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH3/7] i2c: OF helpers for the i2c API
Date: Fri, 11 Apr 2008 21:23:38 +0200
Message-ID: <47FFBABA.9040309@scram.de>
References: <47FF710D.2040208@scram.de> <20080411.104306.93639801.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761558AbYDKTWc@vger.kernel.org>
In-Reply-To: <20080411.104306.93639801.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: galak@kernel.crashing.org, khali@linux-fr.org, scottwood@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, jonsmirl@gmail.com, laurentp@cse-semaphore.com
List-Id: linux-i2c@vger.kernel.org

David Miller schrieb:

> I wouldn't mind trying to use this infrastructure on
> sparc64, and I don't see any powerpc specific interfaces
> being invoked, so if you could remove the PPC_OF
> requirement I'd appreciate it.

I've resenf the patch without the dependency on PPC_OF.

Thanks for the comment.
Jochen
