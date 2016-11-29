From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Tue, 29 Nov 2016 10:19:28 +0100
Message-ID: <20161129091928.GB29487@hardcore>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:57334
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756561AbcK2JTn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 04:19:43 -0500
Content-Disposition: inline
In-Reply-To: <20161128142208.GA3916@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>

On Mon, Nov 28, 2016 at 03:22:08PM +0100, Wolfram Sang wrote:
> 
> > > > This does not work on Octeon 71xx platforms. I will look at it more
> > > > closely tomorrow.
> > > 
> > > What's the outcome here? It seems we want a bugfix for 4.9 but this
> > > report keeps me reluctant to apply the series.
> > > 
> > 
> > Steven, did you have a chance to check which of the patches makes
> > Octeon 71xx fail?
> 
> How do we proceed with this one? Is somebody at Cavium able to contact
> Steven internally? I mentioned this on-going regression to Linus and
> said an rc8 would help us, but reading LWN it seems we shouldn't count
> on it...
> 

Hi Wolfram,

if possible we should at least revert commit 70121f7f3725. I should get
access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
deadline for a well tested fix that works across all machines.

--Jan
