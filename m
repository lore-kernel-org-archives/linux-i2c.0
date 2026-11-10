Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292990;
	b=C5/sBMJkjcT8Ebmk7gVSLghxwasmwYK8VgiztMPOKS8aOLpt9CsxrOo/0jDTL61CZOZv
	 luFkG3pLW4LHH54X2folWkSx3xxswtn3a3HYlRJAf5z6eSFkDslcDP4e7Fl8kZc78g6ep
	 a0YDBwdQgeajcMzCZ8LOBxMR5F3Fd1EdSwDMfTA7o+Bp2wZ50lhTsHXk3nAP3mFqpH1Gp
	 +S2WMZNzvNsLJd66urYxIEwAnpW2Hh1tKakibTCNK3tppCr0e8XjyLWfE4UPfXXpwOQRD
	 KpJOjkZkqJpdWb93DOPZ+C7zUDjXXd2QywcW+oSYbNiGPlhbE14j/oeDQU9i1S9hvbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292990;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=KDDnULezz0lYOy8E8UC/jFsEQulCu5gvg3BMNhfnq08=;
	b=Z+7w0LMhe7/8LVuNYmcYfh4GMN9ztZAD7qPKytmgL80MJxFKtZKxCsvvrBbzf4yqjFFi
	 GJAOh5pAJqIwWyxDNUmlABh4qN0q5kUVC6AX/JYKcsSVQTqniHXirfeKpevPAOtZ7+NSt
	 Vdjr3tR7lHaQ+t8QcGdP5SrHkDn9ftnPdfxyLROeob2GHK4QxsrAilAi7rX7n7SA6TUxj
	 sfxA//kBLKH0RX+VwwDUpRhPmuu3gjrBMc4xoI6latobZbCOz8Q8m7fqycMutLtdxtvrt
	 OCqT2F6BQWvUrFsbNOIC1zkkmIVuceC3OetHsp/dmjuiBWRfrEkCs0KoB/bBtWj4Zfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=SfTTZ+nW;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE0606A644;
	Tue, 10 Nov 2026 06:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCE0606A644
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=SfTTZ+nW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794292913;
	bh=KDDnULezz0lYOy8E8UC/jFsEQulCu5gvg3BMNhfnq08=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=SfTTZ+nWCSvOOeAwOUskOv5JEMPVZjLIQCCbrbwhyiMgneIi7FR77dN84F0fJcrer
	 GzwtqFl11fTwd3QAxdzT2Lva41y+s4P0waKJTuWDjCxRWp7Xxg6m7ruxxR8RJ4FaWg
	 5/ypBkWJ1doLlZ4hurRBAhIgoLxhwo9cjzlhEmJ0=
X-QQ-mid: zesmtpsz1t1794292906t134bec0a
X-QQ-Originating-IP: oveHQlJZS5x70FgvyEUxF/FxqKq+xrb9z38Pxn3Oj8M=
Received: from = ( [183.48.247.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 14:41:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4058580149435769383
EX-QQ-RecipientCnt: 12
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 06:41:43 +0000
Message-Id: <DMRBR0ARCU5N.1WRTDA5GN4OG5@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Sebastian Reichel" <sre@kernel.org>, "Yixun Lan"
 <dlan@kernel.org>, "Aurelien Jarno" <aurelien@aurel32.net>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Alex Elder" <elder@riscstar.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset
 in atomic context
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M75I2DDAzREFGJVAK34Vsh2hoI4LWS+DRTezaCk976dM47Snl/iyjo46
	CwL4ODDoBRITs4ehM/pdaQ+dvbp+H5KF/+NjV632gkX0jJpqHFG6RVU15O1hddOG7EEA5AH
	b3WiV5FPDbHIxURxuKjWhlULWewILpd26Yt3YMoTYg7yQza0jADBfq2Jk74+/WjyjEUl8du
	+oNwl+hyhikcePPslM8dpEZh7sMk3MsDFOG0qpzorOs+jBGoQN0C80VeAdEMUORmKXrajob
	U/09UOk0ElwPvGvq81Cm+TDHcBYN3Pc6YPqP3IwnQQbIvvPMtsrsM9Xp5QVCmFAxFW+OGpW
	8gxQbk4usL9rtWEF3qjRl85/CTMHoDZ32DlAIHTYFvAmu1wRaATybVO9JAJfQm8u4Rsgj/r
	lPRCniGWohwo+DueAlWCZJXpFlb9Jqe+0a5tYrHJCsAVsB7OrtPbNa9H+/xbp1UsW1w2gCS
	aQ1inlizQ+y6soiI5pCJMEv5GH+1NL+jWpDd33udAiM6MR3LUY20jb4RSCR1zLvAbtCZ10z
	0lltyKvYQ+RzrpYJKwEO7H3h2eB6uZh7A2YzfrL6CkgyIkiNrjCAJ2oYWNIQ+68G/f7rYC2
	D04GEkRHvP0UaDRUSP0wLHMbnb4dToS4Zzp6O7VVvXNI0AydwkQOvt4z4lM+kWE7g9sKAqK
	gJj3nwmC56jiBJtl5M7eY29ZYRFHvt40W+0hn0aR3NowcZcNVzKly/jUYnGsUOFNwvPdXAi
	FudLyrG5jUdOnaWczQce62oJAb99e3vXZ5AV1YanBVnLyPhOcTnvem/A6tV6EtlolO11K8I
	Wwv5spG19PShk2dk/d4L65X/1FYDyBAcROk7SU6dNvYFemPr/PnLbNOPRUHeYr0KpDB55wc
	8B2KXwcJt8CSoZ0cNCxYZYNIcMyB+s2Bur3WF8wFGx6dJ6VanZs+kguVxAkw1naOdg+SFEm
	8AbNHfgQAq4ZDLrUJqaS2LkorQ2EHPh0s1cD9s8bb/wcofxBCe5fefbPRlt1qVla4ceqtLn
	/AQPxGS4E9RCS1xGH6sFMAFfsQ9jvyi+rX257gUgtE3uon6MD5jWHpvsAxdDe2IKcOPmjO2
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue, 10 Nov 2026 11:44:26 +0530, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
>
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
This usleep_range() was left behind when the PIO path and
spacemit_i2c_delay() were added, so please add:
Fixes: 5dd75dac1b35 ("i2c: spacemit: introduce pio for k1")

Otherwise, LGTM.
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

--=20
Troy Mitchell

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavK8pyEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9IdAD/cSnhy/8EVYiM
iOg2ZBk126QEPmIPly5ZvxvY7dIXMt8A/3F0j9wcXPKP/DGUvY9SzSto1m3OYAr8
vnOgFrFuFiAE
=GBnh
-----END PGP SIGNATURE-----

--8b303d3f581878ca74b7956765d7a47b0d4702373ae20e17a1f1330f5a6e--
