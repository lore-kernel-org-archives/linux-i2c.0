From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Wed, 29 Jun 2016 13:39:51 +0300
Message-ID: <20160629103951.GX1711@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
 <20160613094618.GG1791@lahna.fi.intel.com>
 <20160613094830.GZ29844@pali>
 <20160613095404.GH1791@lahna.fi.intel.com>
 <20160624161238.0fc748ad@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46489 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbcF2Kj4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 29 Jun 2016 06:39:56 -0400
Content-Disposition: inline
In-Reply-To: <20160624161238.0fc748ad@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Jun 24, 2016 at 04:12:38PM +0200, Jean Delvare wrote:
> Hi Mika,
>=20
> On Mon, 13 Jun 2016 12:54:04 +0300, Mika Westerberg wrote:
> > On Mon, Jun 13, 2016 at 11:48:30AM +0200, Pali Roh=E1r wrote:
> > > I mean to call acpi_remove_address_space_handler() in
> > > i801_acpi_io_handler() after acpi_reserved is properly set.
> > >=20
> > > As once acpi_reserved is set address space handler is not needed
> > > anymore.
> >=20
> > It is still needed as we handle all AML OpRegion access in this dri=
ver
> > from that point forward. Unless I'm missing something.
>=20
> I think Pali is correct. The only purpose of handling the region is t=
o
> detect that it is being accessed so we can set priv->acpi_reserved.
> Once it is set, i801_acpi_io_handler becomes transparent: it forwards
> the requests without doing anything with them. The very same would
> happen if we would unregister the handler at that point, but without =
the
> extra overhead.
>=20
> So while the current code does work fine, unregistering the handler
> when we set priv->acpi_reserved would be more optimal.
>=20
> Unless both Pali and myself are missing something, that is.

I'm not sure unregistering the handler actually resets back to the
default handler. Besides, this patch has been already merged for a whil=
e
so it requires a followup patch on top.
