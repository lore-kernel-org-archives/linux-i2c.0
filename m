From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Wed, 3 Apr 2019 17:27:14 -0500
Message-ID: <CAErSpo4aRuM3rLFvMiKVwnpDxsfbVc9jR2bWse8tMZ-xWzYp8w@mail.gmail.com>
References: <20190325183652.252175-1-helgaas@kernel.org> <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai> <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
 <20190403205724.ozrdjdujvnzzbrpe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403205724.ozrdjdujvnzzbrpe@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 3, 2019 at 3:57 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Apr 01, 2019 at 02:37:19PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 1, 2019 at 9:08 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > > > > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > > > > convert i2c-isch to platform_device") removed the use of
> > > > > acpi_check_region() but not the include.
> > > > >
> > > > > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > > > > intended.
> > > > >
> > > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > Added
> > > >
> > > >     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> > > >     Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > > >     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > > >
> > > > on my local branch.
> > > >
> > > > Jean, would you like me to repost this with the updates?  I assume you
> > > > will merge this (just based on get_maintainer.pl)?
> > >
> > > I will apply it, now that it has Jean's Rev-by. I assume this is
> > > for-next material despite the Fixes tag?
> >
> > Definitely for-next material, not for the current release.  Jean
> > suggested the Fixes tag, I think since it's related to a specific
> > commit and could be backported together with that commit.
> >
> > Should there be a MAINTAINERS update to clarify who applies patches to
> > drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
> > mention you (Wolfram).
> >
> > Patch with tags attached in case it's useful to you (sorry, I'm
> > saddled with gmail right now and can't include it inline).
>
> > From 36fbdab89f5b8aa2d3616bd289e2c695fd3c0f9b Mon Sep 17 00:00:00 2001
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > Date: Tue, 30 Oct 2018 14:12:36 -0500
> > Subject: [PATCH] i2c: isch: Remove unnecessary acpi.h include
> >
> > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > convert i2c-isch to platform_device") removed the use of
> > acpi_check_region() but not the include.
> >
> > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > intended.
> >
> > Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Fixed this checkpatch error:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fd46a0064af1 ("i2c: convert i2c-isch to platform_device")'

Thanks, I didn't even know about that requirement for the word
"commit"!  I assume this only applies in the text, not in the "Fixes:"
tag.
