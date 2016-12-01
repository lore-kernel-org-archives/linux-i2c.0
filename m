From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 09/39] Annotate hardware config module parameters in
 drivers/i2c/
Date: Thu, 01 Dec 2016 17:06:44 +0100
Message-ID: <1480608404.21573.68.camel@chaos.suse>
References: <1480600052.21573.60.camel@chaos.suse>
         <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
         <148059544784.31612.17605303556663485588.stgit@warthog.procyon.org.uk>
         <23573.1480601572@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <23573.1480601572@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: minyard@acm.org, linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Wolfram Sang <wsa@the-dreams.de>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On jeu., 2016-12-01 at 14:12 +0000, David Howells wrote:
> Jean Delvare <jdelvare@suse.de> wrote:
> 
> > > Note that we do still need to do the module initialisation because some
> > > drivers have viable defaults set in case parameters aren't specified and
> > > some drivers support automatic configuration (e.g. PNP or PCI) in addition
> > > to manually coded parameters.
> > 
> > Initializing the driver when you are not able to honor the user request
> > looks wrong to me. I don't see how some drivers having sane defaults
> > justifies that. Using the defaults when no parameters are passed is one
> > thing (good), still using the defaults when parameters are passed is
> > another (bad), and you should be able to differentiate between these two
> > cases.
> 
> Corey Minyard argues the other way:
> 
> 	This would prevent any IPMI interface from working if any address was
> 	given on the kernel command line. I'm not sure what the best policy
> 	is, but that sounds like a possible DOS to me.
> 
> Your preference allows someone to prevent a driver from initialising - which
> could also be bad.  The problem is that I don't think there's any way to do
> both.

I'm not sure what is your threat model, but I'm afraid that if the
attacker can change the kernel command line, he/she has so many ways to
screw up the machine, that removing one won't make a difference.

>> (...)
> > And maybe the following ones, but I'm not sure if forcibly enabling a
> > device is part of what you need to prevent:
> > 
> > i2c-piix4.c:module_param (force, int, 0);
> > i2c-sis630.c:module_param(force, bool, 0);
> > i2c-viapro.c:module_param(force, bool, 0);
> 
> I don't know either.  One could argue it *should* be locked down because its
> need appears to reflect a BIOS bug.

Indeed. OTOH if you remove all kernel code that is there solely due to
BIOS bugs, then you can rename Secure Boot to No Boot. Well that's
certainly one way to be secure ;-)

-- 
Jean Delvare
SUSE L3 Support

