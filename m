From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 25 Jul 2016 12:19:18 +0200
Message-ID: <20160725101918.GU29844@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160705115142.GO23527@lahna.fi.intel.com>
 <201607051356.58794@pali>
 <201607051400.58881@pali>
 <20160705143115.GP23527@lahna.fi.intel.com>
 <CAHHiRUQXt_ofTsLzwZWJPXe_-wPE-hAeTxbdnJt03V89rAJpNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHHiRUQXt_ofTsLzwZWJPXe_-wPE-hAeTxbdnJt03V89rAJpNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Martin Vajnar <martin.vajnar@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Dominique Leuenberger <dimstar@opensuse.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 24 July 2016 12:08:25 Martin Vajnar wrote:
> 2016-07-05 16:31 GMT+02:00 Mika Westerberg <mika.westerberg@linux.int=
el.com>:
> > On Tue, Jul 05, 2016 at 02:00:58PM +0200, Pali Roh=C3=A1r wrote:
> >> On Tuesday 05 July 2016 13:56:58 Pali Roh=C3=A1r wrote:
> >> > On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
> >> > > So are you able to test what happens when you unload the drive=
r?
> >> >
> >> > As I wrote in previous email, I do not own these EliteBooks anym=
ore,
> >> > so cannot test it. Just have DSDT dump...
> >>
> >> What about contacting last contributors to hp_accel.c driver? They
> >> probably could test i801 changes if accelerometer still works.
> >
> > Good idea.
> >
> > Added Martin and Dominique who did the last additions to that drive=
r
> > (hp_accel.c).
> >
> > Do you guys still have your HP machines around? If yes, maybe you c=
an
> > try v4.7-rc3+ (it should include commit a7ae81952cda ("i2c: i801: A=
llow
> > ACPI SystemIO OpRegion to conflict with PCI BAR")) so that you unlo=
ad
> > i2c-i801.ko and see if accelerometer still works?
>=20
> I still have the HP ProBook 440 G3. I used v4.7-rc7 for the test. I
> tested all combinations of loading/unloading both hp_accel and
> i2c_i801 modules and whenever the hp_accel was loaded the
> accelerometer worked fine.
>=20
> Regards,
> -Martin Vajnar

Great! Thank you for testing.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
