From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Wed, 22 Jun 2016 18:52:52 +0200
Message-ID: <20160622185252.5ecfdf1d@endymion>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
	<1434710432-4182-2-git-send-email-wsa@the-dreams.de>
	<20160427173308.GN7946@pengutronix.de>
	<20160619195641.GD26875@pengutronix.de>
	<20160621111255.1a27363e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40263 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbcFVQw6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Jun 2016 12:52:58 -0400
In-Reply-To: <20160621111255.1a27363e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Hi all,

On Tue, 21 Jun 2016 11:12:55 +0200, Jean Delvare wrote:
> On Sun, 19 Jun 2016 21:56:41 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Note, I didn't check if this patch got applied in the meantime, m=
y
> > > excuse is that http://lm-sensors.org where AFAIK the i2c-tools re=
po is
> > > located isn't reachable for me.
> >=20
> > This still stands. Where is the upstream repository of i2c-tools?
>=20
> lm-sensors.org is dead, I am in the process of creating an i2c-tools
> repository at kernel.org. In the meantime you can use Guenter's git
> tree as a reference:
>=20
> https://github.com/groeck/i2c-tools
>=20
> (This is what I will use as a base for the kernel.org repository.)

This is (almost) done now. The new home of the i2c-tools repository is:

http://git.kernel.org/cgit/utils/i2c-tools/i2c-tools.git/

Guenter, Wolfram and myself have write access. As explained before, it
is based on Guenter's git mirror of the SVN repository, with the
following changes:

1* I removed the SVN tags and added clean git tags instead. SVN tags
were not so great because SVN treats tags as separate "commits" which
do not appear on the working branches. The tags I added are the parents
of the the tags I removed, they reference the same code, but in a way
that they do show up on the working branches.

2* I replaced my obsolete e-mail address by a working one for all
commits I was the author of.

When I pushed the result to kernel.org, it showed a numbers of strange
branches, maybe the result of the SVN conversion, or I messed up at
some point. I tried to clean up, please let me know if you spot
anything weird left.

We are almost there, except that a few commits went to the
i2c-tools-3.1 branch AFTER Guenter mirrored it for the last time, so
they are missing from the git tree. I will extract them from my local
copy tomorrow and commit them.

Wolfram, I was thinking maybe we could create
Documentation/i2c/userspace-tools with a pointer to the new repository?
Or if you have any other idea where it should be referenced? I've added
a pointer to the wiki already.

--=20
Jean Delvare
SUSE L3 Support
