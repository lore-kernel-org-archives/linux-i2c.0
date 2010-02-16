From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Tue, 16 Feb 2010 22:49:47 +0100
Message-ID: <20100216224947.5c46ff86@hyperion.delvare>
References: <4B73DAEE.5080400@compulab.co.il>
	<4B73DB4B.40501@compulab.co.il>
	<201002161157.47196.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002161157.47196.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 16 Feb 2010 11:57:46 -0800, David Brownell wrote:
> On Thursday 11 February 2010, Denis Turischev wrote:
> > Intel Poulsbo (SCH) chipset LPC bridge controller contains several
> > functions. Creating and MFD driver for the LPC bridge controller allows
> 
> Spelling nit: "Creating an" (not and).  Keyboard, brain, or edit fault.  ;)
> 
> 
> > simultaneous use of SMBus and GPIO interfaces on the SCH.
> 
> This looks like the right way to package such southbridge level
> componentry.  Maye not just these two interfaces, either.
> 
> But ... how does this play with ACPI?  The last several Intel
> systems I looked at seemed to expect ACPI to manage GPIOs and the
> IRQs they may issue.  (He wrote, staring at an ICH8-system where
> ACPI uses GPIOs to manage several buttons and LEDs.)
> 
> It would seem error-prone to ignore that coupling on systems
> with ACPI.  Linux has enough trouble sorting out issues caused
> by buggy AML (ACPI bytecode) without introducing conflicts in
> who manages which hardware resource (ACPI vs. operating system).

Might be a good idea to use acpi_check_resource_conflict() or similar
before instantiating the platform devices.

> Of course, if ACPI weren't being used to hide such board-specific
> details from operating systems, such issues would not exist.  But
> such hiding is one of the basic goals of ACPI ... annoying.

Don't start me on this :(

-- 
Jean Delvare
