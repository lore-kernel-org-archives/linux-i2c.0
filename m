Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175301;
	b=N4qR1ZoMm3sPP3UWN0UtWHtaSfSQMEwJTJ8cHlpTO/jlNMMXOjwRRgftrXLtUrEYwPgU
	 /tbUljLmX2SLWyR6j96RxJ/Jyg4mv9NyoxyaIVorPcMl5lL6zRXp8/NBf2HvjnrrAJf5r
	 5WiNWMvALkj2PNU0Hyz7+nLeJhxZ7MV/scPU1+AW5RYxm6ayPhnFvIb50mqqubCKQNUrh
	 3t2SnBnzlIoGBIK+h8Pp5mpIfRk1d1bqRUpnzRSvzxX+5uK2CtDHZgaghVL3noGPJsiy5
	 G/F9mfwi8KTu+uPn9aeF3ED8RpF6qvh25Ne9ZrCrIbC62bmtQkTBCl84+TjLIgujK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175301;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KCiZ+OPPiUqNo96uGTMFbWd85A/AQQGSdw1qgemTJ/w=;
	b=bsga6sKOoS3VzzOOODgwlFqeqA7e59bEzlFU+6S7zaK1hyNvLgn7owyoaOiSUvOino1R
	 DtGyE4uXU6nwVQMcY/ZzOZtMWuRZ0VLa71zErCC/JxJ6gETO6t6BFyjso3DLFqe0l3w9p
	 UPGLAsNs3sRiP9OdQpXXrfXopCsjTRA8dT6Dx4E85tKwo2GFawxAF4GSYQUDv0x9GayVd
	 Gh2X3suvJbunGk7/NH8ONQlrLLWGfsaAdsrThSrewKz0c/IT+74qWQABr5tEst1JaeTpz
	 CzW95h+cVlf+xGUdJQuqNAkB1VAwDXOX1ZWcFcWF+ff4o010olVrZNEeSMmxtMG0XTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3FtLrEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D0606A320;
	Fri, 20 Nov 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3FtLrEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0521F000D2;
	Fri, 20 Nov 2026 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175301;
	bh=KCiZ+OPPiUqNo96uGTMFbWd85A/AQQGSdw1qgemTJ/w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=g3FtLrEdDCcx7zeFiksA1MQYSbIwpjOYCqyMb22iOuD1Kzfo2nH4UirJGUXFG+BeW
	 9nksGUdMrH7NfSFyv5Zuipmumnckn+a3q0sMkc7pOJM+3e+F6f+cYFbrjzVsSXJD3M
	 7Bpv1kEHdQc5B4OSIV1Td+lcOn6osFQuRK61tiqQHksevi42quuiGwZq3KS+zwRnbV
	 Y15ZgS11PuI/91TsbvXB6rpn1DTO36ItmJ+HPinY95jEKd8KGbddMVr6NfPqyfwi5E
	 0swLKxNq2DqmrM/FAjxhdCYdxtF+ZlH25SlI8hZY3KILrFnjFznbjundNzYdoo5VUw
	 SiJLcWRdv3UHA==
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 06/23] phy: qcom-mipi-csi2: Add SM8750 support
From: bod@kernel.org
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, linux-phy@lists.infradead.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-6-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-6-8ff2a11835f6@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 11:48:14 +0000
Message-Id: <179517529405.2846709.10906711375536299427.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=bod@kernel.org;
 h=from:subject:message-id; bh=HkCiTy52VEw3U3iHmphqDHJaeM19p2HQlEUAvtfV7sM=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBrADN+rM7FGOD4L/bE61iccAJDLA1GBgvIi9K25
 7TFu2ta+NqJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCawAzfgAKCRAicTuzoY3I
 OnXgEACgF/ZyF9GFxmZtzZJvXcWq0YAAS8WJq/XOHG+rnlzVjz+XuzVJHpQJWwk51LrOn/wfCjN
 Nt0D2a1l3jpyVyHwVIk9NBEYITqU+lUUrHni4ZgtoFD+hL8a75/pVSxyy53QgYf39WiC9t3LxY4
 AkxKrjSz0A8WZDxolJYT9xcQyaN6aO4WNV34z6YCaMHvgE8YvwIBuXuSGvTbhlCq7zaPtB/LzfC
 gX67yae2iIeQ5TSqXPMhUHmDCpmVm7C1eSrkGO5lsdud5UQZ+jdTU73pJ85jB4URNwGFgPlY9tA
 n0VYIicr3vkyPPIvoxYT4Yo9RA8noTgxNaPQnjpo1YZIQYuBek2QxpV+gr5mWdA0gv3mn6vDB8i
 jal2FESfQqkgdWuymUDxCzbNoOVMb0LLQKSY9Lvs5ZqRl72ZKBDjuEc+rem5yK18DRHFdOUM2Sy
 BGDzevkaaAMZ4A2liil0oGoKFwPb3uyWnBvwGSNLBHH6+UyoK2svjyqMJIL1KhegYWUM9M9xfKB
 5xPpB8joDxgPlSgB23rj0dtvbVbMKzkTXY/BD4tMgkRql9u7F3Y1Hi7c1dKgvDKjNo89+2+Pff7
 y/0g6iYNGwK8VVUk6MPFrKnfMRmlMNdvCXjiemQe6U9jIso7tywrVuX3keqDelvK/YN35RHwWAz
 KoYo4vdep5v594w==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-11-14 19:29 +0800, Wenmeng Liu wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add the SM8750 CSI2 DPHY compatible to the match table, using the 3nm
> DPHY configuration.
> 
> The SM8750 CSIPHY nodes only carry "qcom,sm8750-csi2-phy" with no
> fallback compatible, so without this entry no driver matches them and
> the PHYs stay unbound.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
> index 165e3d026872db85e54a99c5dd25ca68a1a4e450..a672bf318487b16aacd1ecf165554cde3f38e292 100644
> --- a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
> +++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
> @@ -444,6 +444,7 @@ static int phy_qcom_mipi_csi2_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id phy_qcom_mipi_csi2_of_match_table[] = {
>  	{ .compatible	= "qcom,kaanapali-csi2-phy", .data = &mipi_csi2_dphy_3nm_kaanapali },
> +	{ .compatible	= "qcom,sm8750-csi2-phy", .data = &mipi_csi2_dphy_3nm_kaanapali },
>  	{ .compatible	= "qcom,x1e80100-csi2-phy", .data = &mipi_csi2_dphy_4nm_x1e },
>  	{ }
>  };
> 
> -- 
> 2.34.1
> 
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

