From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/39] Annotate hardware config module parameters in drivers/i2c/
Date: Thu, 01 Dec 2016 14:12:52 +0000
Message-ID: <23573.1480601572@warthog.procyon.org.uk>
References: <1480600052.21573.60.camel@chaos.suse> <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk> <148059544784.31612.17605303556663485588.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480600052.21573.60.camel@chaos.suse>
Content-ID: <23572.1480601572.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, minyard@acm.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Wolfram Sang <wsa@the-dreams.de>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <jdelvare@suse.de> wrote:

> > Note that we do still need to do the module initialisation because some
> > drivers have viable defaults set in case parameters aren't specified and
> > some drivers support automatic configuration (e.g. PNP or PCI) in addition
> > to manually coded parameters.
> 
> Initializing the driver when you are not able to honor the user request
> looks wrong to me. I don't see how some drivers having sane defaults
> justifies that. Using the defaults when no parameters are passed is one
> thing (good), still using the defaults when parameters are passed is
> another (bad), and you should be able to differentiate between these two
> cases.

Corey Minyard argues the other way:

	This would prevent any IPMI interface from working if any address was
	given on the kernel command line. I'm not sure what the best policy
	is, but that sounds like a possible DOS to me.

Your preference allows someone to prevent a driver from initialising - which
could also be bad.  The problem is that I don't think there's any way to do
both.

Note that the policy isn't actually handled in any of these patches, but will
be handled in a later patchset that is on top of my EFI changes also.

> > Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> 
> I know this is only a Suggested-by and not a Signed-off-by, but still I
> believe the Developer's Certificate of Origin applies, and it says:
> "using your real name (sorry, no pseudonyms or anonymous
> contributions.)"

I asked him what he prefers - but no response.

> No objection from me, but I think you missed several i2c bus driver
> parameters:
> 
> i2c-ali15x3.c:module_param(force_addr, ushort, 0);
> i2c-piix4.c:module_param (force_addr, int, 0);
> i2c-sis5595.c:module_param(force_addr, ushort, 0);
> i2c-viapro.c:module_param(force_addr, ushort, 0);

Okay, thanks.  They all seem to encode ioports.  All changed.

> And maybe the following ones, but I'm not sure if forcibly enabling a
> device is part of what you need to prevent:
> 
> i2c-piix4.c:module_param (force, int, 0);
> i2c-sis630.c:module_param(force, bool, 0);
> i2c-viapro.c:module_param(force, bool, 0);

I don't know either.  One could argue it *should* be locked down because its
need appears to reflect a BIOS bug.

David
