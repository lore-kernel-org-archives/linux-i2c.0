From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: i2c-ismt timeout
Date: Thu, 28 Sep 2017 07:40:28 -0400
Message-ID: <20170928114028.GA14560@hmswarspite.think-freely.org>
References: <0564ED57-D2B8-4192-8747-283F8DCCDEC5@versick.de>
 <20170927125757.GA15682@hmswarspite.think-freely.org>
 <499D67D9-2705-4006-9CBC-C2319C7CFE1C@versick.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:44976 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdI1Lkz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Sep 2017 07:40:55 -0400
Content-Disposition: inline
In-Reply-To: <499D67D9-2705-4006-9CBC-C2319C7CFE1C@versick.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Versick <danls@versick.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Thu, Sep 28, 2017 at 06:46:20AM +1000, Daniel Versick wrote:
> 
> > On 27 Sep 2017, at 10:57 pm, Neil Horman <nhorman@tuxdriver.com> wrote:
> > 
> > On Tue, Sep 26, 2017 at 09:50:40AM +1000, Daniel Versick wrote:
> >> Hi,
> >> 
> >> I am trying to resolve the known issue of ‘completion timed out’ in the i2c-ismt driver which has been reported a couple of times. I’ve seen few requests referring to it but no working solution yet.
> >> 
> >> I can reliably reproduce that problem on an Intel Atom C2xxx-based device and I found out that the driver does not receive interrupts anymore after getting into the timeout state. Even changing the driver to a polling version shows the same behaviour. It just does not receive a status bit change after transaction. So there is no problem with the MSI interrupt system which has been my first guess.
> >> 
> >> When being in the timeout state, the SMbus controller seems to be in such a bad condition that I cannot revive it at all. I tried different resets (such as ISMT_GCTRL_SRST and reseting the driver data structures). Only rebooting the device resolves the problem until next occurrence. A scope shows that data and clock lines are high.
> >> 
> >> I found a patch on the Internet which slows down the I2C communication by adding a delay to ismt_access. This patch probably refers to a known errata of the Atom S1200 and might work there but is no solution for the problem I am currently facing.
> >> 
> >> Are there any ideas or further information which might help? I tend to believe that this might be a silicon issue. Is there anything known?
> >> 
> > Lets start with the easy question - What kernel version are you using?
> 
> 4.9.36
> 
I'm not exactly sure what 4.9.36 is?  4.9 is an upstream released kernel, so I'm
assuming that this is a distribution kernel of some sort?  I would suggest
trying with a recent upstream kernel.  Theres not to much that has changed,
though there is one dma unmap error that might result in putting the hardware in
an odd state which may have some relevance here (not overly hopeful on that, but
its worth trying, its commit 17e83549e199d89aace7788a9f11c108671eecf5 if you are
curious). I presume you've also tried the delay patch, just to be through?

Beyond that, looking at the mail archives, no one has been able to
say much about this issue beyond "it happens sometimes".  Can you tell me
anything about the conditions under which the error might happen, or how
frequently it occurs?

Neil

> Daniel
> > 
> > Neil
> > 
> >> Thanks and regards,
> >> Daniel
> 
