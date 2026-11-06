Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004483;
	b=kaacQsNTqXPREL6u9ZiqYxbSi31LEPb7j0KNkNXbjv3+uhGyVQU3alU65E/vo/A3AGmg
	 UZh5YTubI0ExCnZdQtjJqMgkqy9uUVmrVKnQWtDUvrsWHNmEGQsob/vBtXCrR69/4ykNQ
	 e1BxhJtxyRHdA1EYHwKO8XZQWAmKr+64JGxbvE+kVZJIHL62SiUWm6M1N7MrCuashVaKt
	 DAGR/5HhxymeLCHQYlCFsENFayRhAQ6t0syDL8EBxDmvWuvOCbDdgOJXFBngFKr5zUqQh
	 fZCr/8QitNBgUrHwtxVF5yALH0jLpV1mpDQ4Z8dsueWxbywvHg8rw+O1ulrtNUsOSRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004483;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7Quq3xcYOSiCqP1VWqFYsEpRGnceLb6KT1qUylBV5i0=;
	b=Sy5SlnLGeCnTmEpkECponiSxXR8AXbMylUG+iaUJSGjHOnFWahJuiGlSPQkFgD2ec7S4
	 /HG4vugQ+EQ7sKXJyKIZrcuuTxyWvAnhLrNy3VjdyNNCMSjuEox/owCsgwC3Ub3MOeYih
	 RCFnKzMjs03bf2N+eyK+fBDmiG0r9CngRNmp/ByBjRuwNnaxosd6QmRiWhFbiro8CHcSZ
	 Zw0KMB2/s+qHxAelpmE+V7XJWvQMdL7oWYYEa0+VnG/P9B386EQf3cdKJ+pRfu3epwidA
	 hmM+F3pya9fSih3LX/llpxY9E8FJ0XfRSpedqILCeAgLdA0zRySJQi4Jgoy7CV562WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmzZ8OtT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD5606A326;
	Fri,  6 Nov 2026 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmzZ8OtT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EC1F0089F;
	Fri,  6 Nov 2026 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794004483;
	bh=7Quq3xcYOSiCqP1VWqFYsEpRGnceLb6KT1qUylBV5i0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AmzZ8OtTiadnCnqTnmUrn4wK5gvLMZ/21+/uTceAXFcpx10yAsv6vL/XCaG+oQAAz
	 GG8ETTHn+3mDP6tim693onHvQTu0ukO5rX+SetNYamzXPk2PuJ9aiyr22RXdrQFTh+
	 xluvgtWpQyWGAWPpfcuVWgVWOEvt2Qf3Lj88LD0wWpBSx+ofksWsAI9UwLF5Hq2g5z
	 fcwoVe1cqKVWST2AP4dNdFZ9DXjGlX8HgxAwBRott8f4el6aSxf+QOJuKO8zQc8pXp
	 pwaiCQqykoBDLGJCoLyEwqB8FYb19ZF7gi9hDlYgV1f8v6CqORqob5l427a4dRMhO/
	 5BXgRQqdOQ8XA==
Message-ID: <5d72eff8-ac6d-453c-ac63-db7e30e4a917@kernel.org>
Date: Fri, 6 Nov 2026 22:34:36 +0000
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] media: qcom: camss: Match VFE lite clocks by name
 prefix
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <6n2xSSEPbQQR62rX2-W0NR48vBjFHq10xHuJ_rAoN_4xOC4HaGuHmz7IM49xl6JHRC2cKI_VCfJ_NS_kW3jphw==@protonmail.internalid>
 <20261106-sm8150-v7.4-rc1-camss-v3-4-0103e8a0bbcd@andrewgigena.dev>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-4-0103e8a0bbcd@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 18:35, Andrew Gigena via B4 Relay wrote:
> @@ -346,6 +347,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>   	case CAMSS_6350:
>   	case CAMSS_7280:
>   	case CAMSS_8x96:
> +	case CAMSS_8150:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
>   	case CAMSS_8300:
> @@ -914,6 +916,9 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
>   	return (!strcmp(clock->name, vfe_name) ||
>   		!strcmp(clock->name, vfe_lite_name) ||
>   		!strcmp(clock->name, "vfe_lite") ||
> +		(vfe->res->is_lite &&
> +		 !strncmp(clock->name, "vfe_lite", 8) &&
> +		 isdigit((unsigned char)clock->name[8])) ||
>   		!strcmp(clock->name, "camnoc_axi") ||
>   		!strcmp(clock->name, "camnoc_rt_axi"));
>   }
> @@ -2006,6 +2011,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
>   	case CAMSS_6150:
>   	case CAMSS_6350:
>   	case CAMSS_7280:
> +	case CAMSS_8150:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
>   	case CAMSS_8300:

This patch mangles the thing the patch title does with switch additions 
for src_pad_code and bpl_align_rdi.

Please separate.

---
bod
