From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 10:03:07 +0100
Message-ID: <20151112090307.GH24008@pengutronix.de>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074447.GA24008@pengutronix.de>
 <20151112075238.GA1551@katana>
 <20151112080926.GC24008@pengutronix.de>
 <20151112084837.GA2782@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59620 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbbKLJDJ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 04:03:09 -0500
Content-Disposition: inline
In-Reply-To: <20151112084837.GA2782@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 12, 2015 at 09:48:37AM +0100, Wolfram Sang wrote:
> On Thu, Nov 12, 2015 at 09:09:26AM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Wolfram,
> >=20
> > On Thu, Nov 12, 2015 at 08:52:38AM +0100, Wolfram Sang wrote:
> > > On Thu, Nov 12, 2015 at 08:44:47AM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > Other than that, the NULL pointer dereference should only happe=
n if the
> > > > device was bound using the driver name. That might be worth to =
point out
> > > > in the commit log. So maybe make (in a separate patch) the prob=
e
> > > > function fail when probed by name?
> > >=20
> > > RCar is a DT only platform.
> >=20
> > Does this imply that no checking is needed? I'm not sure.
>=20
> I don't see how this driver could get probed otherwise. That being sa=
id,
> for the "better safe than sorry" approach, I'd accept your suggestion=
=2E

Try adding the following to a device tree:

	i2c-rcar {

	}

This creates a platform device with name=3Di2c-rcar which makes
platform_match() yield a match for your driver.

(The other alternative is a device with this name created by a platform
file (even if this is not an rcar machine) doesn't trigger that problem
here I think, because there is a platform_device_id with a matching
name).

See also=20

	http://article.gmane.org/gmane.linux.kernel/2083641

for a similar discussion.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
