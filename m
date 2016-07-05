From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Tue, 5 Jul 2016 17:31:15 +0300
Message-ID: <20160705143115.GP23527@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160705115142.GO23527@lahna.fi.intel.com>
 <201607051356.58794@pali>
 <201607051400.58881@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63021 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbcGEObV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jul 2016 10:31:21 -0400
Content-Disposition: inline
In-Reply-To: <201607051400.58881@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Martin Vajnar <martin.vajnar@gmail.com>, Dominique Leuenberger <dimstar@opensuse.org>

On Tue, Jul 05, 2016 at 02:00:58PM +0200, Pali Roh=E1r wrote:
> On Tuesday 05 July 2016 13:56:58 Pali Roh=E1r wrote:
> > On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
> > > So are you able to test what happens when you unload the driver?
> >=20
> > As I wrote in previous email, I do not own these EliteBooks anymore=
,
> > so cannot test it. Just have DSDT dump...
>=20
> What about contacting last contributors to hp_accel.c driver? They=20
> probably could test i801 changes if accelerometer still works.

Good idea.

Added Martin and Dominique who did the last additions to that driver
(hp_accel.c).

Do you guys still have your HP machines around? If yes, maybe you can
try v4.7-rc3+ (it should include commit a7ae81952cda ("i2c: i801: Allow
ACPI SystemIO OpRegion to conflict with PCI BAR")) so that you unload
i2c-i801.ko and see if accelerometer still works?
