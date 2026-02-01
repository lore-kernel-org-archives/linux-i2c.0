Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0681C84A0
	for <linux-i2c@vger.kernel.org>; Sun,  1 Feb 2026 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769912113; cv=none; b=r4aSZ/fY+9dJxdJlzVIY+i6sYjd6ZnIaUvzdVIhDp8/lA5ToNv87qFk1dK4h0ds7WOHdrt1sNleiptfzHUOe1rqrp4JbT7a18kCQ7iUjX+SpvRK5g9oqy+NhsPd9eTEVdNMW7DH27H1gLSrSKJv/fVde/ZAzMxtr5mwW0pASjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769912113; c=relaxed/simple;
	bh=aj9lZYh7kNC+5k/nDqMXYXmMyDNkwDg0+SpPugkdyPg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=moMOC/emx/nZtKCXfbXuEGK7Q78BLiYqfinZbFZMmuPr1+crntVSZTJpf0a2Koo6CVF9TNP52LoBEvV3RgjF7RJe7VgMUoqSrtKuNsVz7PNlG9Ax48LywkiJdEFXvR/SnXrTv96m4mHyYR6OC0or0vgGFVAhpZkLtB+5KqDaTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=AxQn8ZSZ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="AxQn8ZSZ"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29efd139227so20995715ad.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769912110; x=1770516910; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX+STYIHVNsNRwCOU5eoDnw7m2xr9Ak+mtAzKnocjoo=;
        b=AxQn8ZSZdxpDUMpJAzBT5rYs5ncX7YBsHz+MTp3FE8UWuDDTWZa+zgLB9jvOYkZQNs
         xhZVm9B+lDjycEhZOGashJTbAOzavduIqxeR5Mttc9l/iS6QFZmh3nbnglzOQkGarLpC
         P/P3f/1M5vY93BFjcyAgFprCe/QIFCJcINNYP03GaE5vTzwp5jCkw0b70yf+w4lV5UCX
         r9hxKps3Kvbi73XkN7gm4ZQVcXbSSGJBnu56oF9UKDKwEzFGlyhaiMufXtuWh3Luc5DN
         Z9zoxWB0PcjBAA616F0rusk8nWuIvzQZdM+4FKCPXvCBfPobCDnK5qKcTV+vE2JaOby6
         v34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769912110; x=1770516910;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sX+STYIHVNsNRwCOU5eoDnw7m2xr9Ak+mtAzKnocjoo=;
        b=jFN9plQf0dJ6pI4pUubnCzM8FnuzS8a2GkjN8GUAgcjtbAlKR/D2Mz2p4oKE6sPmGK
         yFBiol409fPdVDuSqD+3qRoOs5VBrUq2TFDn7bJk6IEMMt8wnAgY1clGXWEYh3NSt8C+
         BOWFwEOsSfnIyA0KqsgqJdNOdicwNVId1kNW9dnh1KgjQFBYp43ttIPAIbpaRF39k5Qb
         9DHytV+vyZfd4wKWOvcbhK2JepZwL+4JfS3100mCk/cjpwvJp0V6PX54xJC7JVCT6yFv
         P1Wmzhy8B1/bIvKknb2CQQyWb2+vj4jUIovZpmz4Dd1KlPNsXmtJFtFL3RQ3RZXFiCVu
         6Ylw==
X-Forwarded-Encrypted: i=1; AJvYcCUCuKRNx+efUmZ6SmdRic+Cn/uM2g4Bl/7knYTjVVTIpolhpAEhNjPEG15JshpF9l1IosckPuRDqbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRzeq6KaPjhAfD2bjCc6X0pWTI1OnLI0O0slGheWeWZ8H8HOy
	4vFMo3lmRLXXavHekDOXtrlBt0Y9D55w+fost282hZG/KJH+s4P+4z5t4LR+ErkgT+Q=
X-Gm-Gg: AZuq6aK9p1PUlnaekF0tQGLQfLznMlk3vbVJa/M5jdMSpwWI+wTqkAlB1qX9Dmy1UoR
	IrsW6sZ5qrsIs5kUzUEHCQHmB8NUpYfG7HJaTrWszZ6weI4pWgm5za1BCpzAGbkbpfiaSrOor+0
	WCKna+kASc7yASmuM8fuvPxIM8RqdYn8WR8d5GQ7Ewho3/59tVwP5AsE3IfnxKzadkd5clRhX+Y
	Nw7SCXDfqRaKo8VB3yyTSau926rJHeAp7H3LnsWcv8BscgFirdwbot8VHGr7loZUD813nlcylxI
	NcL52jlB2gz5fOk3tMeKZzMn/TqwUzQa/awYDCC9cTlk7FfaAXgV3mWsJ5OGf5bdMQPF+8dnrfk
	8Is9+6zeYhlGwndlvqnZlPvKRc/OZmxIQvfiBN9CXPLsT7vhSS/ygBBFeC+fqBWYaA9FDNaXCIr
	BG7pHWF+XkT5YLVLcJwPSy3WLJy0q1gTbDEK3dZqW+P2u/Pph0Mgom1pqEznRStrluiP3ED60=
X-Received: by 2002:a17:902:ebc1:b0:2a7:7872:8f52 with SMTP id d9443c01a7336-2a8d7ee6a5dmr71880265ad.26.1769912110101;
        Sat, 31 Jan 2026 18:15:10 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ea985c48sm39915685ad.22.2026.01.31.18.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Jan 2026 18:15:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <202601311615.10yziOui-lkp@intel.com>
Date: Sat, 31 Jan 2026 18:14:58 -0800
Cc: oe-kbuild@lists.linux.dev,
 Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81522270-1703-48E1-B64C-8CF174E1EF94@nexthop.ai>
References: <202601311615.10yziOui-lkp@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 31, 2026, at 6:35=E2=80=AFAM, Dan Carpenter =
<dan.carpenter@linaro.org> wrote:
>=20
> Hi Abdurrahman,
>=20
> kernel test robot noticed the following build warnings:
>=20
> url:    =
https://github.com/intel-lab-lkp/linux/commits/Abdurrahman-Hussain-via-B4-=
Relay/i2c-xiic-skip-input-clock-setup-on-non-OF-systems/20260130-054653
> base:   63804fed149a6750ffd28610c5c1c98cce6bd377
> patch link:    =
https://lore.kernel.org/r/20260129-i2c-xiic-v7-5-727e434897ef%40nexthop.ai=

> patch subject: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
> config: i386-randconfig-141-20260130 =
(https://download.01.org/0day-ci/archive/20260131/202601311615.10yziOui-lk=
p@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project =
87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> smatch version: v0.5.0-8994-gd50c5a4c
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: =
https://lore.kernel.org/r/202601311615.10yziOui-lkp@intel.com/
>=20
> smatch warnings:
> drivers/i2c/busses/i2c-xiic.c:1539 xiic_i2c_remove() warn: =
pm_runtime_get_sync() also returns 1 on success
>=20
> vim +1539 drivers/i2c/busses/i2c-xiic.c
>=20
> e190a0c389e601 Uwe Kleine-K=C3=B6nig    2023-05-08  1529  static void =
xiic_i2c_remove(struct platform_device *pdev)
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1530  {
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1531   struct device =
*dev =3D &pdev->dev;
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1532   struct =
xiic_i2c *i2c =3D platform_get_drvdata(pdev);
> 36ecbcab84d023 Shubhrajyoti Datta  2016-03-02  1533   int ret;
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1534 =20
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1535   /* remove =
adapter & data */
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1536   =
i2c_del_adapter(&i2c->adap);
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1537 =20
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1538   ret =3D =
pm_runtime_get_sync(dev);
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29 @1539   if (ret)
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1540   dev_warn(dev, =
"Failed to activate device for removal (%pe)\n",
> 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1541   =
ERR_PTR(ret));
>=20
>=20
> pm_runtime_get_sync() can return 1 on success.  Perhaps use
> pm_runtime_resume_and_get()?
>=20
> 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1542   else
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1543   =
xiic_deinit(i2c);
> 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1544 =20
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1545   =
pm_runtime_put_sync(dev);
> 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1546   =
pm_runtime_dont_use_autosuspend(dev);
> e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1547  }
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20

This maybe a false positive.

The following commit switched from pm_runtime_resume_and_get() to
pm_runtime_get_sync():

commit 810199f7315604b i2c: xiic: Make sure to disable clock on =
.remove()

Uwe, Michal, can you guys comment on this?

Regards,
Abdurrahman=
