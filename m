From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Thu, 14 Jul 2016 16:20:36 +0200
Message-ID: <4200975.LdYuAt9PZR@vostro.rjw.lan>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com> <201607051400.58881@pali> <20160714115218.GC29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43048 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751117AbcGNOPw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 10:15:52 -0400
In-Reply-To: <20160714115218.GC29844@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, July 14, 2016 01:52:18 PM Pali Roh=C3=A1r wrote:
> On Tuesday 05 July 2016 14:00:58 Pali Roh=C3=A1r wrote:
> > On Tuesday 05 July 2016 13:56:58 Pali Roh=C3=A1r wrote:
> > > On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
> > > > So are you able to test what happens when you unload the driver=
?
> > >=20
> > > As I wrote in previous email, I do not own these EliteBooks anymo=
re,
> > > so cannot test it. Just have DSDT dump...
> >=20
> > What about contacting last contributors to hp_accel.c driver? They=20
> > probably could test i801 changes if accelerometer still works.
>=20
> Or another option how to test this: Use acpi_call module which export=
s
> file /proc/acpi/call which can be used to issue ACPI method call from
> userspace.
>=20
> If there are problems, there will be errors in dmesg or return value
> from /proc/acpi/call is some error...

That is plain dangerous, because some objects may not be evaulated with=
out
preparation.

We had something like that before and dropped it.

We have an AML debugger in the kernel now, though, which in principle m=
ay
be used for such diagnostics I think.

Thanks,
Rafael
