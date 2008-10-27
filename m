From: David Brownell <david-b@pacbell.net>
Subject: Re: [rtc-linux] [i2c] [PATCH] rtc-ds1307 : SMBus compatibility
Date: Mon, 27 Oct 2008 14:29:24 -0700
Message-ID: <200810271429.25490.david-b@pacbell.net>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59C2F@PRI-MBX-101.dom1.vinci-energies.net> <C1C62166118DFA4A8BBA01A2411F0D170E9BEC880E@PRI-MBX-101.dom1.vinci-energies.net> <20081021202938.2eca3ac1@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754480AbYJ0VkG@vger.kernel.org>
In-Reply-To: <20081021202938.2eca3ac1@i1501.lan.towertech.it>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, sbarre@sdelcc.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "i2c@lm-sensors.org" <i2c@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Rodolfo Giometti <giometti@enneenne.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 21 October 2008, Alessandro Zummo wrote:
> > I've tested it with ds1307 chip.
> > Is somebody can test it on ds1337/ds1338 ?
>=20
> =A0Given the amount of changes I need some Tested-bys
> =A0for the patch to go thru.

I tested these changes on my trusty ds1307 system using i2c-gpio
(vs a "real SMBus controller") and it works just fine.

Of the nine changed I/O calls, testing with the ds1307 covers
all but the three supporting the new alarm calls.  Given that
those alarm changes are "obvious", I actually don't have any
qualms signing off on these changes ... though it would of
course be good to have Rodolfo re-test his alarm code.  (It's
freshly merged in any case, so it merits testing just in case
a problem snuck in!)

- Dave
