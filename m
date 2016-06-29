From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Wed, 29 Jun 2016 09:56:33 +0200
Message-ID: <20160629075633.GZ29844@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
 <20160613094618.GG1791@lahna.fi.intel.com>
 <20160613094830.GZ29844@pali>
 <20160613095404.GH1791@lahna.fi.intel.com>
 <20160624161238.0fc748ad@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160624161238.0fc748ad@endymion>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Friday 24 June 2016 16:12:38 Jean Delvare wrote:
> Hi Mika,
>=20
> On Mon, 13 Jun 2016 12:54:04 +0300, Mika Westerberg wrote:
> > On Mon, Jun 13, 2016 at 11:48:30AM +0200, Pali Roh=C3=A1r wrote:
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

Yes, this is what I mean...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
