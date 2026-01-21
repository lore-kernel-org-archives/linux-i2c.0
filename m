Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9634A3DB;
	Wed, 21 Jan 2026 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962965; cv=none; b=uGhc1uUAAUhszCm4JpiAKkBg8fS226vMv0XrNgUfqIEoIT1af2Lb4jZtdRmXdz1JY9D8Bu2noOQMitDwnOWI8E63ceQJDuBcaTSV8eM4hGxdRGxE1xrW+1aToy3crn2c+v9E+rMxxP4yQjKeP+GwotB+aghB+8UV0O3NVUTIBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962965; c=relaxed/simple;
	bh=gRc2XsAeTf9qp/tkzt6tsPrj6Ez7VEMteFx06Iu1wqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnOLHtCZMnWfMkGSywfTGHhZ6EYKR3Isq1FUrfiUocdDc2fKWLu9g0F/75oqQDYmidO9kwq5vrRoRD8fp5qpVJ7Xc8J6bJ2xI+wggBQjUy19rwgKMZiTXLanZ4nMNGv0IesV4Uxg2Eq4TrWj1ex13POLMxSR6Igk2rBZWcbL6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrAkiDq0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrAkiDq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD13C19425;
	Wed, 21 Jan 2026 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962965;
	bh=gRc2XsAeTf9qp/tkzt6tsPrj6Ez7VEMteFx06Iu1wqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrAkiDq0ri1V6iHFqoXYwEsMJ/CnojSTMlP87bH6usrDbWWt25rv2rHGxvS90Ly+2
	 k18+H4gSxtwTeEFC0qw41KlPuHSgMAGki1ra9oBOfn3GXCWaJc223X1a13lEXgcpJn
	 V89QH9TqT1/8nBdmKIPSNcZwDxA2n5+cPWy441Jo+7SzoxFO7OGcXKwkUwaUONHVkZ
	 h2evTxkjVhkHXM0txLw82wywQfBEo2Mx10xAdHKrBZjaxWbG1jPCngXZxKOgzDQvaZ
	 0mvW6SYWUi1qHhfHp5VvZRULzphbg44GefctH+JhMTHYMDtjrt5GSDktHJTTkciOjL
	 lDzZdRGFicNwg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/7] Camera I2C (CCI) enablement on MSM8953 and Fairphone 3
Date: Tue, 20 Jan 2026 20:35:54 -0600
Message-ID: <176896294103.1060469.9135824878140576272.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
References: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Oct 2025 17:40:45 +0100, Luca Weiss wrote:
> Add the compatibles and config for CCI on MSM8953, then enable these I2C
> busses on Fairphone 3 and configure the EEPROM found with one of the
> camera modules.
> 
> 

Applied, thanks!

[4/7] arm64: dts: qcom: msm8953: Re-sort tlmm pinctrl states
      commit: 589deb6bc2757787f2b15a84017c23839db3bf8e
[5/7] arm64: dts: qcom: msm8953: Add CCI nodes
      commit: 842c0aa3e04201bc13f51f5ce9edbb8100ef0d73
[6/7] arm64: dts: qcom: sdm632-fairphone-fp3: Add camera fixed regulators
      commit: 9e834e768d0b2e9007cd6a5c778d2d8e3674e78f
[7/7] arm64: dts: qcom: sdm632-fairphone-fp3: Enable CCI and add EEPROM
      commit: cfc22c2121cbf8bb75cb9a9993f13c17587ed55e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
