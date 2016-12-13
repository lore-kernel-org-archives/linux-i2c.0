From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 4/5] i2c: designware-baytrail: Disallow the CPU to
 enter C6 or C7 while holding the punit semaphore
Date: Tue, 13 Dec 2016 14:34:37 +0200
Message-ID: <1481632477.7188.77.camel@linux.intel.com>
References: <20161212215612.9262-1-hdegoede@redhat.com>
         <20161212215612.9262-4-hdegoede@redhat.com>
         <1481622976.7188.60.camel@linux.intel.com>
         <63a1993a-7df8-db09-01e7-7b82ddcc85b0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51859 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcLMMeo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Dec 2016 07:34:44 -0500
In-Reply-To: <63a1993a-7df8-db09-01e7-7b82ddcc85b0@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On Tue, 2016-12-13 at 13:21 +0100, Hans de Goede wrote:
> Hi,
> 
> On 13-12-16 10:56, Andy Shevchenko wrote:
> > On Mon, 2016-12-12 at 22:56 +0100, Hans de Goede wrote:
> > > On my cherrytrail tablet with axp288 pmic, just doing a bunch of
> > > repeated
> > > reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the
> > > tablet
> > > in
> > > 1 - 3 runs guaranteed.
> > > 
> > > This seems to be causes by the cpu trying to enter C6 or C7 while
> > > we
> > > hold
> > > the punit bus semaphore, at which point everything just hangs.
> > > 
> > > Avoid this by disallowing the CPU to enter C6 or C7 before
> > > acquiring
> > > the
> > > punit bus semaphore.
> > > 
> > 
> > Just a nitpick for abbreviations: pmic -> PMIC, punit -> P-Unit, but
> > I'm
> > okay with the contents which is more important.
> 
> Erm, the rest of the code, including dev_info and dev_err messages
> also uses punit without the - in there, anyways not planning to
> send a v5 for now.

Yes, no need in v5 until something more serious comes up.

> 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you.
> 
> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109051
> > 
> > What would be good is to have comments / tags from Len and Ville.
> 
> About this patch vs bug bko109051, yesterday I've spend time reading
> that entire bug. It seems it is a combination of at least 3 bugs
> combined, 2 i915 related with commits which seem to trigger
> the problem (2 different groups of users with a different problem
> it seems) which causes a hang every few hours. And one other
> bug where the system freezes in minutes, that one sounds like
> what I was seeing without this patch (but may well be yet
> another issue).

There also a dw_dmac bug which I fixed, but people are still referring
to it in that bug report.

> 
> As for the 2 i915 bugs, there have been git bisects for both of
> them, it would be good if someone could take a look at these, just
> search for bisect in that huge bug.

Agreed.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
