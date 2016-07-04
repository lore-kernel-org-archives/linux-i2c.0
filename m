From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 4 Jul 2016 16:30:50 +0200
Message-ID: <20160704143050.GP29844@pali>
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
To: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday 04 July 2016 10:22:12 Jean Delvare wrote:
> However I can't test it, as the installed handler is never called
> on my system. Can anyone test unloading the i2c-i801 driver on a syst=
em
> where ACPI actually accesses the device?

I remember that HP EliteBooks with HDD accelerometer protection use
hp_accel ACPI driver which use that ACPI SBUS device. But I do not own
EliteBooks anymore... Maybe someone else can test? What I found probabl=
y
find are ACPI DSDT dumps from those machines, but do not know if that
can help...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
