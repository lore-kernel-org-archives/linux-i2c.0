From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: ignore active clients detaching during
	adapter removal.
Date: Fri, 6 Feb 2009 11:22:21 +0100
Message-ID: <20090206102220.GF28554@enneenne.com>
References: <1233840973-13268-1-git-send-email-giometti@linux.it> <1233840973-13268-3-git-send-email-giometti@linux.it> <1233840973-13268-4-git-send-email-giometti@linux.it> <200902051602.44036.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200902051602.44036.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 05, 2009 at 04:02:43PM -0800, David Brownell wrote:
> On Thursday 05 February 2009, Rodolfo Giometti wrote:
> >=20
> > When we are removing an adapter we decide to ignore any active clie=
nt
> > detaching faults for two reasons:
> >=20
> > 1) one (or more) active client may be switched off, so it cannot
> > =A0 =A0replay to the "adapter removed" event.
> >=20
> > 2) it shouldn't happen, and even if it happens it may be due a bus
> > =A0 =A0fault which can be resolved by resetting the adapter (most o=
f them
> > =A0 =A0can be resetted simply by rmmod and then insmod the module a=
gain).
>=20
> This bothers me.  If the client can't detach, it can't;
> there may be all kinds of chaos introduced by trying
> to fake success in such cases.  Like resources that
> suddenly just vanish, leaving breakage in their wake.
>=20
> If this is a shutdown() path, where it's basically
> just a polite driver notification, that's one thing.
>=20
> But I2C gets used as a system control bus, so this
> sort of "ignore the errors" stuff worries me a lot.

If so I suppose we should take in account the
adapter->client_unregister() return value also, which is currently
ignored in i2c_unregister_device() function...

However, since I2c is a bus it could be possible that a slave device
stops functioning (or the user decides to turn it off), so aborting
the adapter removal in these cases can be not right... moreover if the
adapter should be logically separated from the i2c clients I suppose
is better allowing the user to remove (and eventually replace) it and
then resolving i2c client's stale states into the relative driver.

I suppose this is the same behaviour of USB bus: we can remove an USB
host adapter independently from USB devices.

Ciao,

Rodolfo

--=20

gnu/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
