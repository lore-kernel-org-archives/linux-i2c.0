From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Thu, 1 Oct 2015 22:50:35 +0200
Message-ID: <20151001205035.GB7514@katana>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <55FAE058.7080504@osg.samsung.com>
 <20150920041528.GA3039@x1>
 <5603A881.2010300@osg.samsung.com>
 <20150924165807.GA27197@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47319 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbbJAUul (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 1 Oct 2015 16:50:41 -0400
Content-Disposition: inline
In-Reply-To: <20150924165807.GA27197@x1>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Kieran Bingham <kieranbingham@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yes but that is not true for drivers that support both OF and legacy bo=
ard
> > files. For those drivers, there will be a lot of boiler plate code dupl=
icated
> > that would look something like:
> >=20
> >      unsigned long data;
> >      struct of_device_id *match;
> >      struct i2c_devicd_id *id;
> >=20
> >      if (i2c->dev.of_node) {
> >             match =3D i2c_of_match_device(of_match_table, i2c);
> > 	    if (!match)
> > 	           return -EINVAL;
> >=20
> >             data =3D (unsigned long)match->data;
> >      } else {
> >             id =3D i2c_match_id(id_table, i2c);
> > 	    if (!id)
> > 	           return -EINVAL;
> >=20
> >             data =3D id->driver_data;
> >      }

I said this before: It is not only the additional code, I think it is
quite unelegant to to do the matching again which has already been done.
(and DT boottime has already increased, partly due to the excessive
string matching). Also, I wouldn't like to see an I2C specific solution;
this problem exists for other subsystems, too.

> I'm fine with a new API for this stuff.  I'm even happy to go ahead
> and code it up, but it's important to note that this is work which
> should be based on this set and not a blocker for this set to be
> accepted.

Is that a promise? :)

> The correct approach is the former.  One of the aims of this set was
> to bring the I2C .probe() call-back more into line with the majority
> of the other .probe() calls in the kernel i.e. with only a single
> parameter.  I'm really not a fan of passing some random void pointer

Yes, I like this about this series.

> in.  Using a look-up call to fetch ACPI/OF/I2C/etc data is the current
> norm and is a very viable option.

It is the status quo, but that doesn't make it better IMO.

> Wolfram, please (finally :D) take this set.

I tend to give in ;) Maybe we can talk in Dublin a bit about a possible
next step after this series?

Thanks,

   Wolfram


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDZybAAoJEBQN5MwUoCm2C8AQAIKeipX+VkuSEhLuKtWqkg9n
+cDMoRACJgCdJ1I5PSGw73JkEcgYbbQskheNhQ0x17sLErWQYW4XzL2dB5KQDtCb
L018MxYPPJa/kaE220yh58KNb8PhOjp7G760ywIPXTzfErSMj5+dhDp6u0/wBNf1
5IxtDrukgyy4ZYPn+kbuutwrNeflEbBwQfFi0i1hB6DC+tuqlKNv/+k6hpj/0Xv7
XeK8rDc6EHlN+EPok90kwhEJtEF4og+3Vvl4dcMr6JDLLFs4ZktsOltlRAKfOkCE
KnjUREF7kfp4wPmuakhQGU+M6RdAMTK0ps5Wd4TXaPldvab8X3cOCB1Yw1bHj7aG
DbhfhYBUsb62sLHoh8N+Zym9KbToPs/FEy97SrzfZmoUxkY7zejCbhji72KWs/en
1OqTSzKMacxkpsR3LhQiMXNUtxNHRjVLaK6iZ64DIa8kalKvJca84JGELzankDi8
BIyYM0UOzPhXrw4qsWiA/25cNs5FiU3X3cOg/IthKg1GpZXMQpPk0BCh3t9q1J/n
D7OoelCdDgf0nvZAuGcRHOrpI11dko6ywsOXDYRWUL2Qd9ZlTHvVfKt/48i9bMQ3
Wed9wVHXkXgM8hnKqsAOdgk/UoiHEkvNobu7H0QlQrQR+vZpVDw4KrquDyrAgata
41jKkUdo7TBvzfs7yZEI
=nwTO
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
