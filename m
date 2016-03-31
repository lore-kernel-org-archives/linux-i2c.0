From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v4 05/14] i2c-octeon: Enable high-level controller and
 improve on bus contention
Date: Thu, 31 Mar 2016 12:24:33 +0200
Message-ID: <20160331102433.GB31112@hardcore>
References: <cover.1458289385.git.jglauber@cavium.com>
 <27b7d9015f8165da0371e4d26c9acc72772ae3a0.1458289385.git.jglauber@cavium.com>
 <20160323203215.GF19849@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0070.outbound.protection.outlook.com ([157.56.110.70]:23257
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751654AbcCaKYv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 31 Mar 2016 06:24:51 -0400
Content-Disposition: inline
In-Reply-To: <20160323203215.GF19849@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>

On Wed, Mar 23, 2016 at 09:32:15PM +0100, Wolfram Sang wrote:
> On Fri, Mar 18, 2016 at 09:46:30AM +0100, Jan Glauber wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Use High Level Controller when possible.
> 
> Can you give me a one line description what this Controller is? I'd
> assume it can do simple write-then-read messages with less setup?

Of course, I'll add this to the patch description too.

The HLC can read/write up to 8 bytes and is completely optional. The most
important difference of the HLC is that it only requires one interrupt for
a transfer (up to 8 bytes) where the low-level read/write requires 2
interrupts plus one interrupt per transferred byte. Since the interrupts
are costly using the HLC improves the performance. Also, the HLC provides
improved error handling.

> > i2c-octeon was reacting badly to bus contention: when in
> > direct-access mode (for transfers > 8 bytes, which cannot use the
> > high-level controller) some !ACK or arbitration-loss states were
> > not causing the current transfer to be aborted, and the bus released.
> 
> So, what does this patch do? Enable HLC for transfers < 8 byte? And for
> all other transfers we still suffer from the same problem?

I think the patch description was misleading, which is my fault because
I merged several incremental patches into one.

The HLC is used when possible (up to 8 bytes). For bigger transfers
the handling is improved and special treatment is done for the first
and last part of a transfer.

> Such information should be here, too. It helps reviewing when I already
> have the big picture.
> 
> > There's one place in i2c protocol that !ACK is an acceptable
> > response: in the final byte of a read cycle.  In this case the
> > destination is not saying that the transfer failed, just that it
> > doesn't want more data.
> 
> Ehrm, no? For reads, the MASTER is saying it doesn't need any more data.
> And an I2C eeprom can legally NACK a write, e.g. when it is still
> processing the previous write. Also, NACK is a valid response after the
> address phase, meaning there is no device listening.
> 
> Does the implementation cover the above cases?
> 
> > This enables correct behavior of ACK on final byte of non-final read
> > msgs too.
> 
> The patch is huge and very hard to review. Maybe it needs to be split
> up. Brainstorming example: a) move functions like octeon_i2c_set_clock()
> upwards, b) change them if needed, c) implement HLC functions, d) add
> switching logic to use HLC or non-HLC functions...

I was reluctant to split the patch because of the high risk of breaking
the bi-sectability, but your proposal makes sense. I've seperated the
error handling changes from the HLC feature now (plus seperate
patches for the moved functions).

Thanks,
Jan

> But first we need to be clear on the big picture view.
> 
> Thanks,
> 
>    Wolfram
> 
