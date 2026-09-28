Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F01470429;
	Mon, 28 Sep 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638653; cv=none; b=mIApFWEogLRBmfpVXTRrZjLKuZaB/4mWg/mNlIT8G1V95w+vD74q9/a7+ADM2xRsXRYht0H/3pVStU3VNt95CbkTCz4/NkfV0MyF2iHCS0qRzEb63HY5V6wCOZWLusOHihXW9yPpHf+JZxkXbAJEpZWsc0YnWXxKzv+AKS6ILt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638653; c=relaxed/simple;
	bh=pejY82Fj5/wTqOvIWfFOhZ4TJVh03Rj1g01ke4ofWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3iw/kJVZoI3toaXntDqrl+yVLsJcAJe/Cd+v8aHN/HY813dROD1IqXnviYZbwRio34ZfKcGZ9HtwL657gbSc8O9SYVvw/+fCtmNU0sgqMGqh7H2Ry5ncP/aj5eHlE3yI1ipnp1sqRRlG7AEG8zo/Zwh0ur3ccxhKv2/vYqTlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTrpDj5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTrpDj5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4731F000FF;
	Mon, 28 Sep 2026 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638651;
	bh=oHyZ/liGhiGDNksFA1WpL4KIfqZ+EOX2YGgMK/FxXsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TTrpDj5WgkflohaT4j1bn6pOQbi4V4CNmGGbW9nceGe/Ku8cAvKNAmn0JhvZtowIV
	 0CZddJS1AHwin/qrIGKuWucF/PLYfmQhJr167NTTiHUAo6CxmKhWvTECB6r6dK2tWp
	 KQXnVyy4YIdi11BQ1g2LkM6Fhx6L0VWIq67byaZ73cgr9kxR17JYHB2/69S1wiECpB
	 M407Wht3udQ0YYsvmXMzSGcohgy/DYsID03eaWJ1AQua5b1IqjKgEzhm2SQpH2Lcw8
	 DsO+bf7w0VPNWNqQmC4ZQ334ytuTEAPj2dy8evvF31jJM6SAdxhDvX5VafauNc/Q6c
	 xjKnu3ZQMGT8A==
Date: Tue, 29 Sep 2026 01:37:28 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hitesh Patel <hitesh@ebytelogic.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, ravi@ebytelogic.com
Subject: Re: [PATCH v2] i2c: qcom-cci: always enable SCL clock stretching
Message-ID: <arr57tHBYx1MowW7@zenone.zhora.eu>
References: <20260914132328.976902-1-hitesh@ebytelogic.com>
 <20260921131954.1690578-1-hitesh@ebytelogic.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921131954.1690578-1-hitesh@ebytelogic.com>

Hi Hitesh,

Please don't send next versions as --in-reply-to, it makes life
difficult.

On Mon, Sep 21, 2026 at 06:49:54PM +0530, Hitesh Patel wrote:
> Every CCI timing table except the msm8953 fast-plus one leaves SCL
> clock stretching disabled in MISC_CTL. A slave that holds SCL low is
> then not waited for: the master keeps its own clock timing and the
> transfer fails with a NACK or returns corrupt data.
> 
> This is hit with a camera reached through a GMSL serializer/
> deserializer I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision
> mezzanine, SC7280 CCI v2 at 100 kHz). The deserializer acknowledges
> the address locally, forwards the transaction over the coax link and
> stretches SCL until the remote side has completed it, which takes well
> over one clock period. Without stretching the register reads of the
> sensor behind the link intermittently return garbage and writes are
> dropped, which shows up as random sensor init failures.
> 
> Clock stretching is part of the I2C specification for every speed
> mode and a device that does not stretch is unaffected by it, so there
> is no reason to make it a per-table parameter. Set the bit
> unconditionally and drop the scl_stretch_en field.
> 
> Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>

I'll wait for an ack from Konrad here.

Thanks,
Andi
