Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824088;
	b=opxFeJFnI3WLbooKaMNQ6bt+TQFAc1qjTyF3hzG7HRGdaQThEfhFNjCR1PfUWq3rDCqG
	 xnttqqhF2ANH0P7qATG404YjywDoiL8cTGpB6PUPNF0dYK1Cd5OTI0oYLoFaNNxR+4BDh
	 r5uyFKCWSA2Cyt1i9N/qkevixM5up97ibm4FwTD03sCR0GBYyhpWHrlEN9hQvcqLeGR0q
	 VceVkz8uo2yOBTAuOY+8m7FSxFT58z36ecTcQdoZXDtYhZ8B01Dr1Gp3cnWMGEW/wjuux
	 TuhsYuuYmgGw16sgckLOqtXwieMJb0ok4D8+fUo1rWD9E87v9U4PnhPDNeOC3KlLVZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T030N8s2iM3qCbFH6IrWtzoTyw/pZ1cXkifyK3pJJbg=;
	b=xuonhMki2SHRA11k+Q359sZy3gk2YN8KIf6KkF+93hOxJYZ2eXsoU7FhMDCbCtzAcjyH
	 boHKjY2lgmCIFMRl0bic/lY/HLJqTIdWsX82/6j8/opAN9njZd3B8KKvB5KEPO+FK82eb
	 sprKEoM/ShSbIVIp0QyNQglU0cqBxVXqk8ZS9EbvSfEI4sUNr1B9FcPUg1ZYGw65tRVm8
	 +tD0ZEopMcOCoo25ezf7gaDReXgiCc3lvPao3WbAtpRRo9OSs6LKucfzmC7wf5Enc3rtW
	 v6TSxbSWBZsVSI0UIC+IyWIv11zUUwbjAmfxe9Qt0UDJtqNo4Uvh5Jd1RhaN09i+yVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcm3NmAW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F70606A31C;
	Mon, 16 Nov 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcm3NmAW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9651F000C5;
	Mon, 16 Nov 2026 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824088;
	bh=T030N8s2iM3qCbFH6IrWtzoTyw/pZ1cXkifyK3pJJbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jcm3NmAWyKfMuUe2fQ9WMjsdJGzI8zu9Be35CHYChSzGxxcV0eZlryDP7s/Fd5CS/
	 L4CSVHTZDH312gV3xC8UvRkuTMUsq/i1WcZYrEvWNezLhtXH49DwDE65pCNTBi+eu7
	 kiLTzooUmcwNxhQiQmu52Tnilu1lS2YjH0rqqmz3+kt987bHLicuz3bXLyIPk/iT2x
	 7MhfiSSDo+Fio2FGmbD6BOZKzNk8tJGEXujR9hZBcmpOy7D6M7byeww0LVv6ykXBJ4
	 kFKN0tgc2aPsC7E4DCNX9KmJv8CDiX+89+Ohd6t7GrMQ7Yrv8zMe8yFWlqKYK0iFXO
	 BL3X3VCXWhDfA==
Date: Mon, 16 Nov 2026 11:14:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>, linux-phy@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v7 03/23] dt-bindings: media: qcom,sm8750-camss: Add
 SM8750 CAMSS
Message-ID: <20261116-dangerous-nano-caterpillar-7052a6@quoll>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-3-8ff2a11835f6@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-3-8ff2a11835f6@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 07:29:20PM +0800, Wenmeng Liu wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add bindings for Camera Subsystem (CAMSS) on the Qualcomm SM8750 platform.
> 
> The SM8750 platform provides:
> - 6 x CSIPHY (CSI Physical Layer)
> - 3 x TPG (Test Pattern Generator)
> - 3 x CSID (CSI Decoder)
> - 2 x CSID Lite
> - 3 x VFE (Video Front End), 5 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE Lite
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

