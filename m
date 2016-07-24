From: Martin Vajnar <martin.vajnar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Sun, 24 Jul 2016 12:08:25 +0200
Message-ID: <CAHHiRUQXt_ofTsLzwZWJPXe_-wPE-hAeTxbdnJt03V89rAJpNQ@mail.gmail.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160705115142.GO23527@lahna.fi.intel.com> <201607051356.58794@pali>
 <201607051400.58881@pali> <20160705143115.GP23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36667 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcGXKIq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 24 Jul 2016 06:08:46 -0400
In-Reply-To: <20160705143115.GP23527@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Dominique Leuenberger <dimstar@opensuse.org>

2016-07-05 16:31 GMT+02:00 Mika Westerberg <mika.westerberg@linux.intel=
=2Ecom>:
> On Tue, Jul 05, 2016 at 02:00:58PM +0200, Pali Roh=C3=A1r wrote:
>> On Tuesday 05 July 2016 13:56:58 Pali Roh=C3=A1r wrote:
>> > On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
>> > > So are you able to test what happens when you unload the driver?
>> >
>> > As I wrote in previous email, I do not own these EliteBooks anymor=
e,
>> > so cannot test it. Just have DSDT dump...
>>
>> What about contacting last contributors to hp_accel.c driver? They
>> probably could test i801 changes if accelerometer still works.
>
> Good idea.
>
> Added Martin and Dominique who did the last additions to that driver
> (hp_accel.c).
>
> Do you guys still have your HP machines around? If yes, maybe you can
> try v4.7-rc3+ (it should include commit a7ae81952cda ("i2c: i801: All=
ow
> ACPI SystemIO OpRegion to conflict with PCI BAR")) so that you unload
> i2c-i801.ko and see if accelerometer still works?

I still have the HP ProBook 440 G3. I used v4.7-rc7 for the test. I
tested all combinations of loading/unloading both hp_accel and
i2c_i801 modules and whenever the hp_accel was loaded the
accelerometer worked fine.

Regards,
-Martin Vajnar
