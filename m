From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Thu, 14 Jul 2016 13:52:18 +0200
Message-ID: <20160714115218.GC29844@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160705115142.GO23527@lahna.fi.intel.com>
 <201607051356.58794@pali>
 <201607051400.58881@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37179 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbcGNLwZ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 07:52:25 -0400
Content-Disposition: inline
In-Reply-To: <201607051400.58881@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 05 July 2016 14:00:58 Pali Roh=C3=A1r wrote:
> On Tuesday 05 July 2016 13:56:58 Pali Roh=C3=A1r wrote:
> > On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
> > > So are you able to test what happens when you unload the driver?
> >=20
> > As I wrote in previous email, I do not own these EliteBooks anymore=
,
> > so cannot test it. Just have DSDT dump...
>=20
> What about contacting last contributors to hp_accel.c driver? They=20
> probably could test i801 changes if accelerometer still works.

Or another option how to test this: Use acpi_call module which exports
file /proc/acpi/call which can be used to issue ACPI method call from
userspace.

If there are problems, there will be errors in dmesg or return value
from /proc/acpi/call is some error...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
