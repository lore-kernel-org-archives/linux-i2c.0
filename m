Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833537;
	b=bsXhU5OcESGVyG0QY3zFfd3Nt78s61Tm41W/pd6Eq8bANX+24OsqAxfHLu2wlA4z16c/
	 06wkc7JzquvMJ+TkjVHX/+1r1/uglR6K7aIo8QmX+TeB+5NP7gxfUcVE5qkZdIXEXFdWT
	 KYD2JCtSShB9hBX5e872/POkKjCK6oDhclz+TnenCurRJ5dF4l9VzLoy8s/lIwdjP30Qb
	 kAEI3RWOoceqeng9r60o4Qo9/sd6w7EdTMRwNIBJ/Zm0kQLkTvmv3pBRhNeVJZBLOCF2g
	 Vcs63L4kpb7ZG2OSblJBDqLHK6xb9fSMUtXu0rJCWxgppbRQn5PkWmbXpDjWMyaG/Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5Dm4n4ms7YK3xOnBLnFejmdnFkKaY1xBcsZDx4fivZY=;
	b=HnSX0GXaL/s+Y22afLUOpD0BNGNo7WP4nX6KeDLgUYjObaiChXk0oKU3DcfCv7ZlBJ2B
	 ZI84XiHIoPoCFlbrlWywjv3OxJmsLZwTMvy8RdUvqHvHh8HNwCdjeGGVGa8YUlGcHnJqG
	 EqPfCP+Qxfdf4z/gU+YHdbygJWw3zJ0TnN066Hx6S5TnChXwxTAbMH6GbEfNV9YgBttHD
	 w3/SEqW2LuPwio8mDVMydgLJw3NMgZJQNHWJCqPt+bqWBsoQTQiQ8jsCEKkQwhDDc5Mlv
	 GcCUS+Z5KlZydn8bUZYcxU1yogCkkojDB6eshcom5dDg9xFdTcViK5bOMhKBJuR9tBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnpXwoWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67340606A31B;
	Wed,  4 Nov 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnpXwoWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEBB1F000C1;
	Wed,  4 Nov 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833537;
	bh=5Dm4n4ms7YK3xOnBLnFejmdnFkKaY1xBcsZDx4fivZY=;
	h=From:To:Cc:Subject:Date;
	b=hnpXwoWV0i7fUC5DV4IFvrCVYSdaFBg5bstK/+yYlokHwdnUW6+WJqMS6TQUQmJG5
	 KRqwmOLtY5jLsuU9F9aR64eQ6i5GgcDVf/K/+pZMpPaUP1rVZxpwHhsFyhRIC6YDdS
	 VYznDBC/c6/85fvAuGbsqXOb0wi1fayI9BwmP/sIQJIP3K52mWin/EhTI6XJeWvtDf
	 rlLW7f6opBUQIfTxM5ykT0xKsgPuZQTnvKdK9k/4mA5lsQ605LarLdzxwgB8e2tikx
	 KuBnrSQT3lw9C97FDVIBAMRHwVIhyfcLMl7EIfDmkRHhF+1PWsKlVp4LD47uscnwVo
	 O6nncwQ9vAKJw==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: qcom: sm8350: Add CCI and camera MCLK pins
Date: Thu,  5 Nov 2026 01:05:26 +0200
Message-ID: <20261104230529.3040285-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Qualcomm SM8350 Camera Control Interface (CCI) controllers and the
pin configurations of camera sensor master clock outputs.

The series depends on the SM8350 camera clock controller support:

  https://lore.kernel.org/all/20261104001704.2744766-1-vz@kernel.org/

Vladimir Zapolskiy (3):
  dt-bindings: i2c: qcom-cci: Document SM8350 compatible
  arm64: dts: qcom: sm8350: Add CCI device tree nodes
  arm64: dts: qcom: sm8350: Add camera MCLK pinctrl states

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml |   2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 231 ++++++++++++++++++
 2 files changed, 233 insertions(+)

-- 
2.51.0

