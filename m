Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8B3BB689;
	Fri,  9 Oct 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536594; cv=none; b=AeQkUvwab1CW/nFTN+velRNRkfF5KuRXvY8CMlqLzJPvyavM8331QSBSmzG/SJsNd4ePFNQqfUJyXtVq4L7GRMT3yjVz63yPE64CDE4sGk3lGUe43kdcXc+dH+nbDNOCmBwi32GV2rSdip6K9JGQWbWceKIOexgTPV6gi4+xldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536594; c=relaxed/simple;
	bh=hfn1azwIJFS/2XV6P3tF/6Ix4dHPT7wWFixCYC5+Q+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upO8hzoeddig+QfOrngYprkNUet4K8ml5S6/dXgcVnAXIdRxxUEWh0nn+pMSV4fowXnQz64uWLeil8H0+ZPGp+/rKskLb5lY/WNpLZaQ1C0PZaBFEFjn/NaWjbVeAJ5N2xrmWntgSJK3H2WgLEZquj19GvypYTBYxxJiZVSec4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDiKJHlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDiKJHlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555F1F000FF;
	Fri,  9 Oct 2026 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536593;
	bh=eMnhfMDmJdVNVQdZpkXeWoQbrxBrAgRwu4y8o+OD8xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JDiKJHltUySqtmFidFpVVrhrU5z9ATr+/a0pDp7D2nKaLEncRxM2U95IJYGgcAqAn
	 fW+T3y0oD5jBHup55QPnM9m5VFGxvNIQ+eQ1qcDGDbRU3WLs4uX8Y2anLKWwFBVbL/
	 0lKlx+EJ8utOoDiggdoZSTj5wvjcZ8VWxsj5M0u0c06oAEiM09D4DwHrhZZd+aF+qM
	 NPC4dr9Cv7+P72cqh0GnZ8jU7x0d6y3P07Dy3QB/xqf5Kl2NZYWal3IkbcpZPjnliU
	 K5A/FDSQw7kB5CKggjoODRR+OAA6m3fIkJgCjddtZD6wAAIBXggJSQBXRUIRIz05HW
	 JTKy7XEQwD9Eg==
Date: Fri, 9 Oct 2026 11:03:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hitesh Patel <hitesh@ebytelogic.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, ravi@ebytelogic.com
Subject: Re: [PATCH v3] i2c: qcom-cci: always enable SCL clock stretching
Message-ID: <asittIGjIL-oLnUe@zenone.zhora.eu>
References: <20261007050147.274096-1-hitesh@ebytelogic.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007050147.274096-1-hitesh@ebytelogic.com>

Hi Hitesh,

On Wed, Oct 07, 2026 at 10:31:46AM +0530, Hitesh Patel wrote:
> The CCI timing tables leave SCL clock stretching disabled. A slave that
> holds SCL low is then not waited for: the master keeps its own clock
> timing and the transfer fails with a NACK or returns corrupt data.
> 
> This is hit with a camera reached through a GMSL serializer/deserializer
> I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision mezzanine). The
> deserializer acknowledges the address locally, but forwards the
> transaction over the coax link and stretches SCL until the remote side
> has completed it, which takes well over one clock period at 100 kHz.
> Without stretching the register reads of the sensor behind the link
> intermittently return garbage and writes are dropped, which shows up as
> random sensor init failures.
> 
> Clock stretching is part of the I2C specification for every speed mode
> and a device that does not stretch is unaffected by enabling it, so set
> the bit unconditionally in cci_init() and drop the per-table
> scl_stretch_en field, which is zero in every table.
> 
> Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

pushed to i2c/i2c.

Thanks,
Andi
