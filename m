Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6903F3276;
	Tue, 29 Sep 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651794; cv=none; b=PZJerDyv0u+aOwDQ3yPIzJf/ts9A/zGAJV31hpUFl+qFGwhKN/NeQ3GkDSkxxF7947iy/lbqNn7o4F3nC+fF+YasgEh6MV+T82BjbrnnEWP9se87jKJlqnVA15ipOl94zdgtE7ybYsoizH9962syN7rZ+V6XRhpmgEFCDRqAPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651794; c=relaxed/simple;
	bh=58M0gFWWidG/6zbPnFb5epoEJBUF/zkfX0wEx9uuAZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B804fiZVEIkckTm/nymgD0jiujK/oaz4aivFz50GHX35gawiGvG3ifPXKVK5l8Th/t001SdNakwPCeXHmHwJlIoVtGLhhJ7L/8iRB55407u83cS19SuJxeSmby9Daq/+V4EaZhvBWeAIqCP8cFGDVjzGwr9a3kju3d2tnenb6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA8CL9vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA8CL9vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA431F00899;
	Tue, 29 Sep 2026 03:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651786;
	bh=F0CTjS7yFkhDUw+iDXIDuiAzpBXHh0hjcv/EEJ3JGDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oA8CL9vq/wIWnCIlahYuBGTm+51jH6ASoouihS9wSoZq2Xk4mab7ftGB1fRA7AWmX
	 FpzbT82Yc7snvxzrcs9dwCBTGzU1KduOEYcGr3hkSXr2ncJAJvf7g9M+GGgE9ogYSo
	 ymzeZD+9kHufCIlWrOw9EKhbErjRKzugXNxDCCzpSVc0T3w2ZCqf/TfxyC+V4to9TF
	 x0a1NsBJG4ehwvCX+ulpkj+/i/yh5bs8LXoCUs6vRQnsTB6mCLk1u+mEPbg2QXNLqU
	 1yDxGn4JTCiWs+KB9F9C6/k4EkOomoBK4fD0ruW3TbcmQXqgb7xOK9hfX4W6g9oFBf
	 6+6EjV1TPeGgQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Bryan O'Donoghue <bod@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Suresh Vankadara <quic_svankada@quicinc.com>,
	Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] Add CAMSS and IMX577 sensor support for Shikra EVK
Date: Mon, 28 Sep 2026 22:15:14 -0500
Message-ID: <179065170904.2673486.17917322298927031673.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923-shikra-camss-review-v9-0-09f5fbea1309@oss.qualcomm.com>
References: <20260923-shikra-camss-review-v9-0-09f5fbea1309@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 23 Sep 2026 10:27:27 +0530, Nihal Kumar Gupta wrote:
> Shikra EVK is based on the Qualcomm Shikra SoC.
> It lacks a camera sensor in its default configuration.
> This series adds CAMSS driver support, CCI definitions and enables
> the 22-pin IMX577 sensor via CSIPHY1 through device tree overlays.
> 
> We have tested IMX577 Sensor on CCI1 with following commands:
> - media-ctl --reset
> - media-ctl -d /dev/media0 -V '"imx577 1-001a":0[fmt:SRGGB10/4056x3040 field:none]'
> - media-ctl -d /dev/media0 -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -l '"msm_csiphy1":1->"msm_csid0":0[1]'
> - media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> - yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: shikra: Add CAMSS node for Shikra
      commit: f1e325d194fb0d719d848a42ec522e0f70250e44
[2/5] arm64: dts: qcom: shikra: Add CCI definitions for Shikra
      commit: 7a3fcdb8d28fa5f162003b4f28f0160c82ee62af
[3/5] arm64: dts: qcom: shikra: Add mclks pin configuration for Shikra
      commit: e1f5d59e0eca23e2e69353f769bfaa187ad94ab8
[4/5] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera: Add DT overlay for Shikra
      commit: 9cd1efbde98772e08a79a7b5d655cae60b38264e
[5/5] arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add DT overlay for Shikra
      commit: a4be00ccf9e0bdcfd407397368e0599c559d90be

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
