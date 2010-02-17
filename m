From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Wed, 17 Feb 2010 15:37:44 +0100
Message-ID: <20100217143743.GB3011@sortiz.org>
References: <4B73DAEE.5080400@compulab.co.il>
 <4B73DB4B.40501@compulab.co.il>
 <201002161157.47196.david-b@pacbell.net>
 <20100216224947.5c46ff86@hyperion.delvare>
 <4B7BBEE5.3040104@compulab.co.il>
 <20100217114433.6a405bd3@hyperion.delvare>
 <4B7BE292.5080700@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B7BE292.5080700-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Wed, Feb 17, 2010 at 02:35:30PM +0200, Mike Rapoport wrote:
> Samuel,
> 
> Jean Delvare wrote:
> > On Wed, 17 Feb 2010 12:03:17 +0200, Denis Turischev wrote:
> >> Jean Delvare wrote:
> >>> Might be a good idea to use acpi_check_resource_conflict() or similar
> >>> before instantiating the platform devices.
> >> May be it worth to add such resource check directly to mfd_add_device function?
> > 
> > I'm not sure. I suspect that many MFD devices are never used on
> > ACPI-aware systems, so it might be considered overkill. OTOH the calls
> > resolve to empty stubs when ACPI is disabled so... I have no objection,
> > but I'll leave the decision to somebody else ;)
> > 
> 
> What do you think? Shall we add something like mfd_verify_resources that will call
> acpi_check_region or something similar?
Yes, that sounds like a reasonable idea. We should probably call
acpi_check_resource_conflict() straight from mfd_add_device(). I'll do that,
no need for Denis to add that patch for its code to be merged.

Cheers,
Samuel.


> 
> -- 
> Sincerely yours,
> Mike.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
