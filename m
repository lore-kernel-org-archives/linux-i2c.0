From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Thu, 5 May 2016 10:27:25 +0200
Message-ID: <20160505082725.GQ12528@pali>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160429090351.GS12528@pali>
 <CALCETrXO128w2ZyCj3TV96gS0k_f+9THYmT-Au7s26TLB18tpA@mail.gmail.com>
 <201604292300.23616@pali>
 <CALCETrXF0PnEnHrNXkQJ6dFq3HhF7tRgkOt7zZF5EBinU_Wc+g@mail.gmail.com>
 <CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34849 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbcEEI13 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 04:27:29 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>

On Friday 29 April 2016 17:56:14 Andy Lutomirski wrote:
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

I cannot find function i2c_probe_optional_slaves. Where is it?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
