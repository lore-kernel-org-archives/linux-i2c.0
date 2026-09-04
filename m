Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB863DB310;
	Fri,  4 Sep 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500701; cv=none; b=EyAQQiz5CdnUbuQ+XB1KrwyVXhe3iE8nqjMdfq9j1HeXvurWurXCNFFeF0poRiQsnhwW22C6+ZwF24V4KSgaD4AgAb7KZfG0/HaC+CRpvBm/be29k3W7BZSuT0KjmFBelfmpBusp2sLY6es7Au6tZyl3I1dWAfEmVFq0JKzlBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500701; c=relaxed/simple;
	bh=uvbbaRl6WbdSj+UBVIkoYBrEGPtW6lTAqtjw/OpF7bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjErBLZRuNns5gHMEAs04NKHHyC8086W5dOp8L5lxh+ycYATjxmpySIWWODTgS8A+xIGY7tSfcCyOxQp/xOopD03IyBsKLa7uWsMN2u2UJPo6YYD7id1kPuy5K+YOFDBDsHL6FwH5AwO9UlcaU3Rz6Qsx3RU+nP0dy+DwPnyHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=lZ9DLtWk; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="lZ9DLtWk"
X-UUID: bde2f9a6a82311f191248d90cf864ef8-20260904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=BJWK7y7J1Xf4mlM9usDq6JWqSNyQR44PYQ93laQjlm8=;
	b=lZ9DLtWkqYEGju8ag8q/9u+Okfag4Mh0TouHEMuJuDBAwrFngfwOe5nkG5JkXgpC4slT1zccNG+Sjjj7xnWSH8HJWuMJWz416fgMEe8xjRzmVXzjnmi+E7cYqT2l8CYxW+G81pQ8vNq+FIAjnbNYyuw5tyw6aSxBPZz/FUAog+Q=;
X-UUID: bde2f9a6a82311f191248d90cf864ef8-20260904
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1721376416; Fri, 04 Sep 2026 13:44:48 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id D2FAD1A1E1C;
	Fri,  4 Sep 2026 13:44:48 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 586F0C600DD; Fri,  4 Sep 2026 13:44:48 +0800 (CST)
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
Date: Fri,  4 Sep 2026 13:40:25 +0800
Message-Id: <20260904054024.35245-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260903160434.GA3629759-robh@kernel.org>
References: <20260903160434.GA3629759-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Hi,

Thanks for the review.

On Friday, September 4, 2026 12:05 AM, Rob Herring <robh@kernel.org> wrote:
>> +description:
>> +  Novatek NT72676 SoC provides two I2C controller variants, generic I2C and
>> +  STBC I2C.
>
> blank line between paragraphs and you need a '>' modifier on 
> 'description'.

I will change the top-level description to use the folded block style and
add blank lines between paragraphs.

>> +  The generic I2C controllers are accessible only by the host CPU and driven
>> +  by a 96 MHz AHB clock.
>> +  On the other hand, the STBC I2C controllers can be controlled by either the
>> +  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
>> +  driven by a 12 MHz STBC clock. Authentication with STBC is required before
>> +  the host CPU can access the STBC I2C controller registers.
>
> Is the programming model of the I2C controller different? If not, the 
> compatible should be the same.

The register layout and transfer programming model are the same, but these
are separate physical IP blocks with different hardware integration. They
have different interrupt sources and input clocks, and the STBC instance
requires an authentication and ownership-switch sequence before its
registers can be accessed by the host CPU. These differences are fixed
properties of the two IP blocks, so separate compatible strings are used.

>> +  novatek,stbc-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the STBC system controller registers used to authenticate
>> +      host access and switch ownership of the STBC I2C controller.
>
> Sounds like this could be modelled as a hwlock? That's other platforms 
> mediate access to shared h/w. We really only want to have these syscon 
> phandles as a last resort.

The ownership mechanism is a one-time switch rather than a hardware lock.
The presence of the STBC I2C node in the Device Tree means that the
controller is assigned to the host CPU. The driver authenticates and switches
ownership during initialization, after which the controller remains under
host CPU control. The STBC does not access the controller concurrently, and
there is no runtime acquire/release or lock arbitration. Therefore, the
generic hwlock binding does not match this hardware mechanism.
 
I will update the binding description to make these hardware characteristics
explicit.

Sincerely,
Ben Huang
