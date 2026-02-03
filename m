Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBC352942
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143945; cv=none; b=AFU5PhhBPVwnaY6nTY3tomqO5nscLlNXq4Rk66P3vHHdvFniPjFa0zrW8eNuKExIyR8Q6Wqjt/v+Svj/7G8vUhsrNajVYosjZ7129cUV0OpbZYznhrUAIfa2hC2iN927DAXJHeKz5QVFW2fEFYdczZRua6HTM53HminZt3g89ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143945; c=relaxed/simple;
	bh=S7ZwS6nHEpnT2Ed8O6Wsq8QnI7o0iZGRuFsNLUgRsT8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ObNWCxp5LRXU+DvFx4evoIE9+6nVl50pKAwP4qGXCmVP4+1YQ4kYKAzrO2R90dIalIZlhbmajnWDptO9J4CCgwYZgHCMZN7NssMhiBv1mQ7PVy+Er3WuLfQ4lxhEHSDRP0eX8HVJjgd7WOY0gSRPArcvs+MkuLmzHBi0GKDZwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=IdG09KtF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="IdG09KtF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823c56765fdso2068723b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770143943; x=1770748743; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7ZwS6nHEpnT2Ed8O6Wsq8QnI7o0iZGRuFsNLUgRsT8=;
        b=IdG09KtFcRQnjRTSJ9PzGTYmsZcuyq8t9eXORTya3ef+pFSv5lE6U3F+mfKM8ou1Ey
         kH8Eu5EBBqtxWmmA4nrlzmQXgW/1eCxbJpgi/bGxO8PT9nhL6osmOiTFZRqtpFqmnYKM
         J4M8VdSV1JkklKnTWYAtihIqFLF74HhAYt6QkMSWYyBHOloS4W+EwZVddu5tAReqJ9qV
         Jjvi82p5i3XDmIY60tI9W+KwGxpSaeUGnfL9h99j8hhKtun1+KfL7tFJkdNZbkn9/4u8
         zM2fIZa1S/9jdSoJLJBHr0tuFkLGL0y1I+vNJyrVImYT/kNXzZ8V3OInVsmLMXv+MS2G
         6flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143943; x=1770748743;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7ZwS6nHEpnT2Ed8O6Wsq8QnI7o0iZGRuFsNLUgRsT8=;
        b=Cdqy7J5MtH5z/f3jX85THrQh/4sVgB7s8ZzOop5X9cIpY6pq6WLOge37FpQsmrh5KY
         fui2WDe6Pm+WDMersn6+UhZkSYhcd1jA5E8f48Zn8EU4ZC19ple8X4lgsLHQtSU0MvkC
         yPMc86yAGOMQ2dMZu9X7ehEkThxeNuzaZ/SJLk4KTuvWE3/rMhXlqbL9o56bLB+ZnlAK
         XWDe0Fd2H6S0cFwM7b0hZbtCXo56pPJZQ9AyAZass6dHuk1jqgWIf0YaUzSgP9MGiijs
         TPIcXHfE0TtODPEZsC358rtpZZ8pXmwUzdWt/vBRwNG+rtV7rZPA8/kLCEii+eIps6mu
         TZOw==
X-Forwarded-Encrypted: i=1; AJvYcCUR+aOfNCIpdadVeUqeqhlfsn8epvuKutJe2URhr/wkxjhW9xLvNOZK8C45yUwyQ2dtRffVZASjryk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkVHyRl0rPMst8ULqkSaiF5gDV9Q6cqRm99e4ZIEbb9HKZY2T
	0OahGh8iv98T9CQUHbxNZ/unOB866GPgp/elyJZWoSllkaw40wmWrusdfeSD1RbGrlfEftGWb5N
	Q8fKH
X-Gm-Gg: AZuq6aLHir1U06TrbKMNSpks6P4bboDFvEVYMQSlTV+rssFGryDMHpXCNnLR8DQiUd5
	iQbdQt1KwbkobsGwuS2pE9R2bSTiUS06VirnXfViTd/XmnNEMJt71MubuH7EdfPxnhsj83zjgOS
	7B63kIZgVc/5086xJDgHq+GxglglaYHAe8fJ7TJdBFpefS2G47enD2aeLtfzQAhAh2NZp1YRZUn
	3G5gZhXbo8pSscv11LcXavllBjSDp5z7YCuM0K4GDpZ4M5dx5tS8EJL7ZJEcsdiCxTQYjx3SVie
	4Wh1iGKUiFWjgbJz73kdQZToe8la4iv87zpdq2dB/L3nXEjGKD2vw1RiOsM/WQa4nVcZxsgpfGz
	VyYC+AVvTrAL42Gq9MEzoYCrnYdcQ9YBbfUA8yoAubZJTZcn/eflauWhCn3kYd/WVuC2p9V8VrI
	9x2jNPio5MeIWhdYDYOclvADpsulDnP3j/b0nRsRUIyNEmlEEUW4togf8R
X-Received: by 2002:a05:6a00:1148:b0:81f:9c39:14f3 with SMTP id d2e1a72fcca58-8241c5f6390mr296399b3a.42.1770143943444;
        Tue, 03 Feb 2026 10:39:03 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d47a418sm68996b3a.53.2026.02.03.10.39.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:39:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <aYIYUNejGCVdekx7@smile.fi.intel.com>
Date: Tue, 3 Feb 2026 10:38:51 -0800
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
Message-Id: <9F7815FA-80D8-4C96-B61F-5CA6CB405F7A@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-7-ce4695f5267d@nexthop.ai>
 <aYIYUNejGCVdekx7@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 7:46=E2=80=AFAM, Andy Shevchenko =
<andriy.shevchenko@intel.com> wrote:
>=20
> On Mon, Feb 02, 2026 at 08:37:24PM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>=20
>> Currently Linux does not implement ACPI ClockInput to describe clock
>=20
> ClockInput() resource
>=20
>> resources, unlike DT. However the xiic driver is happy if something
>> magically enables the clock before the driver probes, and does not
>> turn it off again. The clock should always be considered optional for
>> ACPI.
>=20

I just used the wording provided earlier by Andrew verbatim. But can =
change
to the following if you insist:

Currently Linux does not implement ACPI ClockInput() resource to =
describe
clocks, unlike DT. However the xiic driver is happy if something
magically enables the clock before the driver probes, and does not
turn it off again. The clock should always be considered optional for
ACPI.

> ...
>=20
>> + if (is_of_node(dev_fwnode(dev))) {
>> + i2c->clk =3D devm_clk_get_enabled(dev, NULL);
>> + if (IS_ERR(i2c->clk))
>> + return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
>=20
> Haven't you seen my previous comments? Why 'pdev=E2=80=99?
>=20
Sorry, I missed it. Will fix in V10.

>> + "failed to enable input clock.\n");
>> + }
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

