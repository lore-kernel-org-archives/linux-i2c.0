From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Fri, 13 Jan 2017 11:26:44 +0200
Message-ID: <20170113092644.GD31595@intel.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-2-hdegoede@redhat.com>
 <20170102141242.GY31595@intel.com>
 <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:44382 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdAMJ0t (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Jan 2017 04:26:49 -0500
Content-Disposition: inline
In-Reply-To: <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On Mon, Jan 02, 2017 at 03:21:13PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-01-17 15:12, Ville Syrjälä wrote:
> > On Sun, Jan 01, 2017 at 09:14:00PM +0100, Hans de Goede wrote:
> >> The punit on baytrail / cherrytrail systems is not only accessed through
> >> the iosf_mbi functions, but also by the i915 code. Add a mutex to protect
> >> the punit against simultaneous accesses and 2 functions to lock / unlock
> >> this mutex.
> >
> > I'm not sure which part of punit you're actually trying to protect
> > here. Some specific registers?
> 
> The theory I'm going by is that for certain actions / certain requests
> we send to the punit, the punit needs to access the (axp288) pmic, to
> change (or enable / disable) certain voltages.

At least for cpu/display/gt voltages that shouldn't really be the case.
The vcc/vnn/vgg rails are controlled via svid, not i2c.

It also feels quite hand wavy since the punit could do whatever at
any time AFAIK. Eg. if there's some thermal event or something the
punit might kick into action. So trying to protect this from the OS
side might not be able to avoid these problems entirely. It feels like
there really should be some kind of shared hardware/firmware mutex
with the punit to arbitrate access to the i2c bus.

> So it needs to access the pmic i2c bus, but in some cases the kernel
> is accessing this itself (e.g. for battery monitoring) and is holding
> the punit i2c bus semaphore. At least with CPU-core C-state transitions,
> this seems to be happening, if I do read i2c transfers on the pmic
> i2c bus repeatedly without blocking the CPU from entering C6 (*) while
> accessing the i2c bus my cherrytrail tablet will freeze in 10 - 30
> seconds.
> 
> The findings of one of the users commenting in:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=155241
> 
> Seem to indicate a similar problem with the i915 driver doing
> power-management while the i2c-designware-baytrail code is holding
> the punit i2c bus semaphore. One would hope that the punit would be
> smart enough to simply wait for the semaphore to get released in that
> case, but at least for the C6 CPU core transition it seems that allowing
> that to happen while holding the semaphore causes a hard crash of the
> SoC. So I guess that for explicit requests the punit code assumes that
> the OS is not holding the semaphore.
> 
> Regards,
> 
> Hans
> 
> 
> 
> *) which powers off most of the core, so likely causes interaction with
> the pmic
> 
> 
> >
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  arch/x86/include/asm/iosf_mbi.h    | 19 +++++++++++++++++++
> >>  arch/x86/platform/intel/iosf_mbi.c | 13 +++++++++++++
> >>  2 files changed, 32 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
> >> index b41ee16..02963bd 100644
> >> --- a/arch/x86/include/asm/iosf_mbi.h
> >> +++ b/arch/x86/include/asm/iosf_mbi.h
> >> @@ -88,6 +88,21 @@ int iosf_mbi_write(u8 port, u8 opcode, u32 offset, u32 mdr);
> >>   */
> >>  int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
> >>
> >> +/**
> >> + * iosf_mbi_punit_lock() - Lock the punit mutex
> >> + *
> >> + * This function must be called before accessing the punit or the pmic, be it
> >> + * through iosf_mbi_* or through other means.
> >> + *
> >> + * This function locks a mutex, as such it may sleep.
> >> + */
> >> +void iosf_mbi_punit_lock(void);
> >> +
> >> +/**
> >> + * iosf_mbi_punit_unlock() - Unlock the punit mutex
> >> + */
> >> +void iosf_mbi_punit_unlock(void);
> >> +
> >>  #else /* CONFIG_IOSF_MBI is not enabled */
> >>  static inline
> >>  bool iosf_mbi_available(void)
> >> @@ -115,6 +130,10 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask)
> >>  	WARN(1, "IOSF_MBI driver not available");
> >>  	return -EPERM;
> >>  }
> >> +
> >> +static inline void iosf_mbi_punit_lock(void) {}
> >> +static inline void iosf_mbi_punit_unlock(void) {}
> >> +
> >>  #endif /* CONFIG_IOSF_MBI */
> >>
> >>  #endif /* IOSF_MBI_SYMS_H */
> >> diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
> >> index edf2c54..75d8135 100644
> >> --- a/arch/x86/platform/intel/iosf_mbi.c
> >> +++ b/arch/x86/platform/intel/iosf_mbi.c
> >> @@ -34,6 +34,7 @@
> >>
> >>  static struct pci_dev *mbi_pdev;
> >>  static DEFINE_SPINLOCK(iosf_mbi_lock);
> >> +static DEFINE_MUTEX(iosf_mbi_punit_mutex);
> >>
> >>  static inline u32 iosf_mbi_form_mcr(u8 op, u8 port, u8 offset)
> >>  {
> >> @@ -190,6 +191,18 @@ bool iosf_mbi_available(void)
> >>  }
> >>  EXPORT_SYMBOL(iosf_mbi_available);
> >>
> >> +void iosf_mbi_punit_lock(void)
> >> +{
> >> +	mutex_lock(&iosf_mbi_punit_mutex);
> >> +}
> >> +EXPORT_SYMBOL(iosf_mbi_punit_lock);
> >> +
> >> +void iosf_mbi_punit_unlock(void)
> >> +{
> >> +	mutex_unlock(&iosf_mbi_punit_mutex);
> >> +}
> >> +EXPORT_SYMBOL(iosf_mbi_punit_unlock);
> >> +
> >>  #ifdef CONFIG_IOSF_MBI_DEBUG
> >>  static u32	dbg_mdr;
> >>  static u32	dbg_mcr;
> >> --
> >> 2.9.3
> >

-- 
Ville Syrjälä
Intel OTC
