Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29850EBF3;
	Wed, 14 Oct 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982585; cv=none; b=YaovkgF+dkRuYEih4PFNcw3FOwJftZTHa5ZxKYa2FIBjHqbyI68XiqInd9K0zrag4B6aNr1zUJtN4i+xG+MU34GGScv9EMEd1W5RXBXyZjuggTMKliDO5SUd0WnFBV0gdW3qxwNtdYZSehOXpUBF2b7my6PgUHBVlk+Gvqlg6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982585; c=relaxed/simple;
	bh=0rzUkjA9MKJ7hL3UhY5pTI85iAUyvsSOjkB7DsBQ770=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjrB13M2V0C+IvVZsq0akHDOrL6f67x+sONk4VrRG0ZppHssv/RCVylk6khU4O1izmZhXdGvlY50nDQ0EmFi64qNAoHAQfJiLlTKH5Q8+zqB+2tjL09Bj+xoI6RQWPlHlI844pLdE1pZQdeV2yvbMsPfDjECqNwKIcm68s2vc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie; spf=pass smtp.mailfrom=nxsw.ie; dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b=RXkdR/u5; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b="RXkdR/u5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
	s=protonmail2; t=1791982565; x=1792241765;
	bh=0rzUkjA9MKJ7hL3UhY5pTI85iAUyvsSOjkB7DsBQ770=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RXkdR/u5vzzFjCwdNnWdQwPMNzwGjVhWLsTkogkcOUzU4QxomN58mCoaK2j+RK1hD
	 VQCJMt3GK0mX5D+UjOCsKuf48fa9+L1WuVYhIO7a5y0pFxrBF30PKzaOVYpLOmx5x0
	 s90dJBry0+UnmZjbjga0imWChJqeRZ49f4E375y5I8yIPxcDMDBzD+gBtuup/kwez3
	 L6Xo0xGY1A5LN7r9EuYDhTAguLGJDUSw629u3ZE1QEdrGzZ0q3N+1Yune5N4h57I7G
	 dpej8keIjVry9Jg+Mx4u6A15a3veFVJvFz0Ipom46GDXWwA5ypXP5YkPIwFmsocAaQ
	 KHekHHKksDjJQ==
Date: Wed, 14 Oct 2026 12:55:59 +0000
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] i2c: qcom-cci: Handle and report queue overflow/underflow interrupts
Message-ID: <d061f3d2-a8a7-470c-bc56-1707aeda7de5@nxsw.ie>
In-Reply-To: <20261013-cci-imp-v2-2-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com> <20261013-cci-imp-v2-2-6873326b44a3@oss.qualcomm.com>
Feedback-ID: 136405006:user:proton
X-Pm-Message-ID: 4e31949e58f6491d92d00b2b8aec5d5ea1bc4afe
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/10/2026 11:30, Loic Poulain wrote:
> CCI_IRQ_STATUS_0_I2C_Mx_ERROR aggregates the per-queue overflow and
> underflow bits together with NACK_ERR, and all of them were
> handled the same way: report -EIO and halt the queue. There was no
> way to tell a NACK apart from a FIFO overflow/underflow in the logs.
>=20
> Decode the individual overflow/underflow bits for each queue and
> report them with dev_warn_ratelimited() as such errors are not
> expected in normal operation.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

