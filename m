From: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Date: Fri, 24 Sep 2010 12:50:01 +0200
Message-ID: <19612.33369.175358.879889@pilspetsen.it.uu.se>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
	<20100923113807.4643fbbb.rdunlap@xenotime.net>
	<19611.46496.782340.466509@pilspetsen.it.uu.se>
	<20100923150559.9c67da11.rdunlap@xenotime.net>
	<20100924111209.3c071da3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100924111209.3c071da3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare writes:
 > On Thu, 23 Sep 2010 15:05:59 -0700, Randy Dunlap wrote:
 > > On Thu, 23 Sep 2010 22:16:32 +0200 Mikael Pettersson wrote:
 > > > Randy Dunlap writes:
 > > >  > No kconfig warnings?
 > > > 
 > > > Not that I recall.  I can check tomorrow if necessary.
 > > 
 > > No kconfig warnings.  I checked with your .config file.
 > > 
 > > >  > Please post your full .config file.
 > > 
 > > Just a matter of module i2c-core calls of_ functions and module of_i2c calls
 > > i2c_ functions.  Hmph.  Something for Grant, Jean, and Ben to work out.
 > 
 > As far as I can see this is caused by this commit from Grant:
 > 
 > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5
 > 
 > Mikael, can you please try reverting this patch and see if it solves
 > your problem?

Yes, reverting the above commit from 2.6.36-rc5 eliminated the warnings,
and I was able to insmod the i2c-{core,dev,powermac}.ko modules.

/Mikael
