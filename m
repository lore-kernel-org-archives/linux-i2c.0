Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E94071F3
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433860; cv=none; b=CV4J8VPgUQSgd70V4wUauHhPVB+0XlYXGRepzLBS60LGuQnWCAjiqpvUjjhpal5D6WaIjtshU5xV35jZylw979G9cTbe+OQK/ku2VwGifsKangZGhW7hQuPc4vuCVyIBfLfLh2+lJ1jUfLCC6X+0rCysROrshddxcqcSjVxwaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433860; c=relaxed/simple;
	bh=UMw6VZEzWAWIh3tsa4Rn0DyfCSwUJ6WFV4XQ7X/U0KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRcQqxm0KnxmrUytTtHq1g1mftI0LuEM9wj2/UirtegJRnXcmU/t9mtbS0w3h5z3fgXhJU7dyCvTPds3SsFuhkVFH3GytApe3ry5sXFqq8L3TQzDUXztxJOAT+gPANQUpQCBc5dE4c5QzD5+ApUCHAZswY8qlt9lm6T6J3Vp9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VnK2AAoe; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VnK2AAoe"
Received: from [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905] ([10.65.86.58])
	by smtp.orange.fr with ESMTP
	id th3Bw91gEFIYEth3BwxYNJ; Tue, 11 Aug 2026 09:37:29 +0200
Received: from [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
 ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
	by smtp.orange.fr with ESMTPSA
	id th2vwU4tTgBE0th2ww8Cgs; Tue, 11 Aug 2026 09:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1786433842;
	bh=wwfnzUnBo6SSbPICFQmZ3w/vYTc+O/42eMBYe7UVmyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VnK2AAoei/+Qpsxu0/VpScQ9D/dfdJT+4VvJxz5Qzx1i9rHwm4J9G+RDbIrHK/xSs
	 yKHt16MiVbf++4Ts/JaPGl7oy9kD/CzRjVvZXIYh9+vfIgoVCA3LF/4z5sqP18xU3H
	 X0xmDI/UGsidkq8+dwSesyhdvzdKXybQ4n4oLNRPjVTcFyOJaseLSFo3OPIZsGlppE
	 vWtJ5r3XftvBmW0zVOuhVt8bY5cX+ZF21Xjnhl8Ol7iQEIs7HgmbrwzYIOYUPBRoBz
	 mPXbIydUrrveJ3dj8jNintr3LqP9nyrF/WYtwbObTfZcYLUtwhHtd2aCo8dXyJ4D6C
	 s6GTZ8ooXgu6g==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Aug 2026 09:37:22 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
Message-ID: <361b7fa5-0e4c-429a-ad66-c81fbee86c45@wanadoo.fr>
Date: Tue, 11 Aug 2026 09:37:12 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] i2c: add Andes I2C driver support
To: ben717@andestech.com, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
 <20260811-atciic100-v5-2-1d306c21dba3@andestech.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20260811-atciic100-v5-2-1d306c21dba3@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/08/2026 à 08:29, Ben Zong-You Xie via B4 Relay a écrit :
> From: Ben Zong-You Xie <ben717@andestech.com>
> 
> Add support for Andes I2C driver. Andes I2C can act as either a
> controller or a target, depending on the control register settings. Now,
> we only support controller mode.
> 
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>

Hi

...

> +static struct i2c_algorithm andes_i2c_algo = {

Could this be const?

> +	.xfer = andes_i2c_xfer,
> +	.functionality = andes_i2c_func,
> +};
CJ
