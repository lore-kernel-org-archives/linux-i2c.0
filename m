From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Date: Fri, 21 Nov 2008 18:58:21 -0800
Message-ID: <200811211858.22159.david-b@pacbell.net>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200811201456.36551.david-b@pacbell.net> <Pine.LNX.4.64.0811211621340.18022@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0811211621340.18022-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 21 November 2008, Trent Piepho wrote:
> So yes, hardware keeps getting better. =A0But you can't say, "I have =
twice the
> RAM so I can make my software twice as bloated as come out even." Bec=
ause we
> also except to be able to do more with cheaper, lower power hardware.

Which wasn't my point at all; neither was even closely related:

> > The real counter-argument is that memory isn't *that* tight, especi=
ally
> > since the hardware capacity is growing.


If you're keen on saving a hundred bytes, you could probably get
it by removing some needless strings or moving code to init/exit
sections ... and in fact, get a lot more than that.  Without any
loss of functionality.
