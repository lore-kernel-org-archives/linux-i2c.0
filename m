Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA3355049;
	Sun,  5 Apr 2026 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775418048; cv=none; b=MB/uYM6/uE7qF7S5f+KDy/SH+KtmXzaDtPuQ/5ZVajOIpVey4o7RFrssGHfDTWMGG/UTGUyDhXNCcsIxwzQF9Fz9xssNW2fgNKbEwlPN67jGuau3CW8z1+ZLfAVUtKCOhQOGvxxfyj0GPWl4SyekVNgfyQ82i9FqHZo1FBN/gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775418048; c=relaxed/simple;
	bh=ObHNj4zibVJ0tKh/MEaT8rXw+GnIdyr1ICHQtESxpNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpxWIaOUKE8i2dIhfmGeg+cMNInjuBcC0LNVDIbvuZpMh74PtiCY+FypOd1I5yDTeOlEDDPXIl+LVH5aHvORG09s9sbczmAcPAW7Z6C25QuK59sJGlJmCtPCNzHLFTBjFmh1jPSksx8Xh88WFbI9nO96EtEevqSPhz7/EAvBvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRMCHTzZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRMCHTzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC1C116C6;
	Sun,  5 Apr 2026 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775418047;
	bh=ObHNj4zibVJ0tKh/MEaT8rXw+GnIdyr1ICHQtESxpNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRMCHTzZDDvcFdb9X6juGFTjEKGpp8GbGt+4HXL1mCVaq9dBcYCEBMSPOPOxB6OUH
	 OKL2i+XXJlV+66bwfgN/g1Am48x3iCRgzgDgjMLBnpGQx6/MERI2k163MuAGEM15Np
	 CEYH0vLaP2HhUXI7RkRazhci6GOLnvQb90jLygiQ1Sjnicikbd7Il6ABelpLvjeMon
	 tIZ+R7X0D1a8KsJ4BiXJ+OUxzgCi9k5sxA3azoYtd2ttv1HXCTiuEpduar/m11HM15
	 whjvFqG8ftvILH4zss4/4iFid7CgWj1U3rqXA6NWQDUwvaYJzbHWPf2/mTULCliPsx
	 CuCidDrjO1WfQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/5] Add CCI and imx577 sensor support for Talos evk
Date: Sun,  5 Apr 2026 14:40:26 -0500
Message-ID: <177541802149.2061229.15434639093932679869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
References: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 05 Mar 2026 17:48:11 +0800, Wenmeng Liu wrote:
> Talos EVK is  based on the Qualcomm SM6150 SoC.
> It lacks a camera sensor in its default configuration.
> This series adds CCI support and enables the IMX577 sensor via CSIPHY1
> through device tree overlay.
> 
> We have tested IMX577 Sensor on CCI1 with following commands:
> - media-ctl -d /dev/media0 --reset
> - media-ctl -d /dev/media0 -V '"imx577 1-001a":0[fmt:SRGGB10/4056x3040 field:none]'
> - media-ctl -d /dev/media0 -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -l '"msm_csiphy1":1->"msm_csid0":0[1]'
> - media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> - yavta -B capture-mplane -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0 --capture=5
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: talos: Add camss node
      commit: c0b357d5d059812e5b48fab81270d8f4c8f62162
[3/5] arm64: dts: qcom: talos: Add CCI definitions
      commit: 17ba0a3c874684c9ca5a41ddf9f167648b10aad2
[4/5] arm64: dts: qcom: talos: Add camera MCLK pinctrl
      commit: fd3850cde71f284ca69f70b904df78f561ece103
[5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
      commit: 594be93cdc9dcfec5d10882ed3fccce1e3af9015

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
