Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B314218B9
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227979; cv=none; b=ZxB9U5MG1z/AkqX3LrHwpWHZ23KHHNM/g6XVkZ6BIqYunIyVWtcBh9wNExmDDEz81d+4XQZ0rs39EjELpWRIHVK4l3Yd2LyfbOwoHHZYPv9r62dFy8VzaojHnJhXf9jKv2WUOoUUruuky8yoFZDguHtWkm6jJ2i8zpDHt5YTao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227979; c=relaxed/simple;
	bh=DQMMFflNqnk7npdBRibcUjPFqk+hQsIRfSSjEu4G97A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g+omtrvBJuHQoc9FieHt/o9FS7A26jqV0oLmqaT/40g2hd7ErglO2lFo7Q5mbao2lgv4sPbzH4iHO382Kmyi4tDCMp9G/J40i1bgCm+YvEKzDz616Vsuj70rCYNN0eF1P9g1FHjXvo9FEofWmPHHTI6HEMJajd/XXwKlw9ShjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=g6MGtNTx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="g6MGtNTx"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81dab89f286so62599b3a.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770227978; x=1770832778; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQMMFflNqnk7npdBRibcUjPFqk+hQsIRfSSjEu4G97A=;
        b=g6MGtNTx54YgW5OyFcbLokmgzD974VboIQMjoAA4L/1RkTdhwTNSeN2AgTfTtAShTH
         wIrz2Dau24FO533lNiweMWObnxIyE3mFNhomjdD2c0Oip+YwAFbE+qAKrJf1aSBnKhDO
         celfD5q5NJQkfJ4CMvqA3AsP1mngVv6k6yFNudyJqmSrQHCIPa84Fq/U6niwht2dYeTd
         HyY4cQLoas0gRQXO8Zp+H9cnIhp0Nv6Eh6BOczYfND6pZwbqfT1oicqp/nt3wdZVpEYC
         0zA2ef2aRbZGeUw2dr3TKQxf1Aeh1WkwAtDqEOf9GXmsaqIrvcI2gQniLJimrohpijI1
         O56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227978; x=1770832778;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQMMFflNqnk7npdBRibcUjPFqk+hQsIRfSSjEu4G97A=;
        b=Yyj8iwcici8RR90vbd6N58YXilCkSLc13S2MW2XAcbB627+Ev3USnBfdUyp1HmH6NX
         rNnOgV9OC0p+xAMeQ7tXguXW6pDz98y/Jj7sZkSHnxZ7ezGKKU5P9yc1J92gUkIC4e8y
         Xl2jqmbMzUe3rZ4JYhdeCoPHWyvztv+T1w6HzrfLAAwZ6w6ivk6AGpy8nTFdVyYIMHdV
         MaNdqfo0C0PHQBF4G2PknAXF7EyRszI5rrS932lEb8HWq4ZFfnMpMoHoX7V0/Jk/86la
         9RIS6qPptFDa1MSMJKrl8GIruvSST0H9XNRPkXgR/MAQqPsfIDWi4aCctPd72Kou6HMo
         3IXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqwnIjiGX2S7iJV5fWAUQLRTnkDkTObK4NHbmWuYcZiTDb5pY8rbmiIQ7iHyzpcdLeqmRcp41Dycs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDABgNrlC0QyAbrH98v3C65uKeeTY9LyVhhT30sSiMbkAfAxh
	+5+z/OBldDlC33I1HiTM1hxEhCQqKx5C0DL2AM/ZESgzE4QrIM0iP8JvxMIR1nxdDKNLeq1ukKr
	pAarB4iY0DA==
X-Gm-Gg: AZuq6aIYzhTNhYbuiv/qPhM+gUl/5VzFie2ldUU6WXopaIAcscbaZvSZyXfaNNyXi21
	RSpZPp16RfAGcV9HxZkiZcCe4Y780HyGFdP7KPrCd3afW//sCl1O9bzYeYdIOoDfIja0oQPLF3s
	K65W5daMtNyR/dSdk6prMeQ47KDD40RaG3TEpBJpnF/8wpOKUu1qBJwH1rRL5JMqW98Pv1kktlz
	/RjrZSrHUhsjhgUeUfc2r/Qx1tHXCUdaWrqYuASelQ+6+i5p36UwtgePRoNcxX/EFH5eR02ETO8
	bIhH/LyZebxipmjSuGzS1aNmcEQ1zWIV8yvzTYDXd7BGB0IlckUtykV6+pBdJLPnBZuw0gkR1nX
	5EPXUjALnZy+IixbTB6IC2Mv/6wmHkB81/HBSmbAz23QInPrLVCik6ouT6OGoCfHUzTU1X0i4Pt
	01ubFZ0VPdEoAjOQKtnn3lusHGy66iWIiUIdg=
X-Received: by 2002:a05:6a20:72a2:b0:38d:657f:7d9d with SMTP id adf61e73a8af0-393725ddbc9mr3332035637.75.1770227978511;
        Wed, 04 Feb 2026 09:59:38 -0800 (PST)
Received: from smtpclient.apple ([50.47.115.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397e9cesm26698205ad.97.2026.02.04.09.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:59:38 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v10 1/7] i2c: xiic: switch to devres managed APIs
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <aYMbY62uJo95yc1l@smile.fi.intel.com>
Date: Wed, 4 Feb 2026 09:59:27 -0800
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B0AB3B9-A117-455B-949B-24805850AC69@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
 <20260204-i2c-xiic-v10-1-c2b996425235@nexthop.ai>
 <20260204100034.000050b2@huawei.com> <aYMbY62uJo95yc1l@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 4, 2026, at 2:11=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>=20
> On Wed, Feb 04, 2026 at 10:00:34AM +0000, Jonathan Cameron wrote:
>> On Wed, 04 Feb 2026 07:01:58 +0000
>> Abdurrahman Hussain via B4 Relay =
<devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>=20
> ...
>=20
>>> - return 0;
>>> -
>>> -err_pm_disable:
>>> - pm_runtime_disable(&pdev->dev);
>>> - pm_runtime_set_suspended(&pdev->dev);
>>> -
>>> return ret;
>> Trivial but if you are respinning...
>> If you get here we know ret must be 0, so make that explicit to the =
reader as it
>> was before with
>> return 0;
>=20
>> Otherwise they need to look up a few lines to realize that is true.
>=20
> Right and this is already the line above, just wrong one was removed.
>=20
> ...
>=20
>>> - pm_runtime_disable(&pdev->dev);
>>> - pm_runtime_set_suspended(&pdev->dev);
>>> pm_runtime_dont_use_autosuspend(&pdev->dev);
>>=20
>> Take a look at docs for the devm_runtime_enable() that is called
>> by the cleanup for devm_pm_runtime_set_active_enabled()
>>=20
>> Short story, it will call pm_runtime_dont_use_autosuspend() for you
>=20
> Good catch! It's not obvious from the devm_pm_*() naming... :-(
>=20
> ...
>=20
> This definitely means v11 should be send at some point, but,
> Abdurrahman, do not hurry with it, this series missed the cycle
> anyway, we have a few *weeks* to polish this.
>=20
> That said, send it after v6.20-rc1 (or v7.0-rc1) is out.
>=20

Sounds good. Thank you for your patience!

