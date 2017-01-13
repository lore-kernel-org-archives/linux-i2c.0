From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Fri, 13 Jan 2017 18:30:05 +0200
Message-ID: <20170113163005.GK31595@intel.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-2-hdegoede@redhat.com>
 <20170102141242.GY31595@intel.com>
 <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
 <20170113092644.GD31595@intel.com>
 <a213718a-b4e9-09a0-a97f-69eb5e892151@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:1479 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdAMQaK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Jan 2017 11:30:10 -0500
Content-Disposition: inline
In-Reply-To: <a213718a-b4e9-09a0-a97f-69eb5e892151@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On Fri, Jan 13, 2017 at 05:06:52PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 01/13/2017 10:26 AM, Ville Syrjälä wrote:
> > On Mon, Jan 02, 2017 at 03:21:13PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 02-01-17 15:12, Ville Syrjälä wrote:
> >>> On Sun, Jan 01, 2017 at 09:14:00PM +0100, Hans de Goede wrote:
> >>>> The punit on baytrail / cherrytrail systems is not only accessed through
> >>>> the iosf_mbi functions, but also by the i915 code. Add a mutex to protect
> >>>> the punit against simultaneous accesses and 2 functions to lock / unlock
> >>>> this mutex.
> >>>
> >>> I'm not sure which part of punit you're actually trying to protect
> >>> here. Some specific registers?
> >>
> >> The theory I'm going by is that for certain actions / certain requests
> >> we send to the punit, the punit needs to access the (axp288) pmic, to
> >> change (or enable / disable) certain voltages.
> >
> > At least for cpu/display/gt voltages that shouldn't really be the case.
> > The vcc/vnn/vgg rails are controlled via svid, not i2c.
> 
> Are you sure? The ax288 pmic does not have a svid interface, only
> an i2c interface, and AFAICT its buck DCDC converters are used to
> feed all of these.

Yes, looks like you're right. I guess someone didn't want to spend three
pins for svid.

> 
> > It also feels quite hand wavy since the punit could do whatever at
> > any time AFAIK. Eg. if there's some thermal event or something the
> > punit might kick into action. So trying to protect this from the OS
> > side might not be able to avoid these problems entirely. It feels like
> > there really should be some kind of shared hardware/firmware mutex
> > with the punit to arbitrate access to the i2c bus.
> 
> Right, and there is such a mutex (which only gets used on systems
> with an axp288 pmic...) and we are taking this mutex before starting
> an i2c transaction on the pmic i2c bus. But this does not seem to be
> enough. It seems the the punit does not check the mutex before
> certain OS / host triggered actions. I guess it expects the host to
> do this itself.
> 
> Please see my new (non RFC) version of this series I've posted.
> 
> There are at least 2 problems when relying solely on the punit
> pmic i2c bus sempaphore:
> 
> 1) CPU C1 <-> C6 transations happening while the pmic i2c bus
> is being accessed by the host cause the system to hang
> 2) i915 (runtime) suspend resume fails every other attempt
> with timeouts when trying to get a forcewake lock inn i915,
> often followed by a system freeze shortly after this.

Hmm. But forcewake works at other times? That seems quite strange.
Runtime suspend itself shouldn't really do much, and if we're still
poking at the the hw then we haven't really even suspended anything
yet, so having failing forcewake doesn't sounds at all good.

-- 
Ville Syrjälä
Intel OTC
