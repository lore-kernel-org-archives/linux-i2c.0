Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848136;
	b=sL0e7BYvddlhUtfjWLoXcfPcYiLlrXnDhoET1iSnGcJwi/Kx4vhdjwTBwXJADlOrAn4L
	 LjUGnnTV2cuwJ6hLM5GSw8+SvFTcW8pQrnfRzNtfT2FG3JiJOqX0hkB1xMuw9TPWGwJ2R
	 k5hpc8ldAnP6n7gbqS7fnpUDNcYhRu7V3hTdccOh/bHj02+Z7im8RmJQRNVVzaVY8NYjI
	 03JiyqAN3jNOYDfLFP/LHFflBO2peO5ctpzQwpUsAhjNqrq/gy1k1Aw5wAAtu09X0NiQu
	 VooMEuzD0td6JmrtvKY+cBhIKU8VAv3f1rGa8Tq5rA6Vi91+068sAE209qagPOMUjDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848136;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vuMOrMNlsDeXB/gOpGoVTc30nETCHnPARKydNa9wPb8=;
	b=hTbH21ekDxQzFFCg03vT74dwBdJnLf33hcn32pYpB5aQyNQ8jD8yGkqu1G+7cFcUyj7x
	 pV+EAIU0AfkcH/ozMe5Zqf886Q8xNC6Ed0Vd+3maTW6O/3bu8liHXGfs7VrixkhMSq+fW
	 Er3BScRcFppUuFOq2g3da2REJe+b3jNQ/70YvQmZmNlxEG8jIXOA1nw2SRoNWd9+LpuYa
	 QyyJaBatyUhGO8jj8+H0gVLKy4L5mBKICLY6Eo+IBiU7G4cn9YgoqBv0mqUNq1VGMSPXV
	 fpGVo76pilsjjVhzKD+2yV32kPsyogpYANq6MJs/kZe8j4NQLm9xzRnC5W4wDtItNrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nG1zv4un;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EA606A33D;
	Thu,  5 Nov 2026 03:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 188EA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nG1zv4un
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
	MIME-Version; bh=vuMOrMNlsDeXB/gOpGoVTc30nETCHnPARKydNa9wPb8=;
	b=nG1zv4uns5j1SF7EQQHL4A81sYee6mgvz28McBXq/nZTsB6X7wEk4TY6igfzBO
	U15191s2WTw2n8N/X9eXGwnHw13C/chkLVwEjzKUluQzq7vV4D+2PFpFuVQwjSmy
	tv6ocGVDFy4cfDjuGIRTPdeCA3i8HrvyANnyt+IpQNFp4=
From: Wentao Liang <wentao_liang_g@163.com>
To: Alexey Charkov <alchark@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@prisktech.co.nz, wsa@kernel.org, wentao_liang_g@163.com
Subject: Re: [PATCH 04/20] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Date: Thu, 05 Nov 2026 03:08:21 -0000
Message-ID: <179384810127.1670076.13427386991396484928@163.com>
In-Reply-To: 
 <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>
References: <20260916070631.1965713-1-vulab@iscas.ac.cn>
 <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:_____wD3j8wt8+tq+C_JFA--.4408S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5GFyrJr4fJw4DKw1fCrg_yoW8ZF4Upa
	9YgFyYyanrAFySkws2va17Zr18urWxKF45Xrn5WFW0vrn8JF1jyF4rKw4vqFy7Zw4kJ347
	Jr40qa97AF4DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU7EfnUUUUU=
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/xtbC7A6dzGrr8y7vRgAA3G

Hi Alexey, Andi,

Sorry for leaving Alexey's review unanswered, and thank you for reviewing
and merging the fix. I am following up from wentao_liang_g@163.com because
I can no longer send mail from my original address, vulab@iscas.ac.cn.

> Maybe we could go for devm_clk_get_enabled and drop some more
> boilerplate which follows in wmt_i2c_reset_hardware, while at it?

Yes, that would allow a broader cleanup. The current reset helper calls
clk_prepare_enable() and disables the clock if clk_set_rate() fails.
There are also explicit clk_disable_unprepare() calls on adapter
registration failure and in remove(). Converting to
devm_clk_get_enabled() would need to update all of these together to
avoid double-disabling the clock and account for the resulting cleanup
ordering. The merged devm_clk_get() change only manages the clock
reference; it preserves the existing explicit enable/disable handling.
I agree that the broader cleanup belongs in a separate follow-up rather
than a v2 of the fix that has already been merged.

> Backporting this to stable seems like a stretch to me, though

I understand your concern about the backporting effort for a rarely
triggered leak in old code. The original stable Cc was for the missing
clk_put() on probe failure and driver removal, but I should have
addressed your concern at the time. This reply is not a request for any
additional backporting or for the broader cleanup to go to stable.

Andi, the 04/20 numbering came from a batch of independent fixes across
multiple subsystems, sent to their respective maintainers and lists.
This fix has no dependency on the other nineteen patches. That numbering
was confusing here; future independent fixes should be sent separately.

I used OpenAI Codex to help inspect the existing clock cleanup paths and
draft this reply. No new patch or hardware test results are submitted
with this message.

Thank you, and sorry again for the missed follow-up.

Best regards,
Wentao

