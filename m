Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1A367282
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005350; cv=none; b=XaX5rt9PiLY/8XsNu67y782Own4Nf9wRHtFyrxmdFVb1fvTuBEYW5S16zvTrdYcqTMboqz+uBEjQ8NuBbaahaBvxzHHFdmVHfrdqecSi/E1YsuoHz79dvT1r7jKWxW40qbsl3ICP+ZBTydbb96iSspyA3GwgBcNvMw+o0BuTOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005350; c=relaxed/simple;
	bh=nMEv6pG00g5snJ0J30/zPBudOyGDJKXqQHYeoBAmKek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7sL76zQUjya1cMbz/WkrDFEXZvWgdL+6j5N1jQXoKGztlJQ/9jbh9ONEZVUmC2uGuLnOTWgFv29qzpQfb7uup22gA8Xib37Lnlpn+R3IAiSA8pEW4+1ooIzH4jvWsag3eMLyZTb0VupA6vBv8ux/HAUNOqxFtQPnPgc5QSO4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Yv4ZKHsQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Yv4ZKHsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nMEv
	6pG00g5snJ0J30/zPBudOyGDJKXqQHYeoBAmKek=; b=Yv4ZKHsQy55bN0CP1Din
	25oAikPAV5At92Zs8UiljoiUMHcuCF47iIpSILTBTxQopt30UVCNomPdinkiFA+Y
	/SldQvzETEHY+lONq+2hPROOnSAI7NStr+EE6wQCvs7UTw57VUYbvr+n8PCnwJr4
	oZR11yQ85joGrRSJrArK+qtf+VOG71Ggg+fOHaY/mhsRfhSCyMvFdsbMFht3O4Cr
	cx81bv7l59Dlz75aenpZOIPJP/V7jypaedTTTIVEx5lkitEbGbalATH4C3PN6BGw
	pHHWwkjG3+O4qiZ4Ai35nhgJDc25Tm8aM5mnl8xZWIkAFmduLTXtR3bk8ezKLGba
	jA==
Received: (qmail 1174536 invoked from network); 28 May 2026 23:55:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 May 2026 23:55:46 +0200
X-UD-Smtp-Session: l3s3148p1@SsxgyudS5JeSAB9x
Date: Thu, 28 May 2026 23:55:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] i2c: mux: reg: use device property accessors
Message-ID: <ahi54pXClIW7OENa@shikoro>
References: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>
 <ag1a5TLH7L-BSWWp@shikoro>
 <DIUN5NSLIH1U.1U1TFC7N4CJR@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Er/5OP8iqC/z+H6U"
Content-Disposition: inline
In-Reply-To: <DIUN5NSLIH1U.1U1TFC7N4CJR@nexthop.ai>


--Er/5OP8iqC/z+H6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I noticed this patch didn't make it into 7.1-rc5. Is it still under
> review? If not, will it make it during the next merge window?

It is not a bugfix, so its time to go upstream is the next mergewindow.


--Er/5OP8iqC/z+H6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoYueIACgkQFA3kzBSg
KbZp6BAAnT8xYUnsa9Hj/KlcD1UK6LctOzuwPJXk35meQl6y0p5s/rll5Fwl/Tyn
5Fjjf5W2HFgbBKsL2fZH/f3MNFcUInmYefSAQMvFjqvs/PqEZ99j5iw8YVkA8pjZ
NEfVh6YV5NshELW5hEsBdL0bcBkV+FvHbTJZaSEJaHFk2fG0rCw0Cf7Rk3/FwsBS
pjEn5lmuU87XkDGculwIUvFk0mJ41rRatKQzXIQFu3buFBHGQno8hG+5sCpWKI4U
JTy1wHJZxdc68/pr+JJkNOc6AE/EG+iBxYIWLunKc1XXfa/jMlgwHy6/WmH2WjaR
ymbpRuQrqgx1WQARp8zsbxBTBucEn/zVqt41nprZzQVm6Cqd0IV8wupP04bjzzQF
vZQKuSlK+rtoT5iWQetNKBpuHgKsL9zXdTeiAb9MqGtanndDkoHXO9bcJuo2MSAr
5tbp86mTOj8SuntMyg5RTuvUG5wxLWcxDplmB9k5s4kj9TtToadssdWU78ldViBS
7x2WBCwrVBJd/wrwXA14Fg7Q/v97kbqf/LxIszqBrWn9h6/z8xvfBKPxs5OBFjfh
6dBqevBH79uEhhgzuHHPzgNxXHI7SrnRjgL0fwgvZ/qkjTYEbKSoExrWDGbxqrb2
+53eNllapUdWSsirNoNorppWofb5m718PW6yxeCp/CKyZ8TgWyE=
=92xm
-----END PGP SIGNATURE-----

--Er/5OP8iqC/z+H6U--
