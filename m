Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE7367F24
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148665; cv=none; b=qXaGEdM1wwEst27HdNJGfJcZBwe4vR1Lcqe3nZcytTnc5WTPWHgcQdwv+NsaGylDwS/xL6RIHS3WYg5rmW1fW7a7mTzoYtIj+OtAx9XYJA0T11B9AK6o9KB3vyTkEVj44zbur2+VMERzwI45XYIfzoPFE9Lw87K4gSb2xpvziXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148665; c=relaxed/simple;
	bh=fLXl2X0g8DFDlByHQ+eg17coYkA4Qg3G0nXPhngDioY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TN3+gydtM6gLrT4sgb2Qt453IeaVg5BgY48Iwj8i5R5bR1WTL5Ytzv0W4DaBGSYueYplDSNa4cSUUZghuqoWt2plwsZJazgh60SOMSqtKLv9pXLPjxtEAkK5brhMn7ez6aBhLfTBy16MQLvkOFxdnkVtpVF7kGNgQ9xTjIoaV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=SfZsmlXd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="SfZsmlXd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso3522020b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770148663; x=1770753463; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkfty02cxqofjS2vATNtghiojOPwFY5oNur2jl4/Hn4=;
        b=SfZsmlXdZZR5EN1Jf7PRGejz9l9OZRVMLiFDkmZDVqNkS6b6xjdNBK50xI8/Hh2OZr
         PEqdP1TqSsqXtYhg2JDwCGq0OLs8/+JdSLSvTxa09PnJwglg7MYIab8bXGuv4o5n8ic8
         ZfqHyY/xK5yntCdv2LyrnW1VQFnbRQjyI6LqATm3Vyu3Z6wl0vvHebpneQxzu7nHlfT/
         CXvZoLYPMYnMCKsGNQ9NYf3HvZOAEt3S4GDOIhBkcbP3zlJuq9TAwheM8uKaM7LO+Qdc
         Qmys80n2exIJVM1Yff5bSMOWIh3P/xM+9mOnjmVQslRaLUnwo9G8StCYX/w3dUaHPLWa
         cpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148663; x=1770753463;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkfty02cxqofjS2vATNtghiojOPwFY5oNur2jl4/Hn4=;
        b=wH6klo0ikymxEJBKHxtRJf+/yfsT8e2VrpWRpWX0EzO79z1bCAvK6gXCfz7bRpEt3n
         byFAdBSo47E3qs8MpKR9xV4s/5hMp1b24DZDT9gt/ciHuf7JeamX07eT0nAkwhRVJnuw
         mTTRd5gSBHwQTA85vY0l2376RjLqxj29B8kwg7H4IAimJihiULkFJfGG3fnYD20IuvNe
         u7CTVcLVx3jnMTWwsDVj9FzBcYTtwI/1iZb0h4vtB+kV8OIlws+m5Hnk1G9P0wx+YP+W
         xo1UwTKBn5DC6ZWJeDBVrFbnXhP9PkuOg0nrlPtGEjGOsnAY+A1ibm7u+0/5I7BVwKas
         lJFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2XUDVDJD3q/3+OaeoCNbP/RdFOrd6r/DP1NAG88hDi7sOvsLr37dcW8L9YTLf7YhVHTb27IB2OGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+UAjCVbnI9d6zWBRt34mUF0BKVI9AnuML9hnnRhEzveQklZr
	Ua/t49vN3DIVRWnwA8qECxivcVZJhGW6YJkq91dCwSJulqwLdmmx+2QI7mOKSoxjOTg=
X-Gm-Gg: AZuq6aJ2StrHqZWCfhYsIPVIvkOexvwW+ozp9Gi2z0SlGQqAXd384ff9JMgHDVJxxM7
	AcoO5RM2LsoZ2LYWHDEIgeezyszpIzhcSiaZKBAVfYh2PrFv2bNr3+dWbIM2HtMgJpRKQAuUfRG
	J5H2cVytQ7vTlTVbAA1onvPS6aCjy3/Dj18/criRZZBwMoRXR3Pt8NTfcSlQCTDXHwK6FfXOBrT
	MHpF9Lflg6gvq6mJdzIG0mekpahUFsaA/aVRYS5y4i7eOABkROPEhHlQz/Vi/rCEmJxHCrpoqMA
	5+P9xQx05BVqQ8VTdosPs9Pn98afW2lXzaTPDFuzZncB5XjFlfuaQR3N5U6V1ZKFftRHX1GWNRl
	z8nW4rEk/yfQ/t819P+rcbOebeXkDaYfCpA4shqLgqSCTfe0yeV0kesWPw6GolZ4kwM1CHfhZqx
	fuJdtH2Zf2zLTDS9KK8h2XqlM6HvpR1e6mZMwCT3Nhg7RcvNGYH0a6Vkxm
X-Received: by 2002:a05:6a00:80a:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-8241c1dfd64mr495588b3a.22.1770148662815;
        Tue, 03 Feb 2026 11:57:42 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4af6efsm181555b3a.65.2026.02.03.11.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 11:57:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 6/7] i2c: xiic: use numbered adapter registration
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <DF13B121-56F2-4987-A47B-99A20E18554E@nexthop.ai>
Date: Tue, 3 Feb 2026 11:57:30 -0800
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Message-Id: <2D57C995-C65C-4F61-9CDD-9884967E7CC2@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-6-ce4695f5267d@nexthop.ai>
 <aYIYBheQgIN71os8@smile.fi.intel.com>
 <2F830E87-F00A-4A54-A5CC-E59BD2C5C7B2@nexthop.ai>
 <1ac7be34-22b1-4d93-9957-fc7ade9a2649@lunn.ch>
 <DF13B121-56F2-4987-A47B-99A20E18554E@nexthop.ai>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 10:50=E2=80=AFAM, Abdurrahman Hussain =
<abdurrahman@nexthop.ai> wrote:
>=20
>=20
>=20
>> On Feb 3, 2026, at 10:31=E2=80=AFAM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>>=20
>> On Tue, Feb 03, 2026 at 10:14:49AM -0800, Abdurrahman Hussain wrote:
>>>=20
>>>=20
>>>> On Feb 3, 2026, at 7:45=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>>>>=20
>>>> On Mon, Feb 02, 2026 at 08:37:23PM +0000, Abdurrahman Hussain via =
B4 Relay wrote:
>>>>=20
>>>>> Use i2c_add_numbered_adapter() to allow platform devices to =
specify
>>>>> fixed bus numbers when needed.
>>>>=20
>>>> Not sure about this. Doesn't it break the current approach? Please, =
double
>>>> check that.
>>>>=20
>>>> --=20
>>>> With Best Regards,
>>>> Andy Shevchenko
>>>>=20
>>>>=20
>>>=20
>>> If pdev->id is PLATFORM_DEVID_NONE(-1) then =
i2c_add_numbered_adapter()
>>> falls back to dynamic allocation and calls i2c_add_adapter().
>>>=20
>>> Many existing i2c drivers use the same approach, see i2c-pxa.c and
>>> i2c-pnx.c etc.
>>=20
>> It is not about if other drivers do this. Its about does this change
>> the behaviour of this driver, so that I2C busses get different IDs
>> then before, and so cause regressions?
>>=20
>> You need to explain in the commit message why you think this is safe.
>>=20
>>   Andrew
>=20
> Before, the driver was always doing the dynamic allocation due to
> i2c_add_adapter(). So there could not have been a system that relied =
on
> consistent i2c bus numbering. Even between reboots bus numbering could =
change.
>=20
> The systems that did set pdev->id and were expecting a consistent i2c =
bus
> numbering were broken to begin with.
>=20
> This patch won=E2=80=99t break any existing systems or cause =
regressions.
>=20

I can add the following to the commit if you find the wording =
acceptable:

Previously, the i2c bus numbers were dynamically allocated because of =
the use of
the i2c_add_adapter() call. This meant there were no guarantees about =
consistent
bus numbering. However, with this change, on systems that don=E2=80=99t =
set their platform
device ID and leave it at the default PLATFORM_DEVID_NONE, the bus =
numbers will
still be dynamically allocated because of the check in =
i2c_add_numbered_adapter().
Therefore there won=E2=80=99t be any change in behavior.


