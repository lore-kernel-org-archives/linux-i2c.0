From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools 4.0
Date: Thu, 10 Aug 2017 11:29:27 +0200
Message-ID: <1502357367.6201.9.camel@suse.de>
References: <20170803153414.4c9135ff@endymion>
                <alpine.LFD.2.20.1708081358330.10607@localhost.localdomain>
         <20170810095936.22a8057a@endymion>
         <alpine.LFD.2.20.1708100427530.31724@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbdHJJ33 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Aug 2017 05:29:29 -0400
In-Reply-To: <alpine.LFD.2.20.1708100427530.31724@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On jeu., 2017-08-10 at 04:30 -0400, Robert P. J. Day wrote:
> On Thu, 10 Aug 2017, Jean Delvare wrote:
> > Thanks for the report. I wonder why people always wait for
> > announcements of imminent releases to report bugs ;-) Bugs have to
> > be fixed anyway, before or after a release doesn't really make a
> > difference, as there were other releases before and there will be
> > other releases later. Distributions will cherry pick individual
> > commits for backport as needed.
> 
>   i actually did ask about this very issue last month:
> 
> http://marc.info/?l=linux-i2c&m=150109384702585&w=2

You forgot to Cc me :(

> > Back to the bug itself, the fix will clearly slow down the writes
> > for some users. I'm not so worried as writing to EEPROMs isn't a
> > frequent operation and better safe than sorry. So I can apply it,
> > but for the long term I think this is calling for either a command
> > line parameter (to let the user decide of the sleep time) or a retry
> > loop (this is what the at24 kernel driver is doing.) If anyone wants
> > to provide a patch implementing either solution, I'll be happy to
> > review it.
> 
>   if the patch referred to above still applies cleanly, i can just
> submit that later today. i understand that it will slow down writes;
> on the other hand, without it, multi-byte writes simply won't work.

No need, I already applied a cleaned up version thereof:

https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/commit/?id=7c1260bd0ee73c392f8c2a5b32b4b7c118011255

-- 
Jean Delvare
SUSE L3 Support
