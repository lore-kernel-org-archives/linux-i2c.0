From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 19 3/5] Clean up error returns
Date: Mon, 21 Jan 2008 17:10:25 +0100
Message-ID: <20080121171025.524dc465@hyperion.delvare>
References: <20080112024737.7023.61680.stgit@terra.home>
	<20080112024743.7023.23630.stgit@terra.home>
	<20080120120730.06dd8a7f@hyperion.delvare>
	<9e4733910801200718q7304bc29q38e67580613189e4@mail.gmail.com>
	<9e4733910801200739x502d5407x85f0d950ace80bee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761107AbYAUQKi@vger.kernel.org>
In-Reply-To: <9e4733910801200739x502d5407x85f0d950ace80bee@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Sun, 20 Jan 2008 10:39:43 -0500, Jon Smirl wrote:
> Here' s a version with the compares to zero switched to NO_IRQ. If I
> understand how NO_IRQ works it is the correct change. My understanding
> is that under ppc IRQ zero was legal and NO_IRQ was -1. But then the
> whole kernel switched to NO_IRQ = zero. Powerpc updated to NO_IRQ=0
> and used virtual IRQs to move a physical IRQ 0 to another IRQ number.
> ppc was not changed. This driver does not appear to have been updated
> to track this global change since it didn't initially use the NO_IRQ
> define everywhere.

As I have already applied the part of this patch that preserves error
values in error paths, can you please send an incremental patch that
only fixes the IRQ issues? These are separate issues so it's better to
have separate patches anyway.

Thanks,
-- 
Jean Delvare
