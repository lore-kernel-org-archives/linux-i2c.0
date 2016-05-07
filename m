From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Sat, 7 May 2016 17:06:33 +0200
Message-ID: <20160507170633.06c56998@endymion>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
	<20160429090351.GS12528@pali>
	<CALCETrXO128w2ZyCj3TV96gS0k_f+9THYmT-Au7s26TLB18tpA@mail.gmail.com>
	<201604292300.23616@pali>
	<CALCETrXF0PnEnHrNXkQJ6dFq3HhF7tRgkOt7zZF5EBinU_Wc+g@mail.gmail.com>
	<CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35683 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcEGPGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 May 2016 11:06:39 -0400
In-Reply-To: <CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>

Hi Andy, Pali,

On Fri, 29 Apr 2016 17:56:14 -0700, Andy Lutomirski wrote:
> On Fri, Apr 29, 2016 at 2:42 PM, Andy Lutomirski <luto@amacapital.net=
> wrote:
> > On Fri, Apr 29, 2016 at 2:00 PM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> >> On Friday 29 April 2016 20:10:23 Andy Lutomirski wrote:
> >>> Jean and Wolfram: is there a quirk mechanism to add i2c devices t=
hat
> >>> aren't directly enumerable but are known to exist due to DMI?
> >>
> >> Maybe something like i2c_register_board_info()?
> >
> > Maybe.  i think that wants to be called before the adapter shows up=
, though.
>=20
> i2c_probe_optional_slaves may be a more appropriate place to put this=
=2E

I can't find any function by that name in the vanilla kernel.

Someone wrote Documentation/i2c/instantiating-devices to explain the
different options to declare an I2C slave device on the system.

In this specific case I suspect option #2 is appropriate, using
i2c_new_probed_device() (or even i2c_new_device() if you are 100%
certain.)

--=20
Jean Delvare
SUSE L3 Support
