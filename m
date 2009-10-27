From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] acpi: support IBM SMBus CMI devices
Date: Tue, 27 Oct 2009 18:36:19 +0100
Message-ID: <20091027183619.16b0b952@hyperion.delvare>
References: <20091021023016.GC32413@crane-desktop>
	<200910210857.13978.bjorn.helgaas@hp.com>
	<20091021173733.GN26149@tux1.beaverton.ibm.com>
	<20091022071748.GA17917@crane-desktop>
	<20091022174304.GO26149@tux1.beaverton.ibm.com>
	<20091023044451.GB1367@crane-desktop>
	<20091023170311.GC21723@tux1.beaverton.ibm.com>
	<20091025125353.55d3bfad@hyperion.delvare>
	<20091026205819.GR26149@tux1.beaverton.ibm.com>
	<20091027180332.62f2c758@hyperion.delvare>
	<20091027173001.GT26149@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091027173001.GT26149-bjhdApgbSaxhsM67afOH+sxtgHpCUUYS@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Cc: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 27 Oct 2009 10:30:01 -0700, Darrick J. Wong wrote:
> On Tue, Oct 27, 2009 at 06:03:32PM +0100, Jean Delvare wrote:
> 
> > I'm only half please with this. You change the function named, but it
> > doesn't follow the calling convention of acpi_dock_match(), which is a
> > little confusing.
> > 
> > Anyway, I will need an ack from the ACPI people before I can pick this
> > patch. Or maybe they should even push it upstream themselves.
> 
> I am confused.  Looking at that bunch of ifs, acpi_is_video_device returns 1
> for a match and 0 for no match.  acpi_bay_match returns 0 for a match and
> -ENODEV for no match, which just happens to work with the ACPI_SUCCESS macro.
> acpi_dock_match returns ACPI error codes.  Each of the three existing tests has
> different return value semantics, so it is not clear to me which one I should
> use.

Ah, sorry, I looked at one (don't remember which one) and assumed the
other ones followed the same convention.

> I didn't think it was correct for my probe function to use the ACPI_STATUS
> macro unless it returned ACPI error codes... which it does not.  -ENODEV seemed
> appropriate for "no device found".
> 
> Is it desirable to clean them all up to follow the same convention?

Ideally, yes, but that would be a separate task from what you're up to
at the moment. And anyway this is not in my realm an I am not going to
work on it myself, so my opinion probably doesn't matter that much.
Sorry for bothering you with this in the first place.

-- 
Jean Delvare
