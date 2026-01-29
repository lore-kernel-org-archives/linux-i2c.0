Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD237647B
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729398; cv=none; b=BOOwNeYm89TAKE0Ikzb85Qa8bdAXMUZMFJ7kIlaa81R4Z76L5c1IgW1KXkep+WvtXA5HyUTkOnGWf9x3we7a6oliiDgINw7RDnH5KS17pcehE0LcF7pgbop+otWpoatpLD5Mr4UtPLR0upc2cXabyHifVrSUvY0lFUwWWIpyfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729398; c=relaxed/simple;
	bh=tApPpTDpzWHbB1pWe+VsiMG5gGDF6f3x7Nan38A1rbo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LPpP934dtEiznCfjh39xeEuSD8WPW++ANZgPS8jnuiWjAWsGO15fbMv/6XxnG9RLJu7WQ369G2HL++oI0PEN3gyG/0+4m0SHzGaENE5DeQkA0+aIpGtHtf9fxYH8Q5UaVM+Tgup8SmHETkYSg2hbMN5fYGMcdVVQKW6MtPX8npI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=DTCU4fKT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="DTCU4fKT"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81dab89f286so762932b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 15:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769729396; x=1770334196; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tApPpTDpzWHbB1pWe+VsiMG5gGDF6f3x7Nan38A1rbo=;
        b=DTCU4fKTTkBJVk0rl0M0yDldZu+5uj0u7VonTLzBtXktv4WH0jS4bteu1I2eRXhcSo
         9w87JWRxr99O2sedgFUsTqjZlpZ4i4jBhPFN9o1AqzDAkjqIeo9VIW7VC5SwX7uRY4nu
         brzxBnQjssYZl1d9gEz3l4S0pz9AxLEZsLbMHOIUwWDHkgwXz89UgFYbXkxKOEhzhNQ4
         PP5L1xFIx47MhpAxVgyD+uEiCIx/RHZosY3C6rWQfkydmlbkKeI8OgG9FvFZHosi4/AV
         f1U1E7BT8r9AIH2T+ShL7nppyQjSu+LCMcXbZ5m0Tla6VSS7+iTxUXS1Cd+eY2fY+Fxt
         KRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729396; x=1770334196;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tApPpTDpzWHbB1pWe+VsiMG5gGDF6f3x7Nan38A1rbo=;
        b=LxWDSBuHRYKrXfjXm4HQUn8xGfMMqvznsZJHNAUmEOrGFqfJ0A4ruaZGHZ7T4rF8Qu
         1C73ouP9dA/LaVV19EWWost3mIXuYjRsClFglV4MhS8B4cTrOUMnBxBTxmNQ4Y9/DbKz
         7oaqRlfaUM7K+rYNm7hQ4dx5Fmn26jCDVgKUrP5n0CObyf53huLcgIwNpOmEw87VjsQl
         LuHN6JmJRtC+q7GGln//SWux8e7gvB+Ex74o5xy20f2EAMScwzhv9417N2nbVLqb0EJy
         CmaiOFycOuft+AWlTZGFDhE1o62FIVbWisQuzMgtRqcm+Wjj/w0bdsNFlui/A7tY105k
         Ymkg==
X-Forwarded-Encrypted: i=1; AJvYcCVMgKcqYa7+49B6VJNBhxBU8TVdtt58frUaL3nObOJyI5X9AGp+4h62aStS+KRb+SjTnrDLjiudOQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XHSHUjWfUMoMQG9b94jEklZCaDXbS3pbydQPGXLJinHdWWkc
	rfkgR7HUXRWbEAwEYwpWU8N6Pol5plR8xob6oNAx+whxOnJRQ9CcjgcbwYKPCyfedmM=
X-Gm-Gg: AZuq6aLse0Lbql//mtt0iBVWvyd38CEhjgeuUCpOrzj47IVrFogPdaVWf+UVUFvFTWk
	TiSFTJGwH7V9ijTYP12vensjfsH6TgdmuTBaazAjA7ax/RL2lj+DOA88sjnffpWsIwW6R6xeiSr
	FOHlZRoZnKJwx2nRoLwIknpbhzfMqVYa+78PrO+4wtY5D4Yey67Qi0yfoYY4YEW/pNiRrre6xao
	SUrXGz8PveUyGdgw0tttYEYjWoIZsWmHq0oIrMdRc9Om+704LZVlbTQqhmRtBTS2MGlV1Ylj/Q+
	TvMFI7kJSQIeZnqQD8/PAwLlCqlVMU3CHNBUiqEgS/miIhuVc8krnOKsKJUXEnBUDs+MzW4zuGX
	DN9MBDmQGksgeKrcxXbtxFJImJzhwxkgaTlN3OqSXv9au4DmlDV3h3hh0iAYl4zWUyFA/xa5JJz
	Z2vrrDU/tQIcclqiO3KN4lqGXFe+v13rigPuP2jRnQUy05jX/GQgL6A6KaL3FzF3ly0O+LK5Q=
X-Received: by 2002:a05:6a00:7584:b0:81b:13c5:b6b2 with SMTP id d2e1a72fcca58-823aa71186emr720685b3a.33.1769729396526;
        Thu, 29 Jan 2026 15:29:56 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c64b4esm6363964b3a.69.2026.01.29.15.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 15:29:56 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF
 systems
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
Date: Thu, 29 Jan 2026 15:29:45 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2428D892-89F9-4013-9681-AD9BD76B0874@nexthop.ai>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>
 <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 29, 2026, at 2:43=E2=80=AFPM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
> On Thu, Jan 29, 2026 at 09:43:13PM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>=20
>> The xiic driver supports operation without explicit clock =
configuration
>> when clocks cannot be specified via firmware, such as on ACPI-based
>> systems.
>=20
> Are you saying it is technically impossible to specify a clock in
> ACPI?
>=20
> Maybe a more accurate would be:
>=20
> The xiic driver supports operation without explicit clock
> configuration when the clocks are not specified via firmware, such as
> when the ACPI tables are missing the description of the clocks.
>=20
> Andrew

Actually, ACPI (since 6.5) added a ClockInput() macro that can be added =
to
_CRS of a device node. The ACPI subsystem in kernel could parse these =
and
convert into proper clocks integrated with the CCF. But, AFAIK, this =
idea was
rejected in the past. So, technically, it's the kernel that lacks =
support on
ACPI systems.

What about this wording then:

The xiic driver supports operation without explicit clock configuration =
when
the clocks specified via firmware are ignored, such as on ACPI systems.

Abdurrahman=
