From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 4 Jul 2016 10:22:12 +0200
Message-ID: <20160704102212.319cfd8e@endymion>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
	<20160608162913.GA24234@mail.corp.redhat.com>
	<20160613111946.54779d0d@endymion>
	<20160613094500.GY29844@pali>
	<20160613094618.GG1791@lahna.fi.intel.com>
	<20160613094830.GZ29844@pali>
	<20160613095404.GH1791@lahna.fi.intel.com>
	<20160624161238.0fc748ad@endymion>
	<20160629103951.GX1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39883 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbcGDIWR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jul 2016 04:22:17 -0400
In-Reply-To: <20160629103951.GX1711@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Mika,

On Wed, 29 Jun 2016 13:39:51 +0300, Mika Westerberg wrote:
> On Fri, Jun 24, 2016 at 04:12:38PM +0200, Jean Delvare wrote:
> > I think Pali is correct. The only purpose of handling the region is to
> > detect that it is being accessed so we can set priv->acpi_reserved.
> > Once it is set, i801_acpi_io_handler becomes transparent: it forwards
> > the requests without doing anything with them. The very same would
> > happen if we would unregister the handler at that point, but without the
> > extra overhead.
> > 
> > So while the current code does work fine, unregistering the handler
> > when we set priv->acpi_reserved would be more optimal.
> > 
> > Unless both Pali and myself are missing something, that is.
> 
> I'm not sure unregistering the handler actually resets back to the
> default handler.

I'm no ACPI expert. I read the code of
acpi_remove_address_space_handler() and a few other related ACPI
functions and can't claim I understood it all. But indeed it doesn't
look like it restores the original behavior. Probably
acpi_install_address_space_handler(..., ACPI_ADR_SPACE_SYSTEM_IO,
ACPI_DEFAULT_HANDLER, ...) should be used instead.

This raises another question though: if
acpi_remove_address_space_handler() doesn't restore the previous
behavior then we shouldn't be calling it when the driver is being
unloaded either. As I understand it, it breaks the ACPI handling of the
device.

However I can't test it, as the installed handler is never called
on my system. Can anyone test unloading the i2c-i801 driver on a system
where ACPI actually accesses the device?

After looking at the ACPI code, I am no longer convinced that restoring
the default handler would improve performance. The default handler
itself (acpi_ex_system_io_space_handler) has a lot of overhead. OTOH
this makes me wonder if it is really correct to call
acpi_os_read_port() and acpi_os_write_port() directly.
acpi_ex_system_io_space_handler() calls acpi_hw_read_port() and
acpi_hw_write_port() which perform additional checks. Actually it would
seem safer to call acpi_ex_system_io_space_handler() instead... if it
was exported. Oh well.

> Besides, this patch has been already merged for a while
> so it requires a followup patch on top.

Correct, whatever we do.

-- 
Jean Delvare
SUSE L3 Support
