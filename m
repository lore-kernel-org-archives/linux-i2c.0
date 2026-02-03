Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58102E975E
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144659; cv=none; b=CIRa/XPMJJxUvlIsxTRVHEBE++IL95BgcEW+DmCCXoPZhVyRbxBW4WrobCsnTu0pstknL+Guv28ovT+fV18doiDRywtJeDOtJX2wCDS4iePKpNSiBjTl8ImPUYPXOraOwb1u6mc0B3h8b/iksJAOw/scVppucqCkevPYgEj5UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144659; c=relaxed/simple;
	bh=DHmaR94WIM1xMhIJTLcWEnvc7pYhuGrKmKB5FjKwX9o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K9hMuRaPYI+2qD2kviVsEezMl9/L9Kqr+zeQ0N9tD+pctyFs6SL5pJEWprfsOoe/rbnEZoVfGv+ycxRO/Ub4mOr3RwJUkqIpYVTJzhEf4ekKZNgo55DGKI4XvqYCN7Ue0tp/DTgX4hNcxvKnRk2YAYtZmlcsValt/YMgMkxfv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=lgS6/KZV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="lgS6/KZV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a23f5915so40298485ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770144657; x=1770749457; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rfw0XG2ThbAXfeMl6ZSUUMc+ZydcYLefy3zvZERR6M=;
        b=lgS6/KZVx25a5hA5kFzufCxZ1oE0H9QnPSaeDrKRQALZtYmqJnmz0+akN+w1wK3qFB
         3GUphA/B9duMHad9aXQsg7wb0LLCu2cYLalNPMEFG+jHukLzh0hs9X+uWhsastMNEGGr
         c9QLQEF8XTRltJYNfKATFft2RcDeOaieVEqSH8xQc3xBtcfaJo0L7RKihRGSpvMib6Pq
         kydh2nogc0T4/DAOcPOVMpr2525N3g1WnqifVICeobyjJ8DI/le8l7R35ueM6cgUXn7r
         aXKMFwsgmWRakPQnMEtj01fy+sdkG3TWonn6xUQcA7EDHlm8sqvA+W9M5Woqqw65xDEx
         We5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144657; x=1770749457;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Rfw0XG2ThbAXfeMl6ZSUUMc+ZydcYLefy3zvZERR6M=;
        b=hB//xF+R77CQxmCSFe2JMzeGfI62BVLyBkLjd7uwO8wJmw5mfjooi+RSwzKlBF3AlR
         9yYiVwwST5JYsmUvN6Mib0S8knhC/mlHWZosw6fY48oxnQOnOyP7P8mCGPi94NcqGnIy
         E2sW6aQiQPcQUH3nAjsHZP5UAKRbtY/k9LS/5zO1vESqRwCtAXTd8ESabZC85g/L3kmQ
         rIwgm/G7T4p0ASXZlyELmkD2ebxcjN5DJ+jLuJgQuU3TL6lAfl+9kGgK7338ueoJZ+gZ
         Xf0x5JiY7c8tP/jP1LqFeGRewGCrfKJUGPU85C17yVc5F/xR7H+HNVA12AP4vxivB+rQ
         Pvlg==
X-Forwarded-Encrypted: i=1; AJvYcCUbNe0AloHIPo/ntxlw2IeLqSHnlbrp3sBQizj3KQ7fKpN6UpADw52itMWiwI/QL9PfpjUslb9O11g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7YO62bEaargCZ7qVaclp/SalQCiUzvDvosmJQ0YSw5i1onXk
	3ykiWEVzDySzUhGBcr/vlAgQo9RGhuYMzXEPAW9K8cbHdDHKP4kPsYKjjNzUK8JiP24=
X-Gm-Gg: AZuq6aIqZovdO7Qkz7ZV7YytYPf2hlYoXwFdd7ZTfUOD4L6vnvL4nAECGfFCqpc7q6W
	wqIP2J/teOHAbX3jeKp8U5WsLyHblg4q0bF/HwW3xdSUZydJSLXU465Dk1SRi/nzEiGl5ETUBsR
	O1/iDbc0bxsfzoUqt9VLK4mCJ6L6Vjki/Ir9gBgMI/VspRE3TXPFfoElY7e+KUUmfasnicFrdFn
	bmAqP6Pw81lWymIt9wz9DB1sH83JoeS44BMjCDsmxtQEBYTDPYroMEaVIA2/DxabEsIuKuWo7kv
	/wNM1CFeNoy1570RJFYLachyACqGhBUeeRBtpjz7f58g5LDxPjD4B80/hc/UT9FLfUzixMuhq+K
	gYWMLWXiZ3U1kMoySP+o0Q2VMeiKO2ydVHK8lnZrQHG0ZaTMzys63asQpTzg3E2+pSB+wi73505
	/TkwbTceYzhHYs9hTuyNZ8bADo70Fhu3fQ1it6fLakTPLhlA==
X-Received: by 2002:a17:903:19cf:b0:2a7:aa14:82f7 with SMTP id d9443c01a7336-2a933b9d152mr3156645ad.10.1770144657038;
        Tue, 03 Feb 2026 10:50:57 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933888e8csm2181465ad.29.2026.02.03.10.50.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:50:55 -0800 (PST)
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
In-Reply-To: <1ac7be34-22b1-4d93-9957-fc7ade9a2649@lunn.ch>
Date: Tue, 3 Feb 2026 10:50:44 -0800
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
Message-Id: <DF13B121-56F2-4987-A47B-99A20E18554E@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-6-ce4695f5267d@nexthop.ai>
 <aYIYBheQgIN71os8@smile.fi.intel.com>
 <2F830E87-F00A-4A54-A5CC-E59BD2C5C7B2@nexthop.ai>
 <1ac7be34-22b1-4d93-9957-fc7ade9a2649@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 10:31=E2=80=AFAM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
> On Tue, Feb 03, 2026 at 10:14:49AM -0800, Abdurrahman Hussain wrote:
>>=20
>>=20
>>> On Feb 3, 2026, at 7:45=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>>>=20
>>> On Mon, Feb 02, 2026 at 08:37:23PM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>>>=20
>>>> Use i2c_add_numbered_adapter() to allow platform devices to specify
>>>> fixed bus numbers when needed.
>>>=20
>>> Not sure about this. Doesn't it break the current approach? Please, =
double
>>> check that.
>>>=20
>>> --=20
>>> With Best Regards,
>>> Andy Shevchenko
>>>=20
>>>=20
>>=20
>> If pdev->id is PLATFORM_DEVID_NONE(-1) then =
i2c_add_numbered_adapter()
>> falls back to dynamic allocation and calls i2c_add_adapter().
>>=20
>> Many existing i2c drivers use the same approach, see i2c-pxa.c and
>> i2c-pnx.c etc.
>=20
> It is not about if other drivers do this. Its about does this change
> the behaviour of this driver, so that I2C busses get different IDs
> then before, and so cause regressions?
>=20
> You need to explain in the commit message why you think this is safe.
>=20
>    Andrew

Before, the driver was always doing the dynamic allocation due to
i2c_add_adapter(). So there could not have been a system that relied on
consistent i2c bus numbering. Even between reboots bus numbering could =
change.

The systems that did set pdev->id and were expecting a consistent i2c =
bus
numbering were broken to begin with.

This patch won=E2=80=99t break any existing systems or cause =
regressions.



