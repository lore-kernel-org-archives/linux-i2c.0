From: Alban Browaeys <alban.browaeys@gmail.com>
Subject: Re: [PATCH] i2c: i801: Fix SMBus ENXIO on resume from suspend.
Date: Thu, 07 Dec 2017 22:11:21 +0100
Message-ID: <1512681081.25350.16.camel@gmail.com>
References: <20171115170156.21532-1-alban.browaeys@gmail.com>
         <1510777525.21208.4.camel@gmail.com> <20171120101514.62239b4f@endymion>
         <1511187527.6389.46.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33599 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbdLGVLY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 16:11:24 -0500
Received: by mail-wm0-f44.google.com with SMTP id g130so2209091wme.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 Dec 2017 13:11:23 -0800 (PST)
In-Reply-To: <1511187527.6389.46.camel@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Volker =?ISO-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Thanks for Volker's patch.
I applied it and it does not help on this Intel Haswell box (Lenovo
Thinkpad Yoga S1). My initial patch did not helped either.

I was confused as the bug reproduce easely only if the i2c-i801,
rmi_smbus and psmouse are loaded once then resume from suspend.
Afterwards (even unload module) I sometimes get around the bug.

Could ACPI/EC OpRegion accesses happen without the kernel handler
triggering (while suspending and / or resuming) ?

Thanks
Alban



Le lundi 20 novembre 2017 à 15:18 +0100, Alban Browaeys a écrit :
> I am on one of those Intel Haswell with the ACPI OpRegion conflict,
> the
> acpi handler was added to cope with.
> 
> Could it be the embedded controller code mess with the smbus ?
> When I print the OpRegion fields via acpi-call I get different values
> after suspend/resume from S3 than at runtime at various points.
> 
> I already checked that the acpi SBUS methods are not called.
> To do so I define a global name set to zero and set it to 1 in
> SBUS.STRT (called by all SBUS method to verify the ready state).
> 
> Could it be the EC access the region directly ?
> The acpi handler from i2c-i801 does not trigger. Is it in effect when
> suspending or resuming ?
> 
> The reproducer seems hard to get right, I am still investigating.
> It involves resume from suspend (S3) and a yet to define state.
> Most of the time after an acpi reset (magic sysrq 'b').
> And / or early load of i2x-i801, rmi_smbus and psmouse.
> 
> To call the acpi methods I echo to /proc/acpi/call from the acpi-call
> module. 
> 
> I tried https://github.com/pali/i2c-acpi-sbus .
> It fails early as acpi sbus methods check the inuse host status flag.
> It is always on thus they bail out. i2c-i801 does not test inuse
> (0x40).
> 
> 
> Best regards
> Alban
> 
> 
> Le lundi 20 novembre 2017 à 10:15 +0100, Jean Delvare a écrit :
> > On Wed, 15 Nov 2017 21:25:25 +0100, Alban Browaeys wrote:
> > > This fix is a partial one: it only fixes the issue once
> > > we unload then reload i2c-i801 .
> > > This as when we load a second time  orig_hstcfg is set to the
> > > value
> > > the
> > > first module load leftover.
> > > Thus I will investigate the initial orig_hstcfg at boot to
> > > further
> > > the
> > > fix.
> > > I bet this only a few missing bits like HST_EN.
> > 
> > Volker, I think you had a fix for that one? But I can't find it in
> > the
> > list archive :-(
