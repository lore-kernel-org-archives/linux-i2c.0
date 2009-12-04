From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v2 1/2] acpi: support IBM SMBus CMI devices
Date: Fri, 4 Dec 2009 10:36:35 -0700
Message-ID: <200912041036.36686.bjorn.helgaas@hp.com>
References: <20091021173733.GN26149@tux1.beaverton.ibm.com> <20091027183619.16b0b952@hyperion.delvare> <20091204170621.GA10356@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091204170621.GA10356-bjhdApgbSaxhsM67afOH+sxtgHpCUUYS@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 04 December 2009 10:06:21 am Darrick J. Wong wrote:
> On Tue, Oct 27, 2009 at 06:36:19PM +0100, Jean Delvare wrote:
> > On Tue, 27 Oct 2009 10:30:01 -0700, Darrick J. Wong wrote:
> > > On Tue, Oct 27, 2009 at 06:03:32PM +0100, Jean Delvare wrote:
> > > 
> > > > I'm only half please with this. You change the function named, but it
> > > > doesn't follow the calling convention of acpi_dock_match(), which is a
> > > > little confusing.
> > > > 
> > > > Anyway, I will need an ack from the ACPI people before I can pick this
> > > > patch. Or maybe they should even push it upstream themselves.
> 
> Len/Bjorn: Any opinion on this ACPI quirk patch to make i2c-scmi work on IBM
> systems?  I think the i2c-scmi part is in Jean's tree, but I still need this
> second patch to the ACPI code itself.  Did you pick it up, or should I resend?

I'm a little confused as to where we left things.  Can you repost
the current series in a new thread?  It looks like there might be
places that use "SMBUSIBM" when they should use ACPI_SMBUS_IBM_HID.

Bjorn
