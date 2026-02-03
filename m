Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD1369205
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142503; cv=none; b=ey9dEnM88VQ0J3QHKt1Gdfj6nihY8t1inFGOcOZ5Xq/1Vj67HBj+/fzv2k+Qf5R6tQOOnKDOxkOylmhVNA/4y6nthHcEJ68ZsNhPWpeU7W5JoIMAu8HTWc3kHKzcSYmwEuJvlDec0vFSiCeNyZtnfARdJjaIL9u6UFjNWnqOD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142503; c=relaxed/simple;
	bh=AhLtBFYuwe8sjQdJz53j2wA7HDUB30kbmrpluvLvkdw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m/JubRQxKiLtSJ2hmDGoF4/7ziLD16UJEWfoIUty727g35xzStOPDurI0zENlz/H5AbzxgJP8n5Mk673e0IEEwtEL9hhOn+wpjJi0F3l89g4dXtS/iGl8yNNcfPRlLFpak+fzSe5YtYcZtAnXvthuABXhhB2E6ik6KJzJp8o+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kGesceCh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kGesceCh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso3940817a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770142502; x=1770747302; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhLtBFYuwe8sjQdJz53j2wA7HDUB30kbmrpluvLvkdw=;
        b=kGesceChbVrf/l07Neb9Bo2rH+IJr21G6ehWSggqft7eRgKtL6sdpUuFIM5mwNOQYZ
         bV3rj1hiezGNXkZMK0yDm+Ui3CEk4KM7jF9hfSAykqfHXUquUmxBwDcFMnDU1MjdCTA0
         z6DI2oFy2nOzN6SV8XOCFM8c9xeqxqhgYN6xI4YfIUDRkrH7IN9pu11zTLxlYVPXzbXM
         im2GXZF+TUIxaqIJ7NrIm+x+hnz52nmX+a9bgWBLz0GbmB4IzIbSUuG8wl6UNoEki87K
         ObGvrXI+UBbSxiJ9takkYe54YbL2bZ3jn9st8kq5FP2/cPlAvVaVZXSK7pHv490LWTNs
         Ho2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142502; x=1770747302;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhLtBFYuwe8sjQdJz53j2wA7HDUB30kbmrpluvLvkdw=;
        b=j65nkOqS4i+lFbcy0SDRzxhh2asLx7oq1Ai5aApa3wKhLuIWDYQcc0mHqnNy9B0rRj
         Ko7394rLokSXT5jegiYaNb9ufePVKk9n7IUr0SLlJMvhK6B2kjoiu7tXubsuBWHMQs3P
         a4wnNKwKiMFhOmoD/0uQ9thMcHazRgOEP5XrtcQS+YdHQGHWE7F5yEttg2iaPec74esB
         rB9gEOmtaIgvpc+gC6RVbcALFdVEWUJh4jXdYmi8C+DwYsdaXxwEuDRZWZPWXuLAMq5y
         mQ1BWROPZ3Wc+MeFCU9kyWxoDwffeBstIO7tfVPEPGfrwFJGInEJhyc7Z6ARsQybWagF
         M/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQfYcLjL9W/DUKtqB/S4JZHLUUfctFf5anImMUM5e29COn6UvaRbMLbzsmRp305Qtiwyw013oJcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01LqI7Oc6qNohaAglDrAaGCyZDIZxQEiS7SnjDfjm8pGJRRpK
	RL3RhcqnPRSe7qujbatrbaJrfvLnuicF2qyn2K8wph6DOLPJA2tVzb6Xiuk9NrLCvQo=
X-Gm-Gg: AZuq6aI2fHIfUu7QIPo2zyyjrdFWbOUtNFg5otqQDkZRgrsy60s/E25g97ea+cJ24Ut
	+7aZ1+hk20cTfy9VT5lCIye1Mh/O3mSVgHX61i/gNV0IjfINQYUrdaf5UPxzz3AxxY19COr8FxW
	1Atq4yx7vxKEeKWTxL/IQVd/HVDXwnLNCm2fanUCj3YbTbQu15n9NZbKi6KhFv6yJ5juKEjNm12
	wOEfoLyAz597y58aGh2AMORVZI4ef/2tD0nIIsD3f+u0UblWwSOsapkAEkKkspY2u98dAwQG5JL
	W4rzoCIy3ksyQTa8T/tkhOZ5khmASLQYpdMTvtcLsh76NTpkwmjt2hn4tc6jDmGd4SLK+ztIm3j
	x48zlJInw7/fejucXREG6kX3sKgldHAFPRw2pSeecMKXHA47IS5Wq+S8bjkRSHhprc3d2Gj5U0K
	n5J7RFUd6Qr416zPXmdvb37BVutMEWlAMUmqtV3VEMwe85mw==
X-Received: by 2002:a17:902:f711:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-2a933bc9acbmr2072775ad.6.1770142501839;
        Tue, 03 Feb 2026 10:15:01 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d43513esm32495b3a.43.2026.02.03.10.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:15:00 -0800 (PST)
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
In-Reply-To: <aYIYBheQgIN71os8@smile.fi.intel.com>
Date: Tue, 3 Feb 2026 10:14:49 -0800
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
Message-Id: <2F830E87-F00A-4A54-A5CC-E59BD2C5C7B2@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-6-ce4695f5267d@nexthop.ai>
 <aYIYBheQgIN71os8@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 7:45=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>=20
> On Mon, Feb 02, 2026 at 08:37:23PM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>=20
>> Use i2c_add_numbered_adapter() to allow platform devices to specify
>> fixed bus numbers when needed.
>=20
> Not sure about this. Doesn't it break the current approach? Please, =
double
> check that.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

If pdev->id is PLATFORM_DEVID_NONE(-1) then i2c_add_numbered_adapter()
falls back to dynamic allocation and calls i2c_add_adapter().

Many existing i2c drivers use the same approach, see i2c-pxa.c and
i2c-pnx.c etc.=
