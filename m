Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8973415F3A
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806596; cv=none; b=nQeDDXnCufmdHThpeuobYt4xyPPHVZiiINXLW10vms9Fep9VnVU07IaGYBOLETM4CMLiaDxwYrgjZIHiU+espD7xwMG/IukABssK2Fg00c9V6t8iADH6h/j4sHmpo+350i/VQrsAZ/l8I86EHvvIuzia1SPmyeFfOK+RECX+dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806596; c=relaxed/simple;
	bh=3fzE7QX96TA6InJnpjFGsnjlRpj7E0/XiyaA3d4eAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptxm+7049NrzJDlsxJdcnjmKT5onPf8vJLnFT4hwB4qYqRuSN1OCJ2mg5dr06NSp/2FRe5ZRqvQLgwehopjGljrDt6wI6x9JnDpLfsht77uSOeV3SsEXxaaQGck29ZubHBtQOljSXBBErZlhTFO2YSGykexqURPWX0AcYjZ/He4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssi6C/vP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssi6C/vP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so819353a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784806593; x=1785411393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FAUuYkKzKbrrKb0ZtaRbfH0JfxAr3PFg0MM+Bw2KxlA=;
        b=ssi6C/vPxhBMGKa7sDyDjep67hVJ5Q1g4XNNqnaMd0ExPFLY1DREjop0Nvk1Vh/oA/
         rh6cSGDF6ecrin7+Quf2/t5thVvDV84dJxO2gNGJ0XFrBMPFvB4oc4xlc8esJcQItpen
         a4PQaHGfuB90TLP+RA9oG6PRr1mrtkLfhEtCX7ZE4uVoW8g6Du3NyMQPxSWW2MNplUPi
         cWmh7A8a+4Fj+ez6gBvzx0GjH2GjCaD9JFCDTTqdSKSp1jOC306RlLAWhQWctfZpsnwG
         srCBJ5VsJKrer4AdHomdO34qztyi5uuzM59cCr+6pCaY0C70MaoZQw4KCzc+r2APCTmp
         z28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784806593; x=1785411393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAUuYkKzKbrrKb0ZtaRbfH0JfxAr3PFg0MM+Bw2KxlA=;
        b=i/ZqO/a+QE1Fl6l6cE+X+BPw4qCk8+pfABPgGw6/oOdYie6xFwSUS5pxzx/7kkh9CD
         cKAvd5wC0wGW0mu1gPlsSoPvI6e8di3WsZUf9g9uJYcA0MCx4i8GMOawCO7gAHLjFS7Q
         2Supi/LwifFEm+ELBLI9BlvGxJse3lp6OK7z+sgVDmvF2swXtTJsYFmRU2hu18uWb/K5
         NUKDUpzjBBqIpI6HFkmcjwuFgm0QpSPP3Z7IQKkByMk+vfKfM+s6bRNYW0gIwZuGwQIj
         cFjwiNcHarfnali+uFg7n4QgeN9IQgc07Pk9nfXIla/xIN3pQNkHfIws/RxcHwdic58t
         MGfA==
X-Forwarded-Encrypted: i=1; AHgh+RrB3QOaWyk1wanL6qvdapU1faHXqlqnTwubS8Xm7PNl6GYzDi19RihGqz2B7qZGFGgoTN1ltklN3us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Yna4MmoBWJVjzkVo6MeQMqJRw6qHxrNjefR1JxqTzJCpHpsv
	iLbhvca5tYT8uUQH9ccCk03uuUf45/adVnD/GIDticllcznhke/ijAUV
X-Gm-Gg: AR+sD12oPVcYR2x2/XkJon9VlasWlYXPRU+cYnUQSSA9JY3eQDtgCYyZU8DyK4OyYXR
	tl8OURtkuToK0xsTEawjgZp1LWBaS77DqtLHg79/kJ5xmTsWMvEBOKobdWv+h+XNabMzR3vKjLt
	u/yMc/T8IcksvcM9oQG/MPPYvno+maVrgg/zSObFXSTfA9WgS8eNvaROT3JW5Owv8a39vc2Ru+I
	6AAILreIQ56tKtLj+cY3m93atQXsqTmZO1qal5TIyBOX2w6brwm5uJYa0PYmVjWPSL0T3Njrcnl
	9GKDJEz8pTNo+zmYCVHRsU/GMdk+xFbjuFC/1QKlckvEmlkE9MoK3KJtuIflh90AD+onEAQJ+JO
	rQvcpAjhdtGeBC4Tz8IQ5n4DjHj1TDCgk1hafcdB5N4WcogykAyrK3bHG1o7G431Qw3R9P7k7Uo
	dt5gaLBtXKd1ZE7t75ufIhnC8d2Rjkuj24T/PfpZI=
X-Received: by 2002:a05:6402:1ecc:b0:698:7418:57a9 with SMTP id 4fb4d7f45d1cf-69f748ae779mr1009923a12.17.1784806592716;
        Thu, 23 Jul 2026 04:36:32 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f350377b7sm1980490a12.27.2026.07.23.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:36:31 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:36:29 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 1/7] i2c: core: add callback to change bus frequency
Message-ID: <amH8vX-M6lAWajQ_@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-1-a5010d623a57@gmail.com>
 <19dbf4be-5f17-46b3-924d-eb24ae41fdd9@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OVfm+UyA/qXeCYnJ"
Content-Disposition: inline
In-Reply-To: <19dbf4be-5f17-46b3-924d-eb24ae41fdd9@lysator.liu.se>


--OVfm+UyA/qXeCYnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Thu, Jul 23, 2026 at 01:03:53PM +0200, Peter Rosin wrote:
> > + *
> > + * @set_clk_freq: Set clock frequency for the adapter. Returns the act=
ual set frequency.
> > + *      This function is optional.
> >    */
> >   struct i2c_adapter {
> >   	struct module *owner;
> > @@ -742,6 +745,8 @@ struct i2c_adapter {
> >   	struct rt_mutex mux_lock;
> >  =20
> >   	int timeout;			/* in jiffies */
> > +	u32 clock_Hz;			/* bus clock speed */
> > +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_Hz); /* Optio=
nal */
>=20
> To expand on the comment from v9 by Wolfram [1], I too think it
> would be good if this function pointer did not live directly in
> i2c_adapter but instead in some other struct so that the actual
> pointer could live in read-only memory. I.e. if i2c_algorithm
> does not fit for some reason, a new function pointer struct might
> be called for?

My objection to move it to i2c_algorithm, was mostly based on that the
algorithm should not be aware of the current clock frequency. When I
reread the comment from Wolfram (and you), I realize that we are only
talking about the function pointer, which is fine to put into the
i2c_algorithm struct.

Sorry for the misinterpretation, I will move the pointer to
i2c_algorithm and keep clock_Hz in i2c_adapter.


>=20
> Also, returning int instead of unsigned hints that the function
> might return a negative error code, but the new code in 3/7 does
> not handle errors. So, either change to unsigned int, or update
> the support code in 3/7 to handle errors. I think the latter is
> the better approach.

Agree, thanks.
>=20
> Cheers,
> Peter
>=20
> [1] https://lore.kernel.org/all/ahX44_rzaRlTLSLU@shikoro/
>=20
> >   	int retries;
> >   	struct device dev;		/* the adapter device */
> >   	unsigned long locked_flags;	/* owned by the I2C core */
> >=20
>=20


Best regards,
Marcus Folkesson

--OVfm+UyA/qXeCYnJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmph/LgACgkQiIBOb1ld
UjImNA//dFlLVBf+3iuSWVyzi5/TaqJrTyo993+vC/Iq8vZPYcabFRIM7vl7+adb
+df/fj8ph8NtPZAmGiaq+da6i6bKEdVowVEgrD/sactK6PRAcxFxeNMdHpKgsaY7
HnOAf8YEFcwjZ0QPoQimY5Idh/Qv0NTw8Pf7iPIvPfFxBuwVKT5XDB2ncoccxjMW
ezPMdzk3sBED7xPcys/Z6Qeh41EdP4ez2uRfWdDaPBBJ94kEY3LTuEDX0oCnIoCS
y7MBafA2mqwT1bAuZYKOAqBCzqgkx9oiGN9gWH7DWrPpj8l7sGO3BcsPzJ0JlFNo
VabrYsyPA84qPo3Z6ZAb9uRbnrIlVmr+3sfAmBJfJ//1uSRfY3RWqelps7XZrt6d
oO0NX19S1rXeChsLEcT+YfCGXE2a3Jdnsy53PDvCduUaVyUs/euPjMacICzOfbQm
Hbv5fUTEq+rej6BmwBpAcQxaap0liwf4qBF7vzgKJIxpsMa826qM83q7x4fbhUgn
Ph/2jvBQFX0v5vdME4J18smKjXQalggtU9dxREWJ/cQ42JYh7eG5iaTD8wr+7K4y
Ing9Tm5Y5kRBUAs3oRvgyAoPQkpxQagvaqJ7H0fzDNTF5djqX4F7h14uk+zB2XOm
qDrt7QPJNmHqdzSBAj5okLUlhMIp9mFuMiAPlCc920QS2yfBSms=
=nf2D
-----END PGP SIGNATURE-----

--OVfm+UyA/qXeCYnJ--
