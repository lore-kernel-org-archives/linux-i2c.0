Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44438B12A;
	Wed, 22 Jul 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687334; cv=none; b=eF73cGHVgjJ29R5nYVHGwlk2/K596KjKVe+0v5bFEFj8rgCdeAEYa91j2iw37HROQgwfVUFved1Zqg7bvvbLrU41t8Y2CoOq5P+ju0HQgpQEupR00wSXQWUe2t4sKWIfkZ2/EkqtVGxV9e8n4TutiiyokabMhA5cxQuefEOW7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687334; c=relaxed/simple;
	bh=vSwlLyH7MxXrsymiSVrYYbaszhfNZVMmRoJnyjSzYSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7ttjBJoPyl2St5o20rBumfqT7e4DoFA+vEZjtwYWgEr1G3PXegybnbCjyMFb05WfPDnqYqpyOz2riZvnP3Z0SG6fqRujEXSQD5DpF/HaTaulzmo1X8nVPm7NaIvvnf7Q3QGnEF4jeIeum1Cyz0ovcRK4Xav09Q/wMeAzmBX/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=l2IBitLp; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="l2IBitLp"
X-UUID: 110590b6857511f1b694ffd7d3467620-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=2h712DMChFjZWMR4kWb+1FfRZXhHQis6JC7ByoPZDYI=;
	b=l2IBitLpfoOSKs9KuvX4yCFvMx9gDyZsQoJ6fOW5CcFnqzk3EZj273fwlqlo0kEANqjrfYHRHy+jtG1UwBEjebh+/5usQoBEXzCvPQAX+dUfvhgnOEUBMZ3q9UWec3RGLE0zJ1jSkL5TTYBVg1y2ozHCZSiD1UOk7ZjVj5f1huY=;
X-UUID: 110590b6857511f1b694ffd7d3467620-20260722
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 234666685; Wed, 22 Jul 2026 10:28:46 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id CEC411A1E1C;
	Wed, 22 Jul 2026 10:28:46 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 94123C600CC; Wed, 22 Jul 2026 10:28:45 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: krzk@kernel.org
Cc: andi.shyti@kernel.org,
	ben_huang@novatek.com.tw,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c: Add Novatek NT726xx SoC I2C controller
Date: Wed, 22 Jul 2026 10:22:52 +0800
Message-Id: <20260722022251.525999-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260721-notorious-flexible-uakari-ba8e0c@quoll>
References: <20260721-notorious-flexible-uakari-ba8e0c@quoll>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Tue, July 21, 2026 at 3:10 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Jul 15, 2026 at 03:35:21PM +0800, Nina_Kuo@novatek.com.tw wrote:
>>  
>> diff --git a/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
>> new file mode 100644
>> index 000000000000..866589c5ae51
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 
> Filename must match compatible.

Compatible shall be "novatek,nt726xx-i2c" for common i2c use of Novatek
NT726xx SoC platforms. Modify on next submission.

>
>> +
>> +maintainers:
>> +  - Ben Huang <ben_huang@novatek.com.tw>
>> +  - Jason JJ Wu <jason_jj_wu@novatek.com.tw>
>
> Why are you changing the order of entries in the schema file? Do not
> come with own style. Please read and follow writing-bindings and
> example-schema.

The order of title and maintainers will be corrected on next
submission.

>
>> +
>> +title: Novatek NT726xx Series SoC I2C master controller
>
> So 726xx or 72600? Confusing.

726xx is proper for common i2c use of Novatek NT726xx SoC platforms.

>
>> +  novatek,hwmods:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Name of each i2c pin, must be named with "i2cX". (X is
>> +                 an integer starting from 0, must be unique)
>
> I do not understand the purpose of this property. How in one string can
> you name each pin? And why would even need to name each pin - why would
> that be a board setup? Pins have FIXED names.
>
> Drop property.

This property is to determine the number of i2c adapter (nr).
I will evaluate any alternatives to this property.

>
>> +
>> +  novatek,stbc-controllable:
>> +    type: boolean
>> +    description: Set if this i2c master, named as `stbc-i2c`, is
>> +      controllable by stbc (Standby controller, actually is an 8051
>> +      micro-processor) on Novatek NT726xx SoCs.
>> +      For these `stbc-i2c`s, the driven clock is only 12 MHz and the
>> +      authentication to stbc must be executed before controlling the
>> +      registers.
>
> Compatible implies that, drop.

Additional compatible "novatek,nt726xx-i2c-stbc" will be applied for
i2c master controllable by the standby controller (stbc-i2c).

>
>> +
>> +    default: 0
>
> Don't vibe code stuff.

This will be removed as moving stbc-i2c to compatible.

>
>> +examples:
>> +  - |
>> +    i2c0: i2c@10000000 {
>
> Drop label

Label will be removed on next submission.

>
>> +      compatible = "novatek,nt72600-i2c";
>> +      reg = <0x0 0x10000000 0x0 0x100>;
>> +      interrupts = <0 67 4>;
>
> Use proper defines.

Below will be applied to examples on next submission:

#include <dt-bindings/interrupt-controller/arm-gic.h>

Interrupt type: 0 => GIC_SPI
Interrupt number: 67 (normal i2c), 77 (stbc-i2c)
Flags: 4 => IRQ_TYPE_LEVEL_HIGH

>
>> +      clock-frequency = <400000>;
>> +      novatek,hwmods = "i2c0";
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +    };
>> +
>> +    stbc-i2c1: i2c@20000000 {
>
> Drop example, almost the same, so pretty pointless.

This example will be modified for stbc-i2c instance on next submission.

Sincerely,
Ben Huang
