From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Tue, 5 Jul 2016 13:14:55 +0300
Message-ID: <20160705101455.GM23527@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
 <20160613094618.GG1791@lahna.fi.intel.com>
 <20160613094830.GZ29844@pali>
 <20160613095404.GH1791@lahna.fi.intel.com>
 <20160624161238.0fc748ad@endymion>
 <20160629103951.GX1711@lahna.fi.intel.com>
 <20160704102212.319cfd8e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12499 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbcGEKPC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jul 2016 06:15:02 -0400
Content-Disposition: inline
In-Reply-To: <20160704102212.319cfd8e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jul 04, 2016 at 10:22:12AM +0200, Jean Delvare wrote:
> Hi Mika,
> 
> On Wed, 29 Jun 2016 13:39:51 +0300, Mika Westerberg wrote:
> > On Fri, Jun 24, 2016 at 04:12:38PM +0200, Jean Delvare wrote:
> > > I think Pali is correct. The only purpose of handling the region is to
> > > detect that it is being accessed so we can set priv->acpi_reserved.
> > > Once it is set, i801_acpi_io_handler becomes transparent: it forwards
> > > the requests without doing anything with them. The very same would
> > > happen if we would unregister the handler at that point, but without the
> > > extra overhead.
> > > 
> > > So while the current code does work fine, unregistering the handler
> > > when we set priv->acpi_reserved would be more optimal.
> > > 
> > > Unless both Pali and myself are missing something, that is.
> > 
> > I'm not sure unregistering the handler actually resets back to the
> > default handler.
> 
> I'm no ACPI expert. I read the code of
> acpi_remove_address_space_handler() and a few other related ACPI
> functions and can't claim I understood it all. But indeed it doesn't
> look like it restores the original behavior. Probably
> acpi_install_address_space_handler(..., ACPI_ADR_SPACE_SYSTEM_IO,
> ACPI_DEFAULT_HANDLER, ...) should be used instead.
> 
> This raises another question though: if
> acpi_remove_address_space_handler() doesn't restore the previous
> behavior then we shouldn't be calling it when the driver is being
> unloaded either. As I understand it, it breaks the ACPI handling of the
> device.
> 
> However I can't test it, as the installed handler is never called
> on my system. Can anyone test unloading the i2c-i801 driver on a system
> where ACPI actually accesses the device?

The whole point of this patch is that we expect that nobody never uses
that OpRegion. I'm 99% sure you don't find a single machine where it is
actually in use.

The fallback code is there just to be sure we do not blow things up if
it turns out some machine is using that.

I think the best we can do is to lock down the module (prevent it from
unloading) if we notice that the OpRegion is used.
