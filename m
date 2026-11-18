Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026177;
	b=b0XLLYR2gnwzmQHPg2SdjIApjWyG0O8CLshYmq9bhVYWgeGxpL+7adGNFLLnM5vqO1ZX
	 8ENmnE6TZhomQfh8DnzF0XJrWCykg78087QGYN3dhx9wMYbD1uOi0dcg43ZYnEZrrmECe
	 pWVlpYz50BHOXCD6njh2YgPehJj1W/3B/ufnY2f1xINwX496ilm8/G4fDI/dk8/3PLj/e
	 gKunmRauFYORq5Jt7Cu0j1f16cs/3VHmkY8+CfEz913Suc+D1jF1u7gfe5qeS/0XXVxn+
	 Tmf8W+pce3wRNNDpyGWwjPcMpnhzIh5wCPEUmQrcMmgXJX94XNUxDlzpE5G8a4UXnaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026177;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=h61PfhcBe+DMs3O1zi49O1Oj5TJ4u6zGftAUCUm0Yw4=;
	b=HUVJr36Q8/R5eXSzI6PFdjBqreOOg3qE9J8aZ3OvAkaAgyYBypgupbLbaRDljaee7b/r
	 otXQzhEZhZCuTRhYbONKqsEfExYDTKAlfwawuXrUzSO/kZzNVEj0wA9Ur3iqWr4V1laWE
	 bxVUsKC0NirfcU3T8tYWrUNr5uaQbiC6VonrtW26h0VkcUNt4DBoU0C/H3ZTKUhWlOEFc
	 /HKh/M7PxBTiSNS3nvUR2IwTOvwrtgYzdwOIurUaBEu3RXlBfh4gyog+oWQIzl1kZZSMf
	 bLYT4gH+Chci+QrcGy4iKDO8PxfP9pV0x3/ymXKQgdFYaF8OMtl/XwpqYqZ2riA83zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iasr3mdk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3C606A339;
	Wed, 18 Nov 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iasr3mdk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BC1F000C4;
	Wed, 18 Nov 2026 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026176;
	bh=h61PfhcBe+DMs3O1zi49O1Oj5TJ4u6zGftAUCUm0Yw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Iasr3mdk0AKFIO3+dZ2tvHrk79f/1jiQx0zK4tVnYkfDbEF6b5MvBIgjqbLa8LW0z
	 9GjhOAa3uspo/P3kXqzq1V+qh7dCNV8LanDx+1KAFEeBmR5nrNdt2Ev2ArwQZ/6Vgn
	 ur/VetQwgpTfPvwnRox30OYgzJiXT9U8sIZcxS2C42TEZk7A3jLh5X24jeEy/c3Yzb
	 9tkU/5T2xh6K27wUdyJQrOrKLtQgkFPGikU16AOKsxGuiwMY1l9YKAX9MuWxOAiCMv
	 w5fp5kjoIQdpnT5tmjVcyWu0lTRVSmyZc7Vagrr7/OkwIHfASgW9HEP1ho2Cd78o5Y
	 FIJf0UuHqFDdQ==
Subject: Re: [PATCH net-next v3 1/3] i2c: xiic: allow platforms to require
 32-bit register accesses
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 andrew+netdev@lunn.ch, corbet@lwn.net, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, rdunlap@infradead.org,
 richardcochran@gmail.com, skhan@linuxfoundation.org
Date: Wed, 18 Nov 2026 18:22:55 +0000
Message-ID: <179502617544.3136.16911407487347494512@kernel.org>
In-Reply-To: <20261116-wiwi-v3-87afa10a8-1-ahmadexp@gmail.com>
References: <20261116-wiwi-v3-87afa10a8-1-ahmadexp@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In drivers/i2c/busses/i2c-xiic.c, this patch extends the block
  comment above the register accessors (lines 281-290), but the…

--

i2c: xiic: allow platforms to require 32-bit register accesses

This patch adds a force_32bit_access flag to the xiic platform data. When
the flag is set, the byte and halfword register accessors issue aligned
32-bit accesses, still in the detected endianness. The first user is the
WiWi Time Card, whose LitePCIe bridge cannot handle subword MMIO.

> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index ab7916745ad39..edb5e271c8cde 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c

[ ... ]

> @@ -282,52 +284,68 @@ static int xiic_i2c_runtime_resume(struct device *dev)
>   * Only the least significant byte [doublet] of the register are ever
>   * accessed. This requires an offset of 3 [2] from the base address for
>   * big-endian systems.
> + * Some bridges only support aligned 32-bit accesses. For these, access the
> + * entire register in its detected byte order, without a read-modify-write:
> + * reading or writing a FIFO register must perform exactly one transaction.
>   */

[Severity: Low]
This isn't a bug, but the first sentence of this comment now contradicts
the new mode. It still says only the least significant byte [doublet] is
"ever accessed", using a +3 [+2] offset on big-endian.

When i2c->force_32bit_access is set, xiic_setreg8() and xiic_setreg16()
zero-extend the value and write the whole 32-bit register at the base
offset, with no +3/+2 adjustment:

    if (i2c->force_32bit_access) {
        xiic_setreg32(i2c, reg, value);
        return;
    }

In the same mode, xiic_getreg8() reads the full register through
xiic_getreg32() and truncates the result.

Could the first sentence be changed so it only describes the default
accessors?

The comment also doesn't say what the new mode relies on. The registers
written through xiic_setreg8() and xiic_setreg16() (XIIC_CR_REG_OFFSET,
XIIC_RFD_REG_OFFSET, XIIC_DTR_REG_OFFSET) now get zeros in their upper
bits. Should the comment note that those upper bits must be reserved or
ignored on write?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-wiwi-v3-87afa10a8-0-ahmadexp%40gmail.com
