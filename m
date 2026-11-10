Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354981;
	b=Yv1drjDzvj7abWC6VI7pBvuyArSXKnOma80GTXUmieF/t/o4T4nNApS8nBfct6eL2pO+
	 kwrUPqKfBre+f9p8BAOucvqnP6PCyFe9Gf4xImBFYnXQjdlcSda1nsixzRBkGeM/zfRUr
	 65Tkdcn4uER1lTpXp/+OPeSeiiV7dxfKCq+JhcGsjrpOoaR8ElZmKcTmwH7MAh4ndWSK9
	 3IHEHQZfdLxnclRcQl4uibCRpY5UUdS1WDzkYTELxlPxpbkZ5Z6zBx1bZu6QmcYZ4tAgv
	 zvQM+eMuuEV/3m3tlhvCQcbtbm6DDBwQw2VcsSzjtZQRI4CcOzT0+eJSxM7RlZir99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354981;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TbgkfmRSlQR0RSZaLLsWqAT5L9ZTG2kkyMrzBfuV6Vk=;
	b=K6dT68jJUo1slAHWi+wRSfBcMxqNd8b3nlZZ3Iv07ZRsSmqoAk0lYUkxZ6549jtnIPXQ
	 mYEmRg8dkPZ5Og8iMqCthiZlkMSKlKYm67TPmMlVaYE3oJy4+su86aRatvbESVXvyc/BQ
	 JzG26aq3FsZwLLzYE6TdqChZCbwNX+Zi2mw5KsUvmrELtdGRj7vDA7pabHpZQdIyu67TD
	 XRCvw10xc3ZblBIeuj1G4d9Cm7IGH7o3qqPDTA0ca1Rewe/YhmeLyq+jWmL/NIw5/4vyG
	 ZV7bvyDa8WVT/NTRtIvxI62J81NL5I3otMY2wYBIdqANlDlq843BUlYWvOGNYdWKhSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EB606A321
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 23:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 734EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c08c7adadso2183938d50.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 15:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354980; x=1794959780;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbgkfmRSlQR0RSZaLLsWqAT5L9ZTG2kkyMrzBfuV6Vk=;
        b=DvMT1lhYtHhIS0Qhx3bXlBswYbB1+IGQndW7kZmoWhwFhKowhl0gmbRR36dTSm63/3
         ftBlx20C9ZlxWozNCs0XcxKLe9ceIar2TBmR7RDp1xFJiqKyBkEqtpSXRKOKF7y1Sv3/
         1nD/AEAnpPli/NWTXV9aN7M/9vtQXk0cNnyb/b7rIAJ4TQhL3Lp6RxYqdrrIo6ktRaGw
         X5ugD6r6fLNJHpXj1qYTsmqRnzAJ/eRlmhZYKAQuaie/zzvYw4c+qjzrdFuS/T9sCJn6
         WUSV9VfHUt+sFZ4ge8RlVYA0HMKsWPpm/YPccEml1tiZuZ7qITzCgL+eqqhTzVr1MZ10
         zkuQ==
X-Forwarded-Encrypted: i=1; AL+hErGlk6wg1GCNJokx3Rifz3KvTDzPVQbQa/+9P+39V8RlZmoXnzQ4bRqJk4Qd07yeYtm5yzn6+M9/KMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZrPxCeUFvDVzgMzQKUl1sb3RNcoCuD5xEdg1IHICr2CcHtkJk
	5kCfB3SEEkOoOrQqYuzUc+NMBIszzThhUyxckKSazdDiklr3nBs0ZMgy
X-Gm-Gg: AYBFou3OvspeB7CukeEJjDbo5hNEu9gQob/XlD+JOdH1KXqO9Q7eclLgehLbZDYRa74
	VPk5hbAnWs5xLblMGKAbpO+NYickRiu3GOs+4eMaLm8nxhjxRl5m3MMv0fs6IcpOTYbZFxBcF7b
	gM6WSOx8ieO5RVUdtK+c31yqPp6CC/EuquFNYuJaYnvJTDX2EWHjWtsXjS1dWqyrDVNnqS41vMZ
	/2JHdOJKT9wrfGCwExdamzDV4cjj7u/hzzQvJGlSW+iNwnAN+it7AakoSr0gl1Lgf8L+VIUHA7f
	ipavY5QZXUg+fasl9ZVeqLE99Tf4xI1EgGUkXxmzNmNnYAmgUBqqLAMvNRLwHjEEZb8sdNhNpny
	bikVnHh5SXj+zs40vV2dYLOvNzpEMkVhHSHIJj72zS50k/MSP67y9M2mboTVwdTbOiI0xAaXHCK
	jFEeiTqoaM2/L0mD4zWXXIKH7Y+vNnFc9lwlhu+loskJICSijgx0d6lU0Njk8t7IALRjNRYWzQa
	Hnpm//5AxO0ystK7mrwyTPjoxlUicBfS81efML4TmeP4k8BY1BP0a+9UXTOgoSUowMr8rOIgivF
	QcOBRl/+FYpfzNczFoKUjeT1M6OKwH7UkI3wgHVnk2HdBXssqYb+8EOcio5go0G/8NMjGZoF
X-Received: by 2002:a53:ec04:0:b0:679:4176:47e4 with SMTP id 956f58d0204a3-67c6811a961mr389098d50.99.1794354980450;
        Tue, 10 Nov 2026 15:56:20 -0800 (PST)
Received: from ?IPV6:2800:a4:806:ef00:2f77:7097:372d:6d14? ([2800:a4:806:ef00:2f77:7097:372d:6d14])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58a294ffsm3158931d50.23.2026.11.10.15.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 15:56:19 -0800 (PST)
Message-ID: <fb65a7d2-5656-4659-bd96-17fc5bea2b84@andrewgigena.dev>
Date: Tue, 10 Nov 2026 23:56:13 +0000
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
Subject: Re: [PATCH v3 6/7] phy: qcom-mipi-csi2: Add SM8150 CSI2 DPHY support
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <C4VI5PNThYmwD0VGOO9DvvHRRydBUz2k5DOLjkianYgYaz4G3-El6cDpnQh2siR4mMwjeiL4_Yp2xEAYeJDJ2Q==@protonmail.internalid>
 <20261106-sm8150-v7.4-rc1-camss-v3-6-0103e8a0bbcd@andrewgigena.dev>
 <88407f72-0c6e-4e46-b97b-7031c237dac7@kernel.org>
 <83c6281f-1887-4481-8c63-957b4bc856b9@linaro.org>
Content-Language: en-US
From: Andrew Gigena <mail@andrewgigena.dev>
In-Reply-To: <83c6281f-1887-4481-8c63-957b4bc856b9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bryan,

> What you could do to unblock your series and not have a dependency on
> another series is cherry-pick the necessary patch.
>
> https://patchwork.linuxtv.org/project/linux-media/patch/20261102213936.1251316-1-anusha.nandi@oss.qualcomm.com/

I took Anusha's approach and dropped the dev_pm_domain_detach() hack.
Single power-domain SoCs now use dev_pm_domain_attach(dev, 0) and the
loops check for a NULL pd_list. I folded it into the PHY patch with
Co-developed-by and Signed-off-by for Anusha, so the series has no
dependency on another series.

On your other points:

> Is there really no AHB clock to be listed here ? Seems again suspect.

There is no separate AHB clock. The "core" clock is cam_cc_csiphyN_clk,
whose parent is cam_cc_cphy_rx_clk_src at 400 MHz, and the second clock
is the CSI PHY timer.

> These are not the correct names

Renamed to vdda-0p9 and vdda-1p2 in the binding, the driver and the DTS.

> But why ?

The SM8150 timer RCG only has 19.2 MHz and 300 MHz. link_freq / 4 rounds
down to 19.2 MHz and the settle count comes out zero, so the rate is
pinned to 300 MHz through timer_rate_hz.

Best regards,
Andrew
