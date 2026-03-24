Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAE3F8E0E;
	Tue, 24 Mar 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366248; cv=none; b=mo504Eviv29PcgnEuT4N7bveEPM/NbAcN3KO9klIgM5csTWTbE+7lO56R2vMHoReo7MLHIs0k3aoIbH1tdgttbnRIJGh/9cP5boJgOOCA5Vp/+57vzF8A0M4w4xz56EYGWTFrRkID5iePShB/RxbiftuL0zRTK1IUciJlG9KrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366248; c=relaxed/simple;
	bh=c5qZrqum6694nrzOJ/PimVl9LdaNvtxdc/OgwxKyDJ0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qdWrsIDmFNAMlsgCe8rBIZFGxTM+5UQxHSU5DcIImowWNkcth99+Lug8IJ0cVt+6WwtBvOX6KhjhzRSp7KHseoLg6fKOmI6D8GEYHp4W4L20FJ52qJX8O+N8zP4+Xd44gvRKLxyM4G8TNIWP3Zkf1NFxeI/IMY3ij5nj3fNv0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OQ8GoRe4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OQ8GoRe4"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D6E9527225;
	Tue, 24 Mar 2026 16:30:36 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eiBq1DAL3Mhh; Tue, 24 Mar 2026 16:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774366236; bh=c5qZrqum6694nrzOJ/PimVl9LdaNvtxdc/OgwxKyDJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OQ8GoRe4YdT9bwF9x2lscG5GlDfw9yO/I8fIUUUjeqSYMad3iWvw/zgu2ehP1KmiM
	 C7WuTWS4cjHMCAp7R6G4q3hGdpfFvds7lrRtQTWMSVlqqxbGSPRLiWJ3aEzNtMZr4v
	 NzOt6B5ko3NT0axEY3vOdz2uL4wHiYvr41ikPXRUAqouuz32MfIDctVW43hprlnrXV
	 ijiHIV4eA2eiVK0/G2y6j/Dg84S9hJE3zv1k0KRiWpGcNQcuAOf62xhRFiqxv7hw8Z
	 PZowYIv0xNZPl22hcr/kq4Dpbgli5bBpDo6TgpVHU7FrU67hmoh6kPs6DHCg6IeK4g
	 Op8FeeDSEHW6Q==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Mar 2026 15:30:34 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 clocks and RTL9607C support
In-Reply-To: <20260323-stash-contend-ea5974195eac@spud>
References: <20260323071337.15410-1-adilov@disroot.org>
 <20260323071337.15410-6-adilov@disroot.org>
 <20260323-stash-contend-ea5974195eac@spud>
Message-ID: <be24b1e5651ba3a059cefdbbee361ed7@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,
On 2026-03-23 19:41, Conor Dooley wrote:
> On Mon, Mar 23, 2026 at 12:13:34PM +0500, Rustam Adilov wrote:
>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>> RTL9607C SoC series.
>> 
>> Add a clocks property to the properties to describe the i2c reference
>> clock and make it available for all the compatibles. This i2c reference
> 
> Why? I can see that you're doing that, and it's good to know that that
> is intentional, but why is it being done? Need to explain that all of
> these devices actually do have this clock etc.

As far as available information goes, there are some datasheets that note
the existence of these clocks. For example, RTL9310 Developer Guide 1.0 in [1]
mentions "I2C master support 12 peripherals with 2 clocks" at page 19.

And RTL9607 calculates the clk_div with this equation found in Realtek SDK code

data = (62500 / clock) - 1;

where clock is clock frequency in kHz and so the 62500 must be the clock frequency
of the i2c master controller clock in kHz. And since there are 2 i2c controllers,
there are 2 clocks.

That is also the reason why it the rtl9607 is the only one to require the clocks to
be specified and also why the clocks property was added at all.

That's how the rtl9607 i2c controller would look like

i2cclock: i2cclock {
	#clock-cells = <0>;
	compatible = "fixed-clock";

	/* 62.5 MHz */
	clock-frequency = <62500000>;
};

i2c@b4 {
	compatible = "realtek,rtl9607-i2c";
	reg = <0xb4 0x4>;
	#address-cells = <1>;
	#size-cells = <0>;

	clocks = <&i2cclock>;
	realtek,scl = <0>;

	i2c@0 {
		reg = <0>;
		#address-cells = <1>;
		#size-cells = <0>;
	};
};

I hope this explains the whole intention behind it. And if there is better way to explain
this in the commit message, let me know.

[1] - https://github.com/plappermaul/realtek-doc/tree/main/datasheets

Best,
Rustam
