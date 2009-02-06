From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during adapter removal.
Date: Thu, 5 Feb 2009 16:02:43 -0800
Message-ID: <200902051602.44036.david-b@pacbell.net>
References: <1233840973-13268-1-git-send-email-giometti@linux.it> <1233840973-13268-3-git-send-email-giometti@linux.it> <1233840973-13268-4-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233840973-13268-4-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 05 February 2009, Rodolfo Giometti wrote:
>=20
> When we are removing an adapter we decide to ignore any active client
> detaching faults for two reasons:
>=20
> 1) one (or more) active client may be switched off, so it cannot
> =A0 =A0replay to the "adapter removed" event.
>=20
> 2) it shouldn't happen, and even if it happens it may be due a bus
> =A0 =A0fault which can be resolved by resetting the adapter (most of =
them
> =A0 =A0can be resetted simply by rmmod and then insmod the module aga=
in).

This bothers me.  If the client can't detach, it can't;
there may be all kinds of chaos introduced by trying
to fake success in such cases.  Like resources that
suddenly just vanish, leaving breakage in their wake.

If this is a shutdown() path, where it's basically
just a polite driver notification, that's one thing.

But I2C gets used as a system control bus, so this
sort of "ignore the errors" stuff worries me a lot.

- Dave
