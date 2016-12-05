From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/39] Annotate hardware config module parameters in
 drivers/i2c/
Date: Mon, 5 Dec 2016 21:09:51 +0000
Message-ID: <20161205210951.79e54ba5@lxorguk.ukuu.org.uk>
References: <1480600052.21573.60.camel@chaos.suse>
        <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
        <148059544784.31612.17605303556663485588.stgit@warthog.procyon.org.uk>
        <23573.1480601572@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39174 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbcLEVKX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Dec 2016 16:10:23 -0500
In-Reply-To: <23573.1480601572@warthog.procyon.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Jean Delvare <jdelvare@suse.de>, minyard@acm.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org

O> > > Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>  
> > 
> > I know this is only a Suggested-by and not a Signed-off-by, but still I
> > believe the Developer's Certificate of Origin applies, and it says:
> > "using your real name (sorry, no pseudonyms or anonymous
> > contributions.)"  
> 
> I asked him what he prefers - but no response.


I didn't see that question but "Alan Cox" is probably saner - the
thousand gnomes is an old Linus joke 8)
 
> > i2c-piix4.c:module_param (force, int, 0);
> > i2c-sis630.c:module_param(force, bool, 0);
> > i2c-viapro.c:module_param(force, bool, 0);  
> 
> I don't know either.  One could argue it *should* be locked down because its
> need appears to reflect a BIOS bug.

And none of those should show up in that usage form on a box new enough
to have EFI secure boot. Those that do have i2c busses will report them
via ACPI by that period.

Alan
