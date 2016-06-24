From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Fri, 24 Jun 2016 16:12:38 +0200
Message-ID: <20160624161238.0fc748ad@endymion>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
	<20160608162913.GA24234@mail.corp.redhat.com>
	<20160613111946.54779d0d@endymion>
	<20160613094500.GY29844@pali>
	<20160613094618.GG1791@lahna.fi.intel.com>
	<20160613094830.GZ29844@pali>
	<20160613095404.GH1791@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54724 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbcFXOMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Jun 2016 10:12:44 -0400
In-Reply-To: <20160613095404.GH1791@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Mika,

On Mon, 13 Jun 2016 12:54:04 +0300, Mika Westerberg wrote:
> On Mon, Jun 13, 2016 at 11:48:30AM +0200, Pali Roh=C3=A1r wrote:
> > I mean to call acpi_remove_address_space_handler() in
> > i801_acpi_io_handler() after acpi_reserved is properly set.
> >=20
> > As once acpi_reserved is set address space handler is not needed
> > anymore.
>=20
> It is still needed as we handle all AML OpRegion access in this drive=
r
> from that point forward. Unless I'm missing something.

I think Pali is correct. The only purpose of handling the region is to
detect that it is being accessed so we can set priv->acpi_reserved.
Once it is set, i801_acpi_io_handler becomes transparent: it forwards
the requests without doing anything with them. The very same would
happen if we would unregister the handler at that point, but without th=
e
extra overhead.

So while the current code does work fine, unregistering the handler
when we set priv->acpi_reserved would be more optimal.

Unless both Pali and myself are missing something, that is.

--=20
Jean Delvare
SUSE L3 Support
