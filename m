From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 13 Jun 2016 12:54:04 +0300
Message-ID: <20160613095404.GH1791@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160608162913.GA24234@mail.corp.redhat.com>
 <20160613111946.54779d0d@endymion>
 <20160613094500.GY29844@pali>
 <20160613094618.GG1791@lahna.fi.intel.com>
 <20160613094830.GZ29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160613094830.GZ29844@pali>
Sender: linux-acpi-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 13, 2016 at 11:48:30AM +0200, Pali Roh=E1r wrote:
> I mean to call acpi_remove_address_space_handler() in
> i801_acpi_io_handler() after acpi_reserved is properly set.
>=20
> As once acpi_reserved is set address space handler is not needed
> anymore.

It is still needed as we handle all AML OpRegion access in this driver
from that point forward. Unless I'm missing something.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
