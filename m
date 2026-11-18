Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008641;
	b=HHexBqO5HVDCr+/7+fWWvXSCbCq5iuL0cAR8tcAIIPyFGLy7XUqOqKyaQV2XIJ/3BYwR
	 Xaa82kandDMIiojYjlbCBLBwZDcf4uK8i+ropfmRoY1NM6GSMslMUGMa4PZj9yWvCIxU8
	 ncuzuCcc1vhJHSL6Tf9FefT8nIRrhZTKEeyhLru6NSjThGdto8Iu3lVvhEHWeboAwz+37
	 BNHOd6tf9TzCyTd0f79pjoNzkn1kcoueatpGIi8Qbvh8QS/vn+WlomilAcF9s7WhTLrTh
	 J9SWJlaYwmqARm8YJhnPOeSgOYs/Z6ocoY8KzrQj5xVJAYy9THMZTliXjzlpC++w9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008641;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+d0zKzun5vmll+RUQTrgzKXCdhy+HftmAWgEgD0v9CY=;
	b=1kU70dq33mCSGjmvNOvDvNyTni/EBpBw57IKuVcIGL0zD5DstMb63VfiRdjOKjrCTbqJ
	 jZ402YZMbv0jRvBe03y6PlJUvvcZPxh+7iz+Ev3dcbNq75CgXv4ajJq1fccPjxFp2vP6/
	 OoxF09BcH44p1Ab4Rco1uA7rHhVWuitXwesY7vKFy2c9FS6u7RGtTpCGTOVUBhwCtA/mC
	 fTavfpPpTVi279mtIdRhJbx6yfiS7KUJaKlAm0eaL8yY8snUlKaFXu1j7TMQ5pyPlEtey
	 /mpGdGeCwagqQm0QCLKH5Hz+wgZo3PPKIUnSXTBBDq8hJ71F+r/FAt6+Jdp5zCx4bVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PQIS3/CY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BC9606A320;
	Wed, 18 Nov 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQIS3/CY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CA61F000C8;
	Wed, 18 Nov 2026 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795008640;
	bh=+d0zKzun5vmll+RUQTrgzKXCdhy+HftmAWgEgD0v9CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PQIS3/CYz0t2DnMknQrfrG2/ObHT+GwAnU1xkbf2+iBRTwe+FN/Vuh559pzQJzVuV
	 dVea3hya0kzY+Y7u/p0IxBgWw2Hb1go1cFJrfvHQJpWYLJuvqiCkt+6i263Z8VIXng
	 TKI/pILEW9JwxYgxulgPgXMZYwe34+JSat7FS6cdAYvfyDLWRH7fXgfxmnVosajSli
	 FNTEoMDpVTv4KM4FqtDM7qS6HcHZpHiCCqX8+QCvCGISLbplbEm1yvmyDnUatjb9Wv
	 XmktVsjCyj5FMg+/5lgyn/jy4fZIOad4sR9XLKyxC/ZQdnd8FEygjnA4Y2wU8Ba+Cs
	 4iViOEE33js7w==
Date: Wed, 18 Nov 2026 07:30:35 -0600
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Junyi Zhao <junyi.zhao@amlogic.com>,
	linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
Message-ID: <20261118133035.GA546269-robh@kernel.org>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
 <20261117-a9-i2c-v9-1-7b303c894fea@amlogic.com>
 <78d4a042-d9e0-4b88-8788-30310462dbdb@web.de>
 <0f0f687a-83d0-4af9-b146-3d737ccac809@amlogic.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0f687a-83d0-4af9-b146-3d737ccac809@amlogic.com>

On Tue, Nov 17, 2026 at 05:32:07PM +0800, Xianwei Zhao wrote:
> 
> 
> On 2026/11/17 17:05, Markus Elfring wrote:
> > > Add a Device Tree binding for the I2C controller found on the
> >          device tree?
> > 
> Will do s/Device Tree/device tree.

Devicetree actually. But feel free to ignore Markus and all of this.
