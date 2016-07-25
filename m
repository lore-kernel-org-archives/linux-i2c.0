From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 25 Jul 2016 12:22:29 +0200
Message-ID: <20160725102229.GV29844@pali>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160704102212.319cfd8e@endymion>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday 04 July 2016 10:22:12 Jean Delvare wrote:
> Hi Mika,
>=20
> On Wed, 29 Jun 2016 13:39:51 +0300, Mika Westerberg wrote:
> > On Fri, Jun 24, 2016 at 04:12:38PM +0200, Jean Delvare wrote:
> > > I think Pali is correct. The only purpose of handling the region =
is to
> > > detect that it is being accessed so we can set priv->acpi_reserve=
d.
> > > Once it is set, i801_acpi_io_handler becomes transparent: it forw=
ards
> > > the requests without doing anything with them. The very same woul=
d
> > > happen if we would unregister the handler at that point, but with=
out the
> > > extra overhead.
> > >=20
> > > So while the current code does work fine, unregistering the handl=
er
> > > when we set priv->acpi_reserved would be more optimal.
> > >=20
> > > Unless both Pali and myself are missing something, that is.
> >=20
> > I'm not sure unregistering the handler actually resets back to the
> > default handler.
>=20
> I'm no ACPI expert. I read the code of
> acpi_remove_address_space_handler() and a few other related ACPI
> functions and can't claim I understood it all. But indeed it doesn't
> look like it restores the original behavior. Probably
> acpi_install_address_space_handler(..., ACPI_ADR_SPACE_SYSTEM_IO,
> ACPI_DEFAULT_HANDLER, ...) should be used instead.
>=20
> This raises another question though: if
> acpi_remove_address_space_handler() doesn't restore the previous
> behavior then we shouldn't be calling it when the driver is being
> unloaded either. As I understand it, it breaks the ACPI handling of t=
he
> device.
>=20
> However I can't test it, as the installed handler is never called
> on my system. Can anyone test unloading the i2c-i801 driver on a syst=
em
> where ACPI actually accesses the device?
>=20
> After looking at the ACPI code, I am no longer convinced that restori=
ng
> the default handler would improve performance. The default handler
> itself (acpi_ex_system_io_space_handler) has a lot of overhead. OTOH
> this makes me wonder if it is really correct to call
> acpi_os_read_port() and acpi_os_write_port() directly.
> acpi_ex_system_io_space_handler() calls acpi_hw_read_port() and
> acpi_hw_write_port() which perform additional checks. Actually it wou=
ld
> seem safer to call acpi_ex_system_io_space_handler() instead... if it
> was exported. Oh well.
>=20
> > Besides, this patch has been already merged for a while
> > so it requires a followup patch on top.
>=20
> Correct, whatever we do.
>=20

Now Martin Vajnar confirmed that accelerometer on his notebook working
fine with that patch. But it does not mean that we should not fix
address space handler code in i801 correctly...

Can some ACPI expert look at it? Jean already wrote some useful
informations.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
