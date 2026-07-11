Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EAF1552FD
	for <linux-i2c@vger.kernel.org>; Sat, 11 Jul 2026 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783797910; cv=none; b=bTx1WKgnTFnsALML1OWXzinxa511iMkof1aN7/orwaRiwyblsTndBcp2zsKyPc+vZrJO0EDuiXdPGzuWvVW79Ah0g24nH+8+ZWTvRoeN8B9FdXcuPPeGZ+tsNE5rG2NtDkppJIa8IgGg5jZlWYFkZOKGLcJ5vY72ezQPXwNQNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783797910; c=relaxed/simple;
	bh=qF0VYH0W1WPXY+BfVEYklbfPvyyTYL3yL+j7QJIDqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlDYGHHIi9U9vTCQr3ZNmeWLtdPbfeWfsh4ULjFlaQUQeEH8P1QgjZpDAjs2MYrEvyvYWQOtKIMy7WillA3aM/N2cJ3uP0J+ynYE7zpv50FsJ3K6q62lMz3gad9tkJ0XMVIRLN8Gi1JIaZ4a4PxdyH4q5WA2pw+4noYlhp6viBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Nvabj9Kq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Nvabj9Kq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rIUC
	BYSQUdnqC54Uw0/ykBnBl8IGxKhjOCZZCvmtOfE=; b=Nvabj9KqYeUqgoipjaYs
	gODCeGVJZXQaRgMYHWu+DQYeDtuCFCPbGP7ceSuhQdC7h2TB6vB+I0yasQGr7hZd
	0Zi+OJBrosDeX06ua1DT9pO8HrxpCRvffO0xq1QDaqTpAwCJYejP3Qad45RdKZgA
	LJcgSgvAX9vyE4dYvMegDmmdxIIig0KJ8OaUid/Q+xqv33K6DNRZm2pgOzN7Z/my
	jt+Fyt5155okNCtPEba9VBwWviIkSvpRjRpHUYtztwdNxEV8QI1UAGRFJFh8h4Od
	6aofQ4GaRXgFDjzUE1pGevYQbpPMuTpdz85YK/Vc35b9fFZcaI1Qznc9/8DyvsBF
	HA==
Received: (qmail 1978628 invoked from network); 11 Jul 2026 21:24:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jul 2026 21:24:55 +0200
X-UD-Smtp-Session: l3s3148p1@USXhz1pWdq0ujnsS
Date: Sat, 11 Jul 2026 21:24:52 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Cc: Brigham Campbell <me@brighamcampbell.com>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Message-ID: <alKYhB6PKffxI2vt@shikoro>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
 <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
 <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6HrGaM+A8ZAxEEy"
Content-Disposition: inline
In-Reply-To: <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>


--v6HrGaM+A8ZAxEEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> code it's not understandable what's happening. Instead I would propose
> to inline `lookup_i2c_bus()` and then have the logic inside
> `open_i2c_dev()` be imparative like:
>=20
> 1. try to convert input to i2cbus bus number, if it worked
>    `return open_i2c_dev_by_nr()` with the bus number, otherwise,
> 2. try `lookup_i2c_bus_by_name()`, if it worked we now have the bus
>    number, so we `return open_i2c_dev_by_nr()` with it, otherwise,
> 3. try to open as path.

I like this approach.

> > -	i2cbus =3D lookup_i2c_bus(argv[optind]);
> > -	if (i2cbus < 0) {
> > -		help();
> > -		exit(1);
> > -	}
> > =20
> >  	/* read address range if present */
> >  	if (argc =3D=3D optind + 3 && mode !=3D MODE_FUNC) {
> > @@ -321,7 +317,7 @@ int main(int argc, char *argv[])
> >  		exit(1);
> >  	}
> > =20
> > -	file =3D open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
> > +	file =3D open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), =
0);
> >  	if (file < 0) {
> >  		exit(1);
> >  	}
>=20
> Removing this will change the error path, so a call that would
> previously fail in lookup_i2c_bus() may now fail somewhere else,
> changing error code and message. Same for all other tools.

You mean that help() is not printed in some cases then? The error code
is 1 in all cases, or am I missing something?

> @Jean Is that acceptable or against the targeted stability requirements
> of i2c-tools?

I am also curious about Jean's opinion here. In my book it is okay. If
not, we could also release the new version as 5.0, I'd say. Would even
match adding the DDR5 support nicely ;)


--v6HrGaM+A8ZAxEEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpSmIAACgkQFA3kzBSg
KbaJLBAAqktHogWC3603tO1rWSga6PgczRWt6pkm+gVbrmfBrHiX5uCpzE2HlWDy
9o0KQqoVRSPMJY+BMk8K//n4dQlzykMUDiMAdPiCaP98Rl70a2t2qKbquisOryci
zRImPir9IhmUalFYv9a7hdk6h3lpkY5t8gGxbDavvZ8pnSdVignzOpyKCusn2+Yq
9T5q3uUnDQP6RMZ5BRdzqL+iYqI9oghiwZDsvNfetd9AiPDwV/Krt37HeTMnLfZ2
Wtl3/YdTysYBDXyMdSEhVzhF3BwgV+Bvvd/Hh42ydTeEswL4oS8ROwKGqADSMC3v
nTNejibFBuex8qITFmulUBK9iQk9t0TBWG/VS3t1XCWT94TwTbV2X04fwD68HXsL
dggY+XgPhX1N9/vVrceHJO/olE9CBgBJL4TUvzp4KjnxAxhR81gKIs9lExPU5TT4
LDPxk07zA1aHPYJ953Zz/AZxPKU28FCTFSJ6uWB/CvcDIF06zoQSIU/vmfPvZcQr
IsCIz5OO44gAWW+FxEth5AKdJVkPZ2qUJp68MxykG1uH2prTqRLoQ93nOMxvGtbs
F89BxCToLCLSppMYbCPeVQQBKtfREEewPzRbs+Le6qfJUenYEQo2v6QpoCe8fp+I
vUcq7LUyqL2Mncio1kGxDnPrcHDljGfJYJPQ7bzzAdYZuPK3KVY=
=1DUM
-----END PGP SIGNATURE-----

--v6HrGaM+A8ZAxEEy--
