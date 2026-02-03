Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE334B1A5
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145185; cv=none; b=H7XZW2JqNf9INK/eVMBHDc8iIS2RvSALJfgXC8TkwMbBxUZfVs+VHJ4dAjaNtTFpGP65C0PtiIRs3ZEuSxUIRs38uLlo0u17n5TS7Q4nILbIW9bUi/9W4YVg3yC3HB3c/tN2nLjqRrX5frIB7f14QP9/nT73oqKhf2v1QdtuqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145185; c=relaxed/simple;
	bh=PeH0sFwwpTINbEuwtPxgyvguZjBQwBi6mpvw3QmgLNM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mGlTFRmDssLiB66hOYxBS9moyOxdbLBYs0FKmu2lXsgg27tHjH7/n5i2Thi/5+bHQijikYhL4uwOsPt3B4JwEHEONC2Os+2Z1TGPGJf/p4cXGD5AE6pUevtzSV9Kf3IXmSLP7GTLdAo2shF4j49CMYaSQ8McydbGaNOS9En4Zzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=U6JeDelX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="U6JeDelX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82307c6902eso3073595b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 10:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770145183; x=1770749983; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeH0sFwwpTINbEuwtPxgyvguZjBQwBi6mpvw3QmgLNM=;
        b=U6JeDelXwmbX4W+AuPTXuDWDzO0IEFl6YVS91M10GoCNDY3qifAs874Xql69T2OZ0J
         3qgHumLuhggK6Xud84384xL+QjywRqT2P1Yv5E0/I3TrwL2TwL/z5ozrvLk3g2EHcvV6
         kTzQyNkpTqOYhNPoUdob++RLYZJAGAzxf2HJ28iOlt2GtKqCYeJ5z4aDiPU9ud9A+4uk
         F14s1xe7vV4vIeQ+61Hf++87ee70bZSYjV0stjedqlzww04ibaTz7J3Ke/mm/1pQU/ht
         KpqA5LK3w2ZLyo4hmzHApE6xTQce7nJ6Q4a1wQVVEDpUcAOOElNJhU+2tkAxZ6/SG6Uy
         WBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145183; x=1770749983;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeH0sFwwpTINbEuwtPxgyvguZjBQwBi6mpvw3QmgLNM=;
        b=KODFzUWAWKxXDvtSxNOts8Sd0k8ZRFwvawiHwRvqbftgjYF9BXHMx2byEL0GkRT3LU
         7wl8NFoyXDiL4nReTfLVv18cN1RdbUOZOqOpxbr76jAXwTkC4dP3tmxfHPQ5lsVA/9qR
         i/tAjMHdJhtVm7ysBALSmW7iy4q9eRYj6RtzcGGcubwAVlmn2nBsVOQ+xGzVDMqk+e39
         DSq/TWap9iPredzGcHuEupGpzW1HYGohzCdaQdkzlOO9hhbx4jiEZmCAEcO+uYQGDcik
         4dXHpbGwMV3mbrT6sCDjAn1kztMVPUg3b8qR+R7hOXht2hzmjlJUxhUSYL/w3SUYl4De
         u6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVqzWigcGIAWkZ1ImBxZrUmEbbsXTTAnyg9QARRZ2OVK2bTyzq5yDwOZAw8cFCgJAbJZPJbM4murrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkg4KDwaRMT0j0UZNsh7aBMhlbsRHnyI6ZL1KVSLyJ50IwT7jy
	vZ4vCdw9NlKrZc1rlaIxuQFbnvcJrjEZchSsknjDf5yTayw8ZtP8DhAfPHIQf9trShE=
X-Gm-Gg: AZuq6aKGQrdA8IlqV1dTfI61MhNqc1BXTNFijdJgRiVKVkdDD+HfwcBgG2DPG/PDTqH
	fzjpNmh2duy7oH11XuSpFV8ySrmNfph17tPnHVrP5G+Bf6m83jbpDOwBvj7AMVVeINR+KnsHwgA
	aovGAhBmMVELosojJpEQo8ERp0byzjJkTHesW8LLf4NctbAeB04Xsyfs2Qr/gLcdHu1AuTHqnPV
	OPkrv/wwsEvjsLAhi/NY4CrmY22rCa/OvQTjPMpruF9kXJos50MNOX9454NDjyCoqZrw77ftOiQ
	AXtGxk0+Ia/wbeh6QvnHrjpx0g+m6nRZjrgWc7g2CS/r0nlQ27zgNvmR2XIva/A1t1xP/Qw7lwv
	nSKtalVKQp6fF0WpmsOwpHsNjRUmihK4PkCWX0WQPrsKS8Ho7jRPBFrlpb9d4OZTonplTEhL1vZ
	Zi73tljzCLe9RvLR/2M7wnXri9X1/NZFiXItqhzg9hUAFUBQ==
X-Received: by 2002:a05:6a21:328e:b0:38e:87d7:7b95 with SMTP id adf61e73a8af0-393720d09bbmr409396637.20.1770145183502;
        Tue, 03 Feb 2026 10:59:43 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c85065f6fsm51846a12.26.2026.02.03.10.59.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:59:42 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 4/7] i2c: xiic: cosmetic cleanup
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <aYIXagCXYb4DrDLp@smile.fi.intel.com>
Date: Tue, 3 Feb 2026 10:59:31 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE565BCD-28D6-4844-BCEE-A1F60DC84662@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-4-ce4695f5267d@nexthop.ai>
 <aYIXagCXYb4DrDLp@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 7:42=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>=20
> On Mon, Feb 02, 2026 at 08:37:21PM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>=20
>> Re-use dev pointer instead of referencing &pdev->dev everywhere.
>=20
> ...
>=20
>> - dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
>> + dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
>> (unsigned long)res->start, irq, i2c->i2c_clk);
>=20
> No need to do this here as we change the format string afterwards =
anyway.
>=20
> But I leave it up to Andi, I won't prevent this to go in, if he =
agrees.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

No worries, I can do this in the following patch, since there is going =
to be
a v 10 anyways.=
