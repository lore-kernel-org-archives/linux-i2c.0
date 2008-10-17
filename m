From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/7] of/gpio: implement of_dev_gpiochip_{add,remove} calls
Date: Fri, 17 Oct 2008 13:25:01 -0700
Message-ID: <200810171325.01729.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081016171303.GE5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756868AbYJQUcY@vger.kernel.org>
In-Reply-To: <20081016171303.GE5515@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, "Steven A. Falco" <sfalco@harris.com>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 16 October 2008, Anton Vorontsov wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (of_gc->chip)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return of_gc->chip;
> +=A0=A0=A0=A0=A0=A0=A0return &of_gc->gc;

presumably there's a reason not to

	of_gc->chip =3D &of_gc->gc;

when this gets set up, so this can always be a simple

	return of_gc->chip;

(and inlined)?  Needlessly complex...
