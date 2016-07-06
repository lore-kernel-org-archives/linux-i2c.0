From: Stefan Christ <s.christ-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast
Date: Wed, 6 Jul 2016 10:42:44 +0200
Message-ID: <20160706084244.GA7031@lws-christ>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <1467724943-13416-2-git-send-email-s.christ@phytec.de>
 <577BD34F.7000804@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <577BD34F.7000804-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Tue, Jul 05, 2016 at 08:33:35AM -0700, Guenter Roeck wrote:
> On 07/05/2016 06:22 AM, Stefan Christ wrote:
> >Triggering the watchdog faster than T_WDMIN=3D256ms leads to resets =
of the
> >da9063 chip. The datasheet says that the watchdog must only be trigg=
ered
> >in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in th=
e
> >driver.
> >
> >This problem was already mentioned in the patch:
> >
> >     http://comments.gmane.org/gmane.linux.watchdog/1708
> >
> >You also could say that this behavior is a feature. When the userspa=
ce
> >goes wild, triggering the watchdog to fast, the system is reseted. B=
ut
> >there is currently no information in the watchdog ABI to report a
> >minimum wait time between two watchdog heartbeats.
> >
>=20
> There isn't ? What is the problem with min_hw_heartbeat_ms which was
> introduced exactly for that purpose ?
>=20

Ah your right. Sorry, I didn't noticed it. I'm sending a v2 patch for i=
t.
Thanks.

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Christ

> Thanks,
> Guenter
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
