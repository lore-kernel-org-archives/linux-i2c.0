Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25673AFB13
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094801; cv=none; b=PHv4lOV+9A5LKAdqCCktFYqTAtew2QOSYGZiDvTQl94DhJXLnXBWDKy9gTw3itSPEoSoR2nvETTfez9y9+1/Z/vpAGUjWp2VKl5O6n6jG4jkDnGNC2iMX4hVjvn1ra6WFWH3CpPuBNaY3O0USxGYo+KcvvmrUlKKhNKl+PHDTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094801; c=relaxed/simple;
	bh=w0njhfEjoMYqoCwBwryOtbyU7PzRminXNi+wp07AxVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHzhDr93lGQbJ0vKXrSxNsLNRQfd+Dn7FpI6hveqoVUznkLPZhkeGRaNj/UmIgOg46oRlzTVMZp8E8aTw7zdZmPGPgPeODY/8P8cQFCzQ64yqTpJpv52GN4krHzqFhCForZ6CUfeuI80B61GTUmQYICSYplApMk6Y1RJgtEOVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L2PA5IfK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L2PA5IfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=w0nj
	hfEjoMYqoCwBwryOtbyU7PzRminXNi+wp07AxVA=; b=L2PA5IfKz29NUFg4BWSt
	/Z+M+o2+Fed7pOwYyW2xSFo8m86VhuwfVQfF8XHG2Yard38OCvPV/Mz7AL3TGmga
	kQKsNlH9cQb7q/EBma1D5ecI0d/b2fiTKePJDc2pcV4CJBwl349hsdc4zQ5vVkg5
	SnGSZV/q7zzgHnNte0+OVd6XLiT6pgR08G+JrLg0W5o3A5PRiInCxGtqQjz8hz1s
	89uewSk8ZaqEXNyNymBeq+WQKzrQW6obbSBAbSG/JrvK0iwzSgUoCmx8/u4OKgBi
	SzfRN8uE6uz1POggPbJzk3aS0HE0QjT449aYGIsGDCn4qGSlfa80c2XALD7YfGCR
	OQ==
Received: (qmail 1559671 invoked from network); 30 May 2026 00:46:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 00:46:35 +0200
X-UD-Smtp-Session: l3s3148p1@v0LknfxS9j5dnheM
Date: Sat, 30 May 2026 00:46:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	wsa@kernel.org, andriy.shevchenko@intel.com,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <ahoXSoaiZQbP74sm@shikoro>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com>
 <ahml-rVa2PIA5DDC@shikoro>
 <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>
 <ahn9Q-9eHjBSj39h@shikoro>
 <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RFwvvb11s9t6IQlo"
Content-Disposition: inline
In-Reply-To: <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>


--RFwvvb11s9t6IQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> OK then, you're right. Let's keep it together.

Thanks!


--RFwvvb11s9t6IQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoaF0QACgkQFA3kzBSg
KbZlAA//RFMaOLJ1fLTfaJ4QolLu0kfJefFQOguvSRrjs4gyD+F5HHSMw8QjJwwZ
3N+MCbbwDWggs7a6qTXw/7qXRIqp1QHz1BOwUwtSuRqP6TvyCPWpZHt+X98t8Qy2
oIAbnEC5Upw2GDfvp13vs3sykqvVJghij1RbEJeH0IAe1vy5Jc4i+bpYcqJ3TSAA
wtrDBh5NKpUxYLIPHfz08gZEEm+DCMTtBhZnwSBYDkPhaJcSWk3fz30Ea53fdSOx
Pq5qGOqd31EOvVs6tKGwcjhyery+KIGuHrMr1A8yhrx4cj/NpAfa42SIQzacNsER
cSio7YqLYeaPuUw++VbEJvwhF9xzjEVdjX07xWrKeOVbD4JmnAseYq3+huzjI4vt
Fm0052qr9N0lNVNHeVJPeXONflqFJutUscuyTVgJI2uYdSkKvwbUajUGDoSw1DXE
01lqwO+CklrZtc01Pj2KJmUngMYkikpI2+U3+1XpJcWsGm5WJXyyV4rHJeXHtdqP
SMXx0RCslvf+ubAes+22mkDxH7VRcvD+eCFKx7jwinlUd1/EX/AERPssYsQQjVjs
aJ5ELKZkFdv5ty51ddUNRFv4HrPUeTddMoDCyPyFnhvHYxd1+s0UANZh077VEcCx
ye9usEdTvCDdkN187iDA2+qseCF7afwOtGQYQZRjDAEuWs0zNxU=
=KhET
-----END PGP SIGNATURE-----

--RFwvvb11s9t6IQlo--
