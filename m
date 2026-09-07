Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A61DB92C;
	Mon,  7 Sep 2026 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788757387; cv=none; b=D2qM3xMtKemuv+ncUOSSdAVVgwDCoeEWwSetOa6aq+tl/E5so9E3NJVAni8e3Q2z3NyxErVxkS6ZJ8XXqSovJz5kk/NewFkEBsWzlcCvlgELriBY7KN5STPEELwInK7q5+CByoDdl/zn9AH7PRugLVha7p1n9cJOwdNN6QanMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788757387; c=relaxed/simple;
	bh=e2bL8wrKF0ciA3PdpUk7ZZ5XQEea/xPl7BZgsahz/P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQg8lj2T4x+cOQmdtDlvlo8itYUnf38R8HxtxUiKIDvztas4Jqk7HsHoqTq1Aoscx6K78veeB+Lz9f1CawTrwrMJPavbbC1KcfQ5kBc1APstG5U0Pl1ZUfkifE1KXe5WR68IiZaO1D2hCugoB9kpVGZa6y+e9JnqsJn4OymsMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=GJxfaddS; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="GJxfaddS"
X-UUID: 6323b21eaa7911f191248d90cf864ef8-20260907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Iir+n2D6ZMzGxf47xJFqT4i3L3klFpl0eKQcraJvp4o=;
	b=GJxfaddSwvgXFhbKgh0iMS8MqWFNEd5pBV0kJZnEGdxu9yLmkN1TTqqKsCG7wZTdSiVrvCSsTGItYveiR5GX7ei4nCV/8/zv/1CVGA5WS90qG40cmCt4kE0c6hpReitGwvimCNKbCOcYM/3hkXVnVsDYSF/jI3J2u3CCDaYxAFg=;
X-UUID: 6323b21eaa7911f191248d90cf864ef8-20260907
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 400059417; Mon, 07 Sep 2026 13:02:55 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id 944821A1E1C;
	Mon,  7 Sep 2026 13:02:55 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 46FE7C600DD; Mon,  7 Sep 2026 13:02:55 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: robh@kernel.org
Cc: andi.shyti@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v8 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Mon,  7 Sep 2026 13:02:38 +0800
Message-Id: <20260907050237.103430-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260904134834.GA3514178-robh@kernel.org>
References: <20260904134834.GA3514178-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi,

On Friday, September 4, 2026 12:05 AM, Rob Herring <robh@kernel.org> wrote:
>> >> +  The generic I2C controllers are accessible only by the host CPU and driven
>> >> +  by a 96 MHz AHB clock.
>> >> +  On the other hand, the STBC I2C controllers can be controlled by either the
>> >> +  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
>> >> +  driven by a 12 MHz STBC clock. Authentication with STBC is required before
>> >> +  the host CPU can access the STBC I2C controller registers.
>> >
>> > Is the programming model of the I2C controller different? If not, the 
>> > compatible should be the same.
>> 
>> The register layout and transfer programming model are the same, but these
>> are separate physical IP blocks with different hardware integration. They
>> have different interrupt sources and input clocks, and the STBC instance
>> requires an authentication and ownership-switch sequence before its
>> registers can be accessed by the host CPU. These differences are fixed
>> properties of the two IP blocks, so separate compatible strings are used.
>
> Different interrupts and clocks is every IP block. That's why we have 
> 'interrupts' and 'clocks' properties.
>
> For ownership switch, that can be based on having the 
> novatek,stbc-syscon property or not.

Understood.

I will use the same compatible string "novatek,nt72676-i2c" for both
instances and identify the STBC instance by the presence of
novatek,stbc-syscon.

There is currently no NT72676-specific clock-controller driver in the
kernel. Since the input clocks are fixed-rate hardware inputs, I will
describe them using generic fixed-clock providers in the Device Tree. The
I2C driver will obtain the input clock through the common clock framework
and use clk_get_rate() when calculating the I2C clock divider, rather than
selecting a compatible-specific fixed rate.

Sincerely,
Ben Huang
