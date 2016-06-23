From: Jean Delvare <jdelvare@suse.de>
Subject: Re: New location for i2c-tools.git
Date: Thu, 23 Jun 2016 11:53:14 +0200
Message-ID: <20160623115314.1e20f84f@endymion>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
	<1434710432-4182-2-git-send-email-wsa@the-dreams.de>
	<20160427173308.GN7946@pengutronix.de>
	<20160619195641.GD26875@pengutronix.de>
	<20160621111255.1a27363e@endymion>
	<20160622185252.5ecfdf1d@endymion>
	<20160623073249.GM26875@pengutronix.de>
	<CA+TH9VkztGak0FugD0zLgOigBope5pT4FheQJkqhvg3xrnUxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbcFWJxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Jun 2016 05:53:17 -0400
In-Reply-To: <CA+TH9VkztGak0FugD0zLgOigBope5pT4FheQJkqhvg3xrnUxcw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Hi Angelo,

On Thu, 23 Jun 2016 09:57:49 +0200, Angelo Compagnucci wrote:
> 2016-06-23 9:32 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@peng=
utronix.de>:
> > Hello,
> >
> > mainly for the archives I reply with an updated Subject.
> >
> > On Wed, Jun 22, 2016 at 06:52:52PM +0200, Jean Delvare wrote:
> >> The new home of the i2c-tools repository is:
> >>
> >> http://git.kernel.org/cgit/utils/i2c-tools/i2c-tools.git/
>=20
> This repository presents something strange, the tagged release 3.1.2
> of some months ago is no more.
>=20
> This is quite awful cause some distributions (ex: buildroot ) used
> that tag as the latest released version and now they are broken.
>=20
> Can anyone fix this?

Quoting myself from yesterday in this very thread:

"We are almost there, except that a few commits went to the
i2c-tools-3.1 branch AFTER Guenter mirrored it for the last time, so
they are missing from the git tree. I will extract them from my local
copy tomorrow and commit them."

Yesterday's tomorrow is today.

--=20
Jean Delvare
SUSE L3 Support
