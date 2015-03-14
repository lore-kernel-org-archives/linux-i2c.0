From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming
Date: Sat, 14 Mar 2015 12:00:28 +0100
Message-ID: <20150314110028.GB970@katana>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
 <20150312094227.GA4225@katana>
 <20150312112917.GA4888@katana>
 <5501E52D.9060400@rafresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5501E52D.9060400-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> >Yes, one can't mix i2c_add_numbered_adapter and i2c_add_adapter well,
> >and this is even documented. However, since you are DT only, this
> >doesn't apply.
> >
> I have not seen any documentation to regarding this topic.

man i2c_add_numbered_adapter

...
 * If no devices have pre-been declared for this bus, then be sure to
 * register the adapter before any dynamically allocated ones. Otherwise
 * the required bus ID may not be available.
...

I was just referring to it to express that this is known behaviour and
not a bug like I first assumed.

> I remember adding an i2c multiplexer to an early beagleboard system years
> ago. I think we were lucky that the fixed i2c bus addresses were probed
> first, so they were not stolen by the multiplexer's dynamic allocations.

You "need" a deferred probe for this clash to happen.

> It would be useful also state that the i2c bus naming mechanism uses aliases
> to name i2c buses.

Care to send a patch? :)

And are you interested in testing the bugfix patches I sent around? I
tested them locally, but verification from the bug-reporter is always
good.

Thanks,

   Wolfram


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBBTMAAoJEBQN5MwUoCm2kLYQAKqIkykbsGjCPjiutRy12OqC
e/XyTiG11QGsXwvA///lB2lB0n8pDR35bypl6HXZA5I9kvjqov8OL37TnwI4zUTZ
VI9HMBsPcM3HdzwWPailT0V6ECU8S9T9ST+o7bWo7COpTRV+TtxGtYIDL6lh5xoc
fiWvE3KB3M5/7MKCsljHbmHm5A2zjg9DqBSthNXwJahIrIWJgEfJoQgSFIK9lmFN
HLMh5JH2l0Rnhs3eFAvj+RRc8KkafyMFg1Eoo5GqtcU/js355IsSeh35aEe+vXAv
Uhiw2hw+aawRKckJ7dCTkYsD689b/Ik3Uy6KVsXNm+ZzHsXexcRrwCpxQHhmhRw0
QhPXNFsHW6SqwMyChkdv2FAnKU6sQSMl0iJ4/OBmTcjWPmSv4sctD66ZgskKxv6S
8hZNcs4ao+AzoHWH44JyFrSNnKZ3jqcnXI5a6AhiLrmBtcuSraRqZLYBHDLWaWd1
wGGDxwaC2M5eefrd9Bk32ftqbR3XfyCXY+jhqdWnia3N/hTAsTFYpgKfwky6WlYn
tNOvDt0e7lI1Jwab7VKwvZ1r2+u/cqpo6TVmZiCcBdInEhstfMjepzEcwZGn4qtS
7sgC5uN1VPAQL99wK2I2lSPk+Yt4k2yEoWY8wVXcuwqC+m1Yl/k1ySCKj8o0lFIn
u/IzYc54MdrDX3IF7KHe
=cwS3
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
