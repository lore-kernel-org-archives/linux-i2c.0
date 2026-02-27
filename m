Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81921FF4D
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151202; cv=none; b=Lt653gFlRBw4zIAXTHj1tpYRW4HTze1bfY9SYHSbhkeRnZHdhO810ayanZOTrxzxj5HCIAfjbfqKqp7a1R0hpa/SJx9Hrucagz8O7B4i53E+Hgvslot7eYMo41YpVJWgKzNoaa17pAQ8CfzUXXHDd+gb8WBSy3Vlys/1+XxCySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151202; c=relaxed/simple;
	bh=qUqDumqrEysKvvzn7b3yuEIJM9ThYwDQsBhBjQ8cCkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM7kzMRRdNoPYKxEW6KKPd+SL+MnbGEQx1J4klWUREmLT+1z/OBjsUwqFTXYmKSoFAbdrZt1xlV1BJlQ48O5LtwWuQqF5srpLI+xl2Bu0/Fq//5+xhptCViY/AJ4LGonEl7V7mj0Zk8XYV18lFuaBDdO6p2wWh3gXXjqXJrrFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owSkck6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owSkck6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D94C2BC9E
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151201;
	bh=qUqDumqrEysKvvzn7b3yuEIJM9ThYwDQsBhBjQ8cCkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=owSkck6dpqJc1aXzqgzAC9bOTKxCIMxK88+s/wgkjRMufbYFwdQ4ideevl1fNpBLB
	 fgjaUVIhZir2kJXjXcj/HZ+QmRD0JYNjEggwUZyAr8dLn3tCuIRZHxIeW6L1AOJxu1
	 9VOQWzM2QcbkhvkySVL1cWD1qzgUvxIjIFUvvu7aW9bLBuGTclVs/eslC1kb+zL20T
	 3b7wIzzerSoesoC7PnPqIbxsAX8Yyrm5wD5H+T99c0wJnJlTlwGlhBK/BN+SHdQud+
	 FaEYDjZA9qLIlTvH3S+/mlBzAiWTjvx4I2r/Qd7UZ+RezU2zmaerFurOnOa9Jf52Lx
	 TNp1GJUWG1Z5w==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7da9so17411957b3.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 16:13:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUo86l3iZRSgiJXvow6LUVlMyLtnghAbgE/MeGzAYc/FM+i3G7GzG4OE7gacXkKnTwhXYLWEpUZ9Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDvBGh3k+WfMY9iPlEg5fylfxfCvTHrZuriJ0XAqZX1bOfcjR
	DnDwaH1VC8G6zYyHntc3SLyvp7Mhm4wkWwcYnf+zenTrrOjxb0FpYhhLGV53Y17cbO6jwVwiV4G
	W/17+oHqbHItrmgVPEc3pPNbT0XyLhRA=
X-Received: by 2002:a05:690c:112:b0:798:5333:ce1c with SMTP id
 00721157ae682-798855090aemr11680817b3.23.1772151201232; Thu, 26 Feb 2026
 16:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
In-Reply-To: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 01:13:10 +0100
X-Gmail-Original-Message-ID: <CAD++jLky3BTqryNY4MkiLpLZKW-OZhG78tC8Gp67wXZ0WMpt6w@mail.gmail.com>
X-Gm-Features: AaiRm52Gm-BswzfmZ91rHxmFojNKjWg-xm2ljpTlm0-vUOMkdIUDq-NT6rw7rAo
Message-ID: <CAD++jLky3BTqryNY4MkiLpLZKW-OZhG78tC8Gp67wXZ0WMpt6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] i2c: pxa: fix I2C communication on Armada 3700
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Hanna Hawa <hhhawa@amazon.com>, Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 2:11=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:

> There is a long standing bug which causes I2C communication not to
> work on the Armada 3700 based boards. The first patch in the series
> fixes that regression. The second patch improves recovery to make it
> more robust which helps to avoid communication problems with certain
> SFP modules.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

OMG what a trainwreck this is, thanks a lot for digging into this and
fixing it Gabor!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
