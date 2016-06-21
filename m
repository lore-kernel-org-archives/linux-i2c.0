From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Tue, 21 Jun 2016 11:12:55 +0200
Message-ID: <20160621111255.1a27363e@endymion>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
	<1434710432-4182-2-git-send-email-wsa@the-dreams.de>
	<20160427173308.GN7946@pengutronix.de>
	<20160619195641.GD26875@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56711 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbcFUJM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Jun 2016 05:12:58 -0400
In-Reply-To: <20160619195641.GD26875@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hallo Uwe,

On Sun, 19 Jun 2016 21:56:41 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Note, I didn't check if this patch got applied in the meantime, my
> > excuse is that http://lm-sensors.org where AFAIK the i2c-tools repo=
 is
> > located isn't reachable for me.
>=20
> This still stands. Where is the upstream repository of i2c-tools?

lm-sensors.org is dead, I am in the process of creating an i2c-tools
repository at kernel.org. In the meantime you can use Guenter's git
tree as a reference:

https://github.com/groeck/i2c-tools

(This is what I will use as a base for the kernel.org repository.)

--=20
Jean Delvare
SUSE L3 Support
