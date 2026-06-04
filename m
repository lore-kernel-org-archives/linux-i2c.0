Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EC28DB54;
	Thu,  4 Jun 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616380; cv=none; b=rCewKRXHe5PEAeKVm42hRbbvxZtf+QDXIliBt1++GrnFVzm/PvvngYSL6DvfyYzDJR+UEId54dq1oyjTZ1K01N+I/bzEEn+HbdIDPp8jJkfGQ88JYFG8DlEbbcHprkrRuiUQfSHtV+bLhDcVbQtZXuD6Ar45fi+4IBJhgin5ZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616380; c=relaxed/simple;
	bh=YCqsF/al6+5Ci+dfHVoXboKVX0K6TkEaBEdZCJ/62So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKSwXBfIn8ecl71G8GggquBlFNfqKOrfYerDdZHIrNSMvGeYbH7PiLgyqQBk/bG1DhatXdgJndV4s/4QrjtvcrVkhtlO/F981iNGS61ttjOtmiaLEy+sasVd/wUKuAtSPvxrhWI+Q/tzK7WIZIAa+9gSyJaIpNuuepfjRhb2Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THm9wCWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THm9wCWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E82C1F00893;
	Thu,  4 Jun 2026 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616378;
	bh=WAuad6/MhQeUeophKKyTVk7SPCKkPoGUex3aya7+4zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=THm9wCWq55chLTiGhQ/4UHKF1OzrvksZl1fpixgDRMMY090CkkRLiM6Y+cU6T+rFd
	 6ldFSXLG+BfqNFk+J1V6iS0BZRBQoj2ZAR8olq69eUIqFbVwADdZd7Hc7+5yojRPI9
	 4pNyFrw9sYoxBEqvdGf/KjVSfjoecwX5Viqj0He/95JdqV2zRtlYnY1W2rDoagVoIy
	 /0OdA+ZlLGy3Fknf0MUITwFpMdPo9qwHLLU+C/3PhUZ7Z0IgnbesnLfH/M1R6Z6pkd
	 OI85AjGdvhiK8ezgRA8C+eWkz35ULmRZUgCLfsC+P+lvM6GopvWaQ+VJDlUZG9SCPo
	 eI+FGPFo2vVBg==
Date: Fri, 5 Jun 2026 01:39:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vikram Sharma <vikram.sharma@oss.qualcomm.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 2/6] dt-bindings: i2c: qcom-cci: Document Glymur
 compatible
Message-ID: <aiIMg7MuoM_vg6Da@zenone.zhora.eu>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-2-bee535396d22@oss.qualcomm.com>
 <ahrvlYI-WfHwUPMC@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahrvlYI-WfHwUPMC@shikoro>

On Sat, May 30, 2026 at 04:09:25PM +0200, Wolfram Sang wrote:
> On Fri, May 29, 2026 at 08:07:22PM +0530, Vikram Sharma wrote:
> > From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> > 
> > Add Glymur compatible consistent with CAMSS CCI interfaces.
> > 
> > Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> > Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I will wait for the other patches from the series to be in a
better shape before taking this one.

Andi
