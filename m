From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v3 12/12] drm/i915: Listen for PMIC bus
 access notifications
Date: Sun, 26 Feb 2017 21:01:47 +0100
Message-ID: <20170226200147.dfqmvqbpm7bvri3o@phenom.ffwll.local>
References: <20170210102802.20898-1-hdegoede@redhat.com>
 <20170210102802.20898-13-hdegoede@redhat.com>
 <20170216184449.GN31595@intel.com>
 <87inoadknh.fsf@intel.com>
 <1cef0e0f-bd5a-d368-6630-809292b194df@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32872 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdBZUJz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 26 Feb 2017 15:09:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so10570361wmv.0
        for <linux-i2c@vger.kernel.org>; Sun, 26 Feb 2017 12:09:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1cef0e0f-bd5a-d368-6630-809292b194df@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>

On Mon, Feb 20, 2017 at 09:29:10AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 16-02-17 20:02, Jani Nikula wrote:
> > On Thu, 16 Feb 2017, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > > On Fri, Feb 10, 2017 at 11:28:02AM +0100, Hans de Goede wrote:
> > > > Listen for PMIC bus access notifications and get FORCEWAKE_ALL while
> > > > the bus is accessed to avoid needing to do any forcewakes, which need
> > > > PMIC bus access, while the PMIC bus is busy:
> > > > 
> > > > This fixes errors like these showing up in dmesg, usually followed
> > > > by a gfx or system freeze:
> > > > 
> > > > [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
> > > > [drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
> > > > i2c_designware 808622C1:06: punit semaphore timed out, resetting
> > > > i2c_designware 808622C1:06: PUNIT SEM: 2
> > > > i2c_designware 808622C1:06: couldn't acquire bus ownership
> > > > 
> > > > Downside of this approach is that it causes wakeups whenever the PMIC
> > > > bus is accessed. Unfortunately we cannot simply wait for the PMIC bus
> > > > to go idle when we hit a race, as forcewakes may be done from interrupt
> > > > handlers where we cannot sleep to wait for the i2c PMIC bus access to
> > > > finish.
> > > > 
> > > > Note that the notifications and thus the wakeups will only happen on
> > > > baytrail / cherrytrail devices using PMICs with a shared i2c bus for
> > > > P-Unit and host PMIC access (i2c busses with a _SEM method in their
> > > > APCI node), e.g. an axp288 PMIC.
> > > > 
> > > > I plan to write some patches for drivers accessing the PMIC bus to
> > > > limit their bus accesses to a bare minimum (e.g. cache registers, do not
> > > > update battery level more often then 4 times a minute), to limit the
> > > > amount of wakeups.
> > > > 
> > > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > Tested-by: tagorereddy <tagore.chandan@gmail.com>
> > > 
> > > I gave the previous versions a quick whirl on a few machines here, but
> > > them not being CR versions I guess this stuff doesn't kick in at all.
> > > And I don't see any _SEM stuff in the DSDT/SSDT, so I guess that
> > > confirms it. Which is fine since I've not seem any stability issues
> > > on those machines. So at least nothing seemed to break :)
> > > 
> > > Anyways the changes look all right to me, so for both i915 patches
> > > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > for merging the i915 patches through some other tree if that makes
> > managing the pile easier.
> 
> Actually the idea was for the entire pile to go through the drm-intel
> tree. Daniel can you pick these up please (they seem to be ready) ?

For the future: Both Ville and Jani have commit rights for drm-intel,
Jani's even officially co-maintainer. No need to wait for me to get back
from travelling at all.

I'm applying them now, but only this time :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
