From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools 4.0
Date: Thu, 10 Aug 2017 09:59:36 +0200
Message-ID: <20170810095936.22a8057a@endymion>
References: <20170803153414.4c9135ff@endymion>
        <alpine.LFD.2.20.1708081358330.10607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45433 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbdHJH7j (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Aug 2017 03:59:39 -0400
In-Reply-To: <alpine.LFD.2.20.1708081358330.10607@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

Hi Robert,

On Tue, 8 Aug 2017 13:59:49 -0400 (EDT), Robert P. J. Day wrote:
> On Thu, 3 Aug 2017, Jean Delvare wrote:
> 
> > Hi all,
> >
> > I have been delaying this for too long, let's release i2c-tools 4.0. I
> > know that there are still a few things which I wanted to include in it
> > which aren't ready (specifically, merging (parts of) tools/i2cbusses
> > into the library, and documenting the API), but apparently I can't find
> > the time for them. So I have come to the conclusion that we should
> > release what we have, and build incrementally on top of it after it has
> > been adopted by distributions.
> >
> > Therefore I would like to ask everyone to give good testing to the
> > master branch of:
> >
> > https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/
> >
> > because it will become i2c-tools 4.0 in a near future.  
> 
>   is it too late to suggest this patch:
> 
> https://www.toradex.com/community/questions/10243/write-issue-with-eeprog-in-eeprom.html
> https://share.toradex.com/s07bedxtxfdc4wj?direct
> 
> to increase the write sleep time so that one can write multiple bytes
> with eeprog?

Thanks for the report. I wonder why people always wait for
announcements of imminent releases to report bugs ;-) Bugs have to be
fixed anyway, before or after a release doesn't really make a
difference, as there were other releases before and there will be other
releases later. Distributions will cherry pick individual commits for
backport as needed.

Back to the bug itself, the fix will clearly slow down the writes for
some users. I'm not so worried as writing to EEPROMs isn't a frequent
operation and better safe than sorry. So I can apply it, but for the
long term I think this is calling for either a command line parameter
(to let the user decide of the sleep time) or a retry loop (this is what
the at24 kernel driver is doing.) If anyone wants to provide a patch
implementing either solution, I'll be happy to review it.

-- 
Jean Delvare
SUSE L3 Support
