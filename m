Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5B485924;
	Tue, 13 Oct 2026 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868656; cv=none; b=pMEAWfsrL+ow3wTCv5chrwyu/xh6lOLpHHZ9nIOTgJVg0UDZIZ9PRwC8U9NjSkm9asAYqC53cw+WOY2aHKh+UDPeEODInwdkOXe4Pdxeuks3Wma7eLGrjSR5gfRTc3Ppb9Fqw2gn7KRBsnbFk+810+s1JuPh+S5j478/IwLrKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868656; c=relaxed/simple;
	bh=ZW+ADp7BI6KoXt57sY5rD0TzWorKxw1qLn0xytDrwIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz8pPgBfjFIUpi4tuJz0iAKVvVyCWVpdzirTe5uzSCSaO9bAEw80tszOaaGryOyntkrdCtRmiENq1LvPfgKxJAH8V9DgYPsuaK9hY9r5yiZJfhiV6sDfs955nNNYnMhq06Qrg3S6acmG+H2rXPvIlZIxs/iavB8iHHG4TQGXY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8CxQNHrvs1qVDsVAA--.62324S3;
	Tue, 13 Oct 2026 13:17:31 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJAxlMznvs1qp7IrAA--.64852S2;
	Tue, 13 Oct 2026 13:17:27 +0800 (CST)
Message-ID: <2d89d84a-f7d1-439b-b111-e5ee21caeb88@loongson.cn>
Date: Tue, 13 Oct 2026 13:17:26 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] i2c: ls2x: Add clock- related properties and
 parsing
To: Hongliang Wang <wanghongliang@loongson.cn>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20260817090721.30582-1-wanghongliang@loongson.cn>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260817090721.30582-1-wanghongliang@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMznvs1qp7IrAA--.64852S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgESCGrMT-oSTAADsX
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4kWFy7ZF48Wr4kGF13Jrc_yoWrWFy3pF
	sxCa95Gr1jga48Wwsxt3yxZF95Xws8J39rGrnrWw15ua1avr1DZF1xKr909FykZrs2kayj
	gr9IgF1DKFy5AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r
	126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2BT5DUUU
	U



On 2026/8/17 17:07, Hongliang Wang wrote:
> Hi all:
> 
> This patch set adds clock related properties and parsing in dts and acpi.
> 
> ======
> V10:
> Patch (2/2):
> - Replace '/' operator with div64_u64() to avoid __udivdi3 linker error on
>    32‑bit architectures with CONFIG_COMPILE_TEST.
> 
> Link to V9:
> https://lore.kernel.org/all/20260810074927.25284-1-wanghongliang@loongson.cn/
> 
> V9:
> Patch (2/2):
> - Rewrite the commit description
> - Use 64-bit arithmetic to avoid integer overflow during the clock calculation
> - Add checks to reject zero clock rates and ensure valid clock inputs
> - Modify the comment for clocks and clock-div properties
> - Add Tested-by tag from Xi Ruoyao, thanks
> 
> Link to V8:
> https://lore.kernel.org/all/20260721122604.12717-1-wanghongliang@loongson.cn/
> 
> V8:
> Patch (2/2):
> Fix the potential issues from Sashiko AI review:
>   - Add error checking for the pointer returned by devm_clk_get_optional_enabled();
>   - Add zero-value checking for the match data to provide default div.
> 
> Link to V7:
> https://lore.kernel.org/all/20260707035104.3092-1-wanghongliang@loongson.cn/
> 
> V7:
> Patch (2/2):
> Fix the potential issues from Sashiko AI review:
>   - Move the clock property parsing process to probe function to solve the issue
>     of calling `devm_clk_get_optional_enabled()` dynamically causes unbounded memory
>     leaks and unbalanced clock enable counts.
>   - Add non-zero checking to priv->div.
> 
> Link to V6:
> https://lore.kernel.org/all/20260608024533.32419-1-wanghongliang@loongson.cn/
> 
> V6:
> - Add Reviewed-by tag from Huacai, thanks.
> Patch (1/2):
>   - Remove CC stable.
> 
> Link to V5:
> https://lore.kernel.org/all/20260604015848.18643-1-wanghongliang@loongson.cn/
> 
> V5:
> Patch (1/2):
>   - Adjust the position of #include <dt-bindings/clock/loongson,ls2k-clk.h>;
>   - Add CC stable;
>   - Fix Signed-off-by.
> Patch (2/2):
>   - Replace 2K0500/2K1000/2K2000 with LS2K0500/2K1000/2K2000;
>   - Replace 7A1000/7A2000 with LS7A1000/7A2000;
>   - Replace if (clk && !IS_ERR(clk)) with if(!IS_ERR_OR_NULL(clk));
>   - Add document that clocks and clock-div are only ACPI properties in ACPI;
>   - Remove unsigned int cast in code (unsigned long)device_get_match_data(dev);
>   - Add CC stable;
>   - Fix Signed-off-by.
> 
> Link to V4:
> https://lore.kernel.org/all/20260526031021.32662-1-wanghongliang@loongson.cn/
> 
> V4:
> - Add Acked-by tag from Conor Dooley, thanks.
> Patch (2/2):
>   - Adjust the position of #include <linux/clk.h>;
>   - Remove struct ls2x_i2c_chip_data and use macro to describe div;
>   - Use div instead of factor in ls2x_i2c_adjust_bus_speed;
>   - Reverse the "if & else" code logic in ls2x_i2c_adjust_bus_speed;
> 
> Link to V2:
> The PATCH v3 is incomplete, v4 is the replacement of v3, so the previous patch link is v2.
> 
> [PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
> https://lore.kernel.org/all/20260507081010.12810-1-wanghongliang@loongson.cn/
> [PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
> https://lore.kernel.org/all/20260507081010.12810-2-wanghongliang@loongson.cn/
> 
> V2:
> [PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
> - Remove the custom properties clock-input and clock-div, use clock framework;
> [PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
> - Use clock framework to obtain the i2c reference clock in dts.
> 
> Link to V1:
> https://lore.kernel.org/all/20260325011852.19079-1-wanghongliang@loongson.cn/
> 
> Hongliang Wang (2):
>    dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
>    i2c: ls2x: Add clocks property parsing and adjust bus speed
> 
>   .../bindings/i2c/loongson,ls2x-i2c.yaml       |  3 ++
>   drivers/i2c/busses/i2c-ls2x.c                 | 44 +++++++++++++++++--
>   2 files changed, 44 insertions(+), 3 deletions(-)
> 

For the whole series,

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

-- 
Thanks.
Binbin

