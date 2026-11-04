Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827168;
	b=fqLx9V6CJbGhTnIxOliqJes7YgGrtC3cse44cikEDGa5101BL1mGXfJbQgZ+TuLuziWx
	 68yRXx0fOKTI01dtcLrV+nncj+bJCxu7eAwuzltL6y0fRFVZ4ABu5+T0CGWWrE7k1Ecl8
	 5iTM/hqY9Y8c+7WMZc6YDqgX9Jv4oalylopyNX0yTVswUn/nX6oq8SqHB9DV5un8Y7foM
	 lTvZccjhGiHGKTsDidqdtxG1PsZo1sycxPtJD4FtPZ1YRwSfi0m69iuUHqYVf3mCbusON
	 hh/RBnFiL4aHTRrCUjie04u7zGQLaNcji64fT+vR/gzMzd1NB8MfVfsn3Zqv4kxM4oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3DpEQ4BV8ncjuBOzZJCc6LJDmuPNTxkR4oFZHyN7ZmM=;
	b=07sQQaYlbilr+IdNepPPITXyau1Ntt/+dXtzAxYvR6XrOffknPAPcLwLGOepNg67uYEC
	 nzLlv64hKul1Wueh76uiwVoliXqNjSAGJ152QKmqIwr/VGX55FqY+w7cVpYPbufmw8xeT
	 oJwm5SQNSR0H/yF37l10ZNhS+HfkiIz5T1OM/6krs9Wj9CNjRFyYKS1aZVLURqfycBZHI
	 xsEUdv5TQTsSireHZhISHd13z68zreJL+mAAI2gTafWIfr59qBEcW/xuXT/sW/X94n2SD
	 0lsU68DTMbwyWwzxSLRYfAtKRL1WHA+VDHJ52kNYd4nrYIKQRHhEXkAF9f/xCpHfK4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=jNvCIdSw;
	arc=none smtp.remote-ip=95.215.58.11
Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B56074F9B
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 21:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C20B56074F9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=jNvCIdSw
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h8kZr+2P5FyKEJmL9Drkm4bpXOy70o/S/a6qT+o6Brk=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793827165; v=1; x=1794431965;
 b=jNvCIdSwx8XbP6Z/yh4PauQlvjl2yBv9KSsBzTA8ni3TJC+OI+iwREUiak5pSkhymMK8zDB6
 AwCAdorhppQ4hJWw8PNnXwolKNXcKo3AOKrNT7oXkc9w6rwXN5vkQ6889UpJo4l0LQ4x+f80RfI
 JBhmZuvtUWJJYLP9rNGRD9pqEh+mvbY62A2waA//loj/jd+jOR6m33ZOeVUerY33QO5cpXxG9J8
 YFjB5WO5gfu0/3+gWEGDp72EXkBj+SfhErYhS0i4yyWtHScgjFkPSdJLl6ip5eY//j7HGsIXTY6
 V5unKt6xyV7Fr8/bWxW9I1fdH3KEl5VkFNeNLKzN3SQHQ==
X-Envelope-To: linux-i2c@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5aecda40ac6f06c;
	Wed, 04 Nov 2026 21:19:25 +0000
X-Mizu-Trace-ID: c5aecda40ac6f06c
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5405525-78ee-4480-b482-4dedc49661a7@packett.cool>
Date: Wed, 4 Nov 2026 18:19:13 -0300
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
Subject: Re: [PATCH 3/4] media: qcom: camss: Add support for SM8150
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 11/4/26 5:54 PM, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
>
> Add CAMSS platform data for the Qualcomm SM8150 SoC. The camera
> subsystem contains four CSIPHY, four CSID (two full and two lite), two
> VFE and two VFE-Lite instances.
>
> The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> layout. Add CAMSS_8150 to the version enum and to the shared code
> paths, then add the per-block clock, regulator, power domain,
> interrupt and interconnect resources.
>
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
Wow, what an unbelievable coincidence — I just went looking for this and 
found these patches on gitlab in order to test on the similar sc8180x, 
and half an hour later you've submitted it to the lists! :D
>   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
>   drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
>   drivers/media/platform/qcom/camss/camss.c          | 262 +++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h          |   1 +
>   4 files changed, 267 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index dac8d2ecf799..851decb0691e 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1141,6 +1141,7 @@ static bool csiphy_is_gen2(u32 version)
>   	case CAMSS_8650:
>   	case CAMSS_8775P:
>   	case CAMSS_X1E80100:
> +	case CAMSS_8150:
It should probably go higher in the sort order, before 8250?
>   		ret = true;
>   		break;
>   	}
> @@ -1236,6 +1237,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8250);
>   		break;
>   	case CAMSS_8280XP:
> +	case CAMSS_8150:
>   		regs->lane_regs = &lane_regs_sc8280xp[0];
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
>   		break;
Interesting, why do these match 8280xp and not, say, 8250?
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 2680a9914765..dd28058e98a7 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -354,6 +354,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>   	case CAMSS_8650:
>   	case CAMSS_8775P:
>   	case CAMSS_X1E80100:
> +	case CAMSS_8150:
Sort order here too
>   		switch (sink_code) {
>   		case MEDIA_BUS_FMT_YUYV8_1X16:
>   		{
> @@ -2010,6 +2011,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
>   	case CAMSS_8280XP:
>   	case CAMSS_8300:
>   	case CAMSS_845:
> +	case CAMSS_8150:
>   	case CAMSS_8550:
>   	case CAMSS_8650:
>   	case CAMSS_8775P:
> [..]


Thanks,
~val

