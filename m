Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F6274B23
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123050; cv=none; b=p7p8s7OLImEKWFP57/BI3/kyhVLaHFyLRvb9NLC7xJLmqGIYjhf2oBC1pzSMUXlY+VDjSGZ94mk2D0WLsLDNkDHn0lnQqVHzO0wsXue9rEvyy4vEs3aHtR3hvgm9QsE9e+iCdOVed0N2+6l1ParhC8TXQPLkZO6nvBUbt25iio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123050; c=relaxed/simple;
	bh=AzOm+bkHhyQPk02adzIhjelKMMqMHVcoJe1/OvYvJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM8nubwri3LdwV1ST/SCjJdgTiQFpx6IaP7EGC48JtYdWIZgPDSf16WRvDPMMIP93Z474Ou6hx2/jO/TrrSZwKwZnMgvr3ws8CBpnpscl1uhpWJF+x2gaOiA51oVxT4vuKJU+er/KEFATbz08oJJDyX8f3GMharOCuKMzKqlm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=o0s7Qucb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="o0s7Qucb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488d2079582so24213175e9.2
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779123047; x=1779727847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzOm+bkHhyQPk02adzIhjelKMMqMHVcoJe1/OvYvJgc=;
        b=o0s7Qucb/qw+AyOe1LvsV6z1hU2+imsHMg7xpzDx1K/Uc5/y8LDWaD0AqoLr72vuFS
         fXNm7TaQwkM4C85M9V/c//gxlnk+TKj25yRfooaLdHDJnsocxXjhNIkj/88+hh6ZtTt2
         2x0m7Ovzm2Ft7oXlnfReYuleKSO9ZZ3e/RwJsZGnDSvnrDHLW8y+C9iGHiNNKje/zkeU
         jTTInuYmpU0HEavduXaFT3wO8EgdgVNGqULTUgAhbHXVTAWUNMOTRpe45w9yaJnzboSF
         +oVbXwtt9nnstkz/t8SAwKfAdkMP5tj/n7gVHeAAQfjKbYPSooNku2+XuFNQbCrTVvWe
         4q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123047; x=1779727847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzOm+bkHhyQPk02adzIhjelKMMqMHVcoJe1/OvYvJgc=;
        b=Rs5WGBycbZ6RbmVHSDhMfGdbxQO4ub62K7JbBiJ8MRBgKkfL+Eckl5fl534y5fojRF
         CAc2rpdg2a+JEN+kPJvtQNpHnwM9Yw78G3PZXhVgg5ewSRanjEawbVOf6sUdEyINlbgB
         EuZQdLt5XBGTQWnYSdHeB/w8WBdBqY39f3aiv2zntvHb/g4fuJRxZ/G2BHQrOeHHuBrI
         Mu1ocu8SNkNUOH7ULF04GGy8P50mN7B3KiItOcfOqDAsNpUNx0qAMSqiBcvPbW9SljJg
         Ww/qhAUc3gpYqvxA9lHUsG1fwxVnb+8T2OhhzXzD3A/MOgnJhUrRoeWCjZJstwEpLvJG
         YY4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KmFWkZh0y/RbK/AX18p5bjEzacgveszE5DbPImNgILIl45+6W3AcG3GGUYyYd5hdgbzDhkdjqdKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiWHmWnlcpj2nNKf0tYdx2XZTn4nxh83QmhcUYgF/3T9Nv1yD
	SDZVffkHIuw3oer4y7P+QGM7Ur1GwQAtPktnuJu9tRS2tCTvUmoOKigC4D6CHHwTI/SPF+estbn
	9vWRSQOE=
X-Gm-Gg: Acq92OGqLT4MxwmaYFUYg/F/DzmNQ/oMpuNr3qWZ+MtQf63fYdq/ERG12JPUkUzcre6
	bDS7rsdrtr0wnDafmJTNDDPflU0VH0ezeTThDtCMVAC+WZqmp/WgFagP3EydQlq1S3Q41TDxVdR
	u9zs09TbvcKN6ygWrf4YNZYOz5a2zgMCFNAWelkTOZwRJMrA0L3FdLGE8Aqrv3LoSCxKS61xrgI
	VzCxaO2uTx37YXe7iGsPNEOMtCah95V5BEg0ArjxsfSOKHkQlhPElUmYTDmgjV8I+/TtzmP18IN
	Lb+T5wRhiMFu1hweRYbpt8/ZR0tMs3w7OtgDdg2On4kTalQTOysQhsJDvnhCNbtSWr2ZwT87+it
	fivTCBwXMLqWhmuNnA6kkHcr7Q2pVSHzwWmB1tkRi8K2HO5N5qoBIE9GAOqOpxPgLBBk4JtC0zV
	bP5ret8cMz+NFgj1CAhzhIg1++qXQn4yCvUGBmRIm5WtUNU7IWtJmJygaB4l5oGG+H88rHjxISc
	UlBgKC2BzuETQ==
X-Received: by 2002:a05:600c:4692:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-48fe6325792mr249903455e9.16.1779123047351;
        Mon, 18 May 2026 09:50:47 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm311890815e9.15.2026.05.18.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:50:46 -0700 (PDT)
Date: Mon, 18 May 2026 18:50:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Rosin <peda@axentia.se>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: Use named initializers for arrays of
 i2c_device_data
Message-ID: <agtCwcJLH_qRCp4E@monoceros>
References: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bq2nnxkiyl2k3ucn"
Content-Disposition: inline
In-Reply-To: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>


--bq2nnxkiyl2k3ucn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] i2c: Use named initializers for arrays of
 i2c_device_data
MIME-Version: 1.0

On Mon, May 18, 2026 at 06:45:09PM +0200, Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub) wrote:
> Forwarded: id:20260518134035.644762-2-u.kleine-koenig@baylibre.com

That line wasn't supposed to be part of the commit log. (I use these to
keep track of submitted patches, but this is from the similar tpm patch
that I used as a template for this one =F0=9F=A4=A6.)

So if you apply this patch, please drop this line.

Thanks
Uwe

--bq2nnxkiyl2k3ucn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoLQ2IACgkQj4D7WH0S
/k5tBggAijwlC5JFKVwzsOnYX3pL9KO4s4XyTj7B827dOMloF2jgTgPzo8n6TL5U
dsPzqLReoRJfi7sQz8xqsE64R/xTEaabWwfAtf+FqugP5gM20H/9TY9lOViyJ32S
gEMRb5cr0pKD+CGfvkP04BWRhhN6SS9h4lgZMRbjzYRk4mHz7NMQY3/x6+Wax9Dn
WeFcOjb364OWElniYsGq33+XLjz/seZZZNIYVRvosmDMchV/gxALEd/pvE+aLzph
4V+3liOmOt6/U6q7eKso7Rny8zcmZKN8eUjdJ1qL0oWUcoEf8Y5GTZzywKvegOhF
VYkjXJ/hefQkBdO8Xogg/AwYRlizVA==
=dQTD
-----END PGP SIGNATURE-----

--bq2nnxkiyl2k3ucn--
