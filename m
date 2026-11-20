Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175341;
	b=kkjkphQJlZJ1zR+ercapaRb/YQbvVAsu+1K8HMXxNZWUqU1f7Is7fWLP5miHW1j2/Izg
	 0o/vohmX7wlvRp4Vvlxt/PylXsbdAc2vtKQ1xeYXmZFjJf+3InNO6Dpx+17ZIWa3bDZDw
	 gyzGKZErSNRQ93zD6waUma9Orj7P/gu/N2HUfh2LRw0r5m6kQB3FZU/w9RjOVCTS5gdWZ
	 iPHNvxMLMOTtcWPLS18BfD8pWYlLPqu1nui0YRBL/rb/6CxPGz4AsDFhjggHWY8unnkN1
	 Vv3dHOi45ZRfa4pv+czea3we4WCSo56RLIAaeBp47+ALHCZgZNxZ0xN5otuobluGnKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175341;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=u8l/U5OT/Y6CBEr80GX62yXAKFPyEQ4q4m7GqQI3+Nw=;
	b=ylK4LNG9cakiR99B2NceVepfEtORs7s1kqvXxs9NTG5I0dleKZDYr6dEH9hoUfkoUsvr
	 Ly3/2YL1vL5pA7x640bWzx5N2lrEUUUbkHsK57z8/rKR60XXxZh5Y53MfA24fzzJf/Y+R
	 nfX0LBB6LF1rD2/mH1DSvEKmknYvqJqYSFq/5T/zpjlkkCEHl62fIs6alUOWPzIVhy3cN
	 MCZFrR6EE1xbwttWS7dxQ7RqqZd9+N4sCB3qDhLPar0EHZH5sqUXe07pYejX9WRpO16Q6
	 ibn0rxfkoi0PmiF2I3AmaFpfEqRgUzTujiBm0gnqAP6deInFNq9ilAqnn/BM+VI9MGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcBexOHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681E606A32A;
	Fri, 20 Nov 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcBexOHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCE61F000C0;
	Fri, 20 Nov 2026 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175340;
	bh=u8l/U5OT/Y6CBEr80GX62yXAKFPyEQ4q4m7GqQI3+Nw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hcBexOHUMQkhXRpw6J2YlBW+kBBvPm7QrGDW4CGU5mAlWg6twGFJxe1ZqttaN07tn
	 sd4v+OROeVivVIw16xj/TXH5XCZ3S4hypUxgMbynLKxKBLD5ixIPy8UZ2ZY6c8FfvN
	 pyEvQ5W9YO3DkgIPSor/3yhPOnVYGx7M6onSbyAdoqBvBckgNjBsqwJkBnm8ubbjQi
	 0B57FJlZiBSaL/jud64G3ooz9IpjTTrMV2bj11E/eRbqZI0FUBT3ZQpTi1rjTRAmRl
	 amccNZt1lXknyuG962K39swBEJNao4rwh3irNCNf0J1rhrkcIFw7AE5bnWnweHROJy
	 wQanlKSiR+cfQ==
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
Subject: Re: [PATCH v7 08/23] media: qcom: camss: Add PM clock definitions
 for SM8750
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
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-8-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-8-8ff2a11835f6@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 11:48:53 +0000
Message-Id: <179517533369.2846709.4822429145839216229.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=487; i=bod@kernel.org;
 h=from:subject:message-id; bh=uMJapb3KunetUf6a8hwO+z88+IfyEVucqVVMO3w/uh0=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBrADOl2MX4yKVTxDhvZxr+pGfmeAH85hqm4xuZY
 psAiCfBz8aJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCawAzpQAKCRAicTuzoY3I
 Or65EACi218HD1FId3P5PiL3Jtf7fowZziKnMcsHHdroi69/H0q1YecJ6AxAF2bQU5s3/mlLynt
 MR9oVqbVOPwuFepOAFcq61n91ec/R5we+PVfA/3K0ku7nDnlKYnZywZx/9IcBLPRKRny9joAFvL
 AP2/YOg4vZWJDenNUtPp1CJNVR2vfzb2g422cPV91MKrTY1r+KcNHQ5Cfzz7Vf8Y0XLG3Hb3oy/
 PPHTz+/MGr2IradSx2J+/v9LUGcHjeZCxq5KDnM9ItPu0FwKqgzNcdbnSS/F2xB/UUr9YqAS4aw
 oCOvsZiveZufw0dGn3tmKqPpojUbEVC2urFqQyU0iIUZA3YQPGIafwqJFvY0eOrsrbI3TnSpiSF
 tVHeBRUjL9Drd8GMdVKy0zDnyxdYPs18SLPZyM1eEblBeJ+hcPS2AtRCs8gf1vMYZrupqTkHdiY
 T7uRSTzUSMGmPuzap3oh5pU4O39ccURtuy33xZdhQR/2dm+i3PwK/feD2R2XjC+vIK9rxuy0Y3T
 qz9DPscI1ogkiJEUlxVKJwY8w/iZo7uJ8swEc0ajLl90Uzgo8y6e0b2LR4GOFPrP00/EkVDUH6r
 zzq+XIzjGLGPOKleLiyQYPqoZ6th0YnWQIv8STVZxD1EbcNA0MuckMgYkFo3VbG/WpTJP0XlCvD
 fdkdjXePKPFPEWg==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-11-14 19:29 +0800, Wenmeng Liu wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add cpas_fast_ahb, cpas_ahb and gcc_axi_hf to the PM clock list for
> SM8750. The CAMSS core enables them through the shared PM clock helper
> when the device is probed.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

