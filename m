From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Thu, 24 Apr 2008 12:47:40 +0200
Message-ID: <20080424104740.GB4201@pengutronix.de>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
	<200804140857.33732.david-b@pacbell.net>
	<200804171417.23753.david-b@pacbell.net>
	<Pine.LNX.4.58.0804172346580.10592@shell2.speakeasy.net>
	<20080418103149.GA4245@pengutronix.de>
	<Pine.LNX.4.58.0804181555560.15372@shell4.speakeasy.net>
	<fuhm3r$sok$1@ger.gmane.org>
	<Pine.LNX.4.58.0804211005410.15697@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907284493812764064=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0804211005410.15697-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============7907284493812764064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2008 at 10:20:17AM -0700, Trent Piepho wrote:

> If it hasn't been long enough since the last write, the next write
> isn't suppose to work.  That's the expected operation of the device.
> But if it has been long enough, and the write still fails, then it
> seems to me that the behavior has changed from normal operation to an
> error.
I think you got a point there (unless someone gained experience that
retries do help for some quirky chips or other cases).

> > > Still, if you want to wait at least 25 ms, on a HZ=3D1000 system you
> > > might wait only 3 ms.
> > I'm sorry, I fail to see this. If there are more than three retries,
> > then there is still the time_before-condition which keeps the loop
> > running until the timeout is reached, no?
> Except for the timing problem I pointed out before.  The timeout is
> checked before the write takes place.  So if after the 3rd attempt the
> msleep(), or kernel preemption, etc., delays for 22 ms or more, the
> next write will never happen.
Got it now, I misunderstood you before. We do wait 25ms in total, it is
just that the last write-try happened at 3ms. This is indeed bad. The
following code should handle it better. (Skipping retries for now)

---
	timeout =3D jiffies + msecs_to_jiffies(write_timeout);
	do {
		keep_trying =3D time_before(jiffies, timeout);

		transfer();

		if (success)
			return count;

		msleep(1);
	} while (keep_trying);

	return -ETIMEDOUT;
---

Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIEGVMD27XaX1/VRsRAkwhAJ9lGoOwE1hdJbfYbeHCYMJ9HgKJwACeMhnx
hCzBgpaVdNFn/b2MC/Yz2Cs=
=N/+T
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


--===============7907284493812764064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7907284493812764064==--
