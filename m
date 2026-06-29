Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A663FC5C2
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727770; cv=none; b=fwHwWAlXIsbLkU+DsoMmXBmGqy0SE/glpFd+Izd6zsrEFIOGO0Yoz6SRS6bexB2zJYT5kZHqM3o8OsAc2I6ykXM4VuXAKvOGxdfHzVvCb2be2LzlQfNxOWsEGzBtF34u9NASu7KkvbKiOnymi0lF83ThI0nDAbUswSepuDguNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727770; c=relaxed/simple;
	bh=uYSr1BU//gpPhugxNcyMgSmlbk/L8OB5W4/PI4V5ods=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ4koDctHOCTKLccU52xz9sKAfJj23SPBfUz99wnQkT5WOW10JCj+CG4FEvtc9u6Mj4owejhfs/djYhgHTspXIgxxEFq7+Us/WDDYBvTJWyx9fUQizzBYQD3ueVdRYNOlQ2oSzj2wZ2pozg8IyTMeYkraiqixt5C+MTkULKix/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ac//3rO7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ac//3rO7"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so759716f8f.0
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782727762; x=1783332562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYSr1BU//gpPhugxNcyMgSmlbk/L8OB5W4/PI4V5ods=;
        b=ac//3rO71g75WD4ncJCXkvIYoSMvKsfTKUg9HKlA0eJ+d3xcdXMuQ1ZuESJSgdihI2
         8ppSUe8hMbtP8IqlZ64tpsGJ+Lh7CGAa9Hmptue6BkHYPOEQeRMYrZshOzku3t8sbKQE
         Ht2/AYNlaUtKHHuDr963oElZHa47OldleiR4nxszn/Pkgv8eMltNHkrtiaJesT5GnmGN
         67mH936LyfdBNN9cZgM7g9XeUogoJ2JBWug1QDMuqDavPdTy1hSDvvpAXjziQlJI/FXp
         pBZ/J3rYwzToGbR6rYFe7p6aKjQix/yRGbfQQ/eA19ntp74q3Bptyg8g91NOQl9UuMuE
         tCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727762; x=1783332562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYSr1BU//gpPhugxNcyMgSmlbk/L8OB5W4/PI4V5ods=;
        b=spZiuyiYtaLdFvdcyJdZA8Tykq6IPtVzmTcdcrUZLglNxxEpQh96TbgrSeaXQMvLoN
         K8rewOir2Ey+Y14vdzGACiVlpvZeaICJNE7+l1TFw3cOaYV9dL/PrCDftJy9vmZMyEC7
         /aHaTfr0SFXO2621bQ2Floa0rY6tHqI5W/P5mG51cvF/TOURd/tgLAcsGwt+NOpzEib7
         680PUjbMyYR4vVL95rTrpc5QdA/HMsqhDtUhFOEtchccpXPxfLUUX/uw3oQd8TgWl418
         7CXVtgkZQS/yoFB9Pi3yDrVFWnlsrfR+PFbRXaN3X8sBKwRS8lz4LEkQeGpaHQHBIuny
         VNBA==
X-Forwarded-Encrypted: i=1; AHgh+RoDDjvgXn3EMxGLMb1Ls7g5L/z7qiY76hOIUZjG+2mBipceVSMrpdsbnlXEeW+Q50i7kCBE3GMiS7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOKB2hYVH+3g/OqXS4sYKs7/WRu/8BQIFNguJwG0BSpFMJ5Rl
	47kwDmKeqwsjZZ7m7twKX6Y4OAOBhbBCO6ruvf0dbpLNM8qlmT3GvS13g486GM3yHX8=
X-Gm-Gg: AfdE7ckyazrwwieA7K8oQTihRQ5CWZ+UCjLY3vuqEEJB5RezHknUP2al0f/mZqcpfGw
	YuIAeMp2KaLPZcEVZVkAU5nUKgqm/D2gAfG5zPgXq4hcJyBIg7dRXYw4OQeSljhhz1BiCN/g2wt
	PGtm3vadZgKf1LFSUlRlEfTi3u/XSwSOlteuKLJHhiJjBPMjWRwBbmWY7o/yZ/oJzS8SK3clpoD
	EObcjnMeZJHVXbTyMULNrAvZ5WbxmZpFK3bnTj3/hDV9hHgU8DHxUvav8orC/IuwRT8KvnWniT5
	Ho+agfqTjlGIdvGDGu7TIPo+WlJnU8beNtnIXtoJvR7qZLMT1+Yg8O7YqxsactZRWrmE8DorzUx
	iF0407wh59Uu7wiP0eETbf4Kx0nBBGGd/LgXKAHIlPatoX1pF9HAOJ/fA4hHFoM3nm2E3O8PqcU
	oKZSXqOH6eevOA/16n7te2/FTQ9q3vJDjLchwpCiy814wk3YA0NdMD+Lr7cdjr5YjSKdhaWQ47a
	5AP
X-Received: by 2002:a05:6000:2c10:b0:465:81cb:bb20 with SMTP id ffacd0b85a97d-46dbef257e0mr28013623f8f.9.1782727762410;
        Mon, 29 Jun 2026 03:09:22 -0700 (PDT)
Received: from localhost (p200300f65f47db047d55c3c4f7db55be.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d55:c3c4:f7db:55be])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47290ed4377sm14518188f8f.37.2026.06.29.03.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:09:21 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:09:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 08/16] i2c: Let i2c-core.h include <linux/i2c.h>
Message-ID: <akJCr-OtGhoaR0vI@monoceros>
References: <cover.1782682124.git.ukleinek@kernel.org>
 <c176fb7e8503d61e08f055a5bb1ba4989aba6ffc.1782682124.git.ukleinek@kernel.org>
 <akIRVj94lmCasfEF@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w4l5u2i6dti73jue"
Content-Disposition: inline
In-Reply-To: <akIRVj94lmCasfEF@ninjato>


--w4l5u2i6dti73jue
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/16] i2c: Let i2c-core.h include <linux/i2c.h>
MIME-Version: 1.0

Hallo Wolfram,

On Mon, Jun 29, 2026 at 08:31:50AM +0200, Wolfram Sang wrote:
> On Sun, Jun 28, 2026 at 11:58:43PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > The subsystem private header i2c-core.h uses several symbols defined in
> > <linux/i2c.h>, e.g. struct i2c_board_info and i2c_lock_bus()). This
> > doesn't pose a problem in practise because all files including
> > "i2c-core.h" also include <linux/i2c.h>.
> >=20
> > To make this more robust add an include statement for <linux/i2c.h>
> > making the header self-contained.
> >=20
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This shall go upstream with the rest of the series, right?

Yes, that's the plan. Linus didn't explicitly say he's happy with
merging this for -rc2, but he also didn't contradict, so I assume that
is what will happen.

For bisectability it isn't needed to let these go all together, but
given that the first patch touches <linux/mod_devicetable.h> which is an
intrusive change resulting in the need to rebuild nearly the complete
tree when pulled in, do the intrusive follow up changes in the same go
to only trigger the needed rebuild once.

Best regards
Uwe

--w4l5u2i6dti73jue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpCRE4ACgkQj4D7WH0S
/k5mVwgAhuZatKIkOXzNx8JsrElGpFXUTn60Vb+Q1XVSWDy3/ldJ4twE94ZdgbPU
CuBHOhnF5wXgQiPjnhhHir34uZkF3ajSRDcjYS8FItNu5O6sEIwiQVXeBzOVSbtt
7IV/oIfIybPJST/nXK7IapiWh/GxNND28tKrNfPKAht3Fp85Rlhg8KWJSpjSAjIJ
OzcCXksDfaDZl0zjN6UqWt9uybSuiEIOONOXfnrlIR8CUIheSgpqSd1M3Xl+3PYO
flGskHGq890DDwFyKnt3uKOQSvRqw9om5wNcO5JhyYLU+sDAd+u+YLubtKdNuvZP
qfPD1WngIB62tkx7zGB75b6wQXw5Wg==
=4wk+
-----END PGP SIGNATURE-----

--w4l5u2i6dti73jue--
