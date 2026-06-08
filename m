Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD042F617C
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910498; cv=none; b=bNpE1TsFANc7RtmRl3GZc4qdgQZmjiAHsdffBbyS/cTA0hvruRzOM7KFarCfEe9SwIZ1U0A02RNqLyrljJmdCKR6j3UsNxdbiVYbc1QpkpOKP4gfsTJ2WgC19KKFPFgYbKd4p8EBTCPpJgxgNVOGQ0uy7jgQYJmWDUbSR/OSBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910498; c=relaxed/simple;
	bh=9YDFsQR520QeFIPz7QfxUGsgsiD0l2L1tOc7Ej36S5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUZgWL7Nmu74/Gi6zBsyLFmz4TtysPVkmbBT5SpZC4mClGinqnsw+GKRhRjIqMjtMKK1Q57eWa3ArzW642njHcs6FRi79esQ9mLQMnSYVk4oeZUM1RxrgVxm1hYxhfyJWjgAWYsJduimqxmRUE5jU9YLndcI2jRg9Nc8PL0uTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bj+6i5ol; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bj+6i5ol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=eCWc
	fH0sBOGjhYYiyz7fPWJkc94ZAtEJVq3TTl4+PRo=; b=bj+6i5olXkw8jVs9LnMA
	VI1JFHmvSyHOmqO1e2dLa5So8uh0UIq49UcxH09v5B8SHt3Zgu6A/no4irhpt4M3
	R9XP98YoGojegJ2cmNGxak96+WSHdKX/K0oC7wYu1RRZ1G9M7sgthRw+rjU87wVq
	5z3U8/sLj2NVYiAHWACcdlrNbewZ4VcWZM2NXmhnb81snrdObXTdU/yCSEOizXQb
	8A48r+7JtgOQanJyxEAxiHi1BjkYVLe9vcjSs887LfHw94bTqWWBIQeYzUcuzIxd
	4Bwwu3yQeKOH2k4z6cvN5m4sLO6MoCQdsauPjTJkOyMKISMDwW9K2/NGLNOlKsA8
	wg==
Received: (qmail 782715 invoked from network); 8 Jun 2026 11:21:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2026 11:21:30 +0200
X-UD-Smtp-Session: l3s3148p1@phUmibpTspIujntX
Date: Mon, 8 Jun 2026 11:21:30 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 2/2] i2ctransfer: Add optional message
 modifier flags
Message-ID: <aiaJmtl-n-mNtsDt@shikoro>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260127-msg-flags-v3-2-e7539945db2b@bootlin.com>
 <ah_Y0bOyXRajpp8O@ninjato>
 <oyWrZgMUT2iRI0tfI5ARxw@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4oTec/zhXKvOcyA"
Content-Disposition: inline
In-Reply-To: <oyWrZgMUT2iRI0tfI5ARxw@bootlin.com>


--c4oTec/zhXKvOcyA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

> @@ -202,6 +202,20 @@ static int add_flag_if_supported(__u16 *flags, unsig=
ned long funcs, char arg)
>                         break;
>  #endif
> =20
> +               case '0':
> +               case '1':
> +               case '2':
> +               case '3':
> +               case '4':
> +               case '5':
> +               case '6':
> +               case '7':
> +               case '8':
> +               case '9':
> +               case '?':
> +               case '@':
> +                       return 0;
> +
>                 default:
>=20
>=20
> With this we get out of the flags parsing and the "Missing direction flag"
> error message is shown. What's your opinion on this?

Basically fine with me, but we need another adaption then because this
documentation is not precise anymore:

+ * 0 if the argument is a valid and supported optional flag

Doesn't fit anymore because for the above cases, the argument is not
valid.

I think we should return a dedicated value for this 'unexpected' case.

Which brings something again to the table I was close to suggesting last
time already but back then refrained from doing so. Now, it might be
good after all:

It is about not using magic numbers for the return values of that
function but an enum with descriptive entries. Example:

enum supported_flags_retval {
	FLAGS_GOT_RW,
	FLAGS_GOT_OPTIONAL,
	FLAGS_UNEXPECTED,
	FLAGS_UNKNOWN,
};

I think this will make life for future hackers quite easier. What do you
think?

Happy hacking,

   Wolfram


--c4oTec/zhXKvOcyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmomiZUACgkQFA3kzBSg
KbYjBg//fpoJ/T+oxFJdx99WbVmMZp0jVnzyTz0MBB11mQ+/gV+kT2w3Y8lIEkeH
20O/GpCq21sEZ1fKfE9EOCRy1yRXyNQH5QOWa8RGp5V4hWEwXAFxBfHb7w3hVRzs
NQH+U2LYAM0yvKMCWcIDIbEYa/sjlb5Au+MN9FX345/5ac0c4kpTNy1DFrObJeYE
UVQAsTE4ji2v80wkBcrkS6nhyem4mg4OG097Kuuj+tevWMjNZEHhf/LfoUI//TWb
ThV+4vGxQhAKd9jCKzOChOwMnFCNlXxuHfIr8XFnf0GUsiOJRNJ9kgvS3+nhvkXw
9p6b6OLWRYQMsKvfmMBjFXm0Plmr20VPBWqEovImpnG7yNIPkMgVzeJF5G1FpYX8
XBKGb04vmBryuO9yYRowKyB2ttwAoDxeqRxIR2WfP+FhwyJdwl7uT8xpHmrbGvVg
sVZZ0rqHP47xvjculUUB3aoxPJNRC1n3pu07U6oz1PM9K+E/jVSSRjLJlNk0hMRY
koIXQaf4/qQWy8NcdY4VvmXC4Q82J5SLEvrC9KYs8vaLhb/PE3NZm9oGoPmyuBgB
6FA3mi2VJYq0ZKDyI1pbyGQiphtrtMv5ww/nNjwrG3LCQMJodP4pZHsF1DsUuKe1
VYQyCzgHjpyQeQqcpP7M51lpP/8/VahwcZ8aXh2NXO3fW1nqvSc=
=BoLi
-----END PGP SIGNATURE-----

--c4oTec/zhXKvOcyA--
