Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180B298CB2
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812123; cv=none; b=b3G66OHmL6QbU3Unal9HrwumOXLj/bsXDDf4fxoGbEk0ScQml2CMckX3f8mr+F/H/Wb1lHX/O0W2HLOMb1OsxdLqqA4W8mFgis8Fqvib7BkV+hhdhJmh0+sQUY4r9cQiguLb1dE+xSj1zB/vZlaCmomVw/j1A1yTtrYZWzRfH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812123; c=relaxed/simple;
	bh=wnqWEtnpelR8+OUCiqlImK5vhv5hkXxU66b+sjHg1ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoxmcKu99fkcSgSSgTjrMFsXWRzPkZJ/YVka45Cb103GqhoLlxpUFM1nSdPbo8HZUYdHQ8I7h0uBPzJPPxa5c8e5m9lYMXKzuCjSQBVyurhfa8sLtv+LPdyyE6YEvfkgEWVDsC7Wknx1m0tb8+qgEcgrzALQep3AXM3RRza3Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCqOCmnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCqOCmnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F121D1F00A3F
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781812122;
	bh=wnqWEtnpelR8+OUCiqlImK5vhv5hkXxU66b+sjHg1ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MCqOCmnxjnO0+Fzim01JPQMuriRmk5n9oEDc12/wQpTNUX7fsxDCq7hbxq8OhI8h5
	 vAuwiRN9MiQFqjz78OhlCE7f6IbJDvB1jodh54W/8A6W2UzhVQQkoDBp4jf7KrD6oy
	 fXeahOe3TlAihTOapWkSoppfLWLZu1sSWbR/rxBCkOUPxR9sOb1jPVdH0X/oaiRFds
	 3Dta/3ShnNp4IwCJNCI+1zI0ACWq4gjLvF9ZJ2Pzt44GWuHX3JCK2PoKDWwQ+Z30nI
	 rxAkAp9uikmXXCZ4PceGrtEzRsr1tNsZpSiqIj6OV9/7a3rz6zLvm/n1u0yEIvq6De
	 ojxaNMwYuqToA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad4b60f6d5so1317825e87.2
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 12:48:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ92pPb/TqH+7iT3Rb1uaa0CuDzwPFQ//GYSh3J4BK/erHvF8krRJ8sUHULMgrVxoaw8PIN9fpfek+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvulyBcsF1xCAK4jEJ5C11eRZvWcrQQt2XUY+6AUtCyztno8L
	n7iHO+fo0ozaxfQwdQbEeZQmrEYrJumwKGsZkZQdJNeNC/BYvmdNyfEQt/hE3UrKfAzSsNVY76f
	4ExtleLnHRNVqkYtqYR3YqeAKnFj8/CM=
X-Received: by 2002:a05:6512:6711:b0:5ad:5456:8eff with SMTP id
 2adb3069b0e04-5ad577242acmr74407e87.50.1781812120760; Thu, 18 Jun 2026
 12:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618141730.3243303-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260618141730.3243303-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 21:48:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqEaDpy-MF43vtOqYfyPfTJEe3CJVAvzm5bq3qy07mJA@mail.gmail.com>
X-Gm-Features: AVVi8Cd1EKp1-PSBupcREVemgEFtD3ARXicbWsv63Ro17PrpLnsggB_Vnf3WG3c
Message-ID: <CAD++jLmqEaDpy-MF43vtOqYfyPfTJEe3CJVAvzm5bq3qy07mJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] i2c: nomadik: Use generic definitions for bus frequencies
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:17=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since we have generic definitions for bus frequencies, let's use them.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oh, neat.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
