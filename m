From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Tue, 15 Nov 2016 14:03:15 +0100
Message-ID: <20161115130314.GC2772@hardcore>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:62985
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932360AbcKONDn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Nov 2016 08:03:43 -0500
Content-Disposition: inline
In-Reply-To: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>

On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> On 11/14/2016 12:50 PM, Jan Glauber wrote:
> > 
> > Since time is running out for 4.9 (or might have already if you're not
> > going to send another pull request) I'm going for the safe option
> > to fix the Octeon i2c problems, which is:
> > 
> > 1. Reverting the readq_poll_timeout patch since it is broken
> > 2. Apply Patch #2 from Paul
> > 3. Add a small fix for the recovery that makes Paul's patch
> >    work on ThunderX
> > 
> > I'll try to come up with a better solution for 4.10. My plan is to get rid
> > of the polling-around-interrupt thing completely, but for that we need more
> > time to make it work on Octeon.
> > 
> > Please consider for 4.9.
> > 
> Hey Jan.
> 
> This does not work on Octeon 71xx platforms. I will look at it more
> closely tomorrow.

Paul, can you confirm this? It doesn't make sense for me, since patches #1
and #3 are unlikely to break anything... And patch #2 worked for you.

--Jan

> Steve
