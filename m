Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32038F64F;
	Tue, 31 Mar 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940833; cv=none; b=qK/DC0BKrepLBMOvZkNz99iUlRLllBgS9L7RipMiuZJ+aPIxpawJUI9/+N0io1jUxH/CSOxUCRu/V6+QcsZWnSF6UPdBlfcxUVY84msTo0y1r4tskWCNeVEWP9Kjnbt+F1sytMP4lH22Ms1s0VUy+rCoOXFdu0EzidX0eNuEsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940833; c=relaxed/simple;
	bh=WJMm/nvo7FEQhOodLq5J4+rqkrG//GrGouln67Ry4Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfp1aRYPWxL7mv8HEo5HGJFXaKDihtbIS3WjQN60n/V8qNnOwJJhtaS3yt0jMGc6auHFZ104OVtmVv3VEGKzS2YpKHYt5hyAF/3UIY0DYDO+BLX796N4PT6dbJ4lhncc5ctg8gzbwt02m0LpENqKo814D8P8Tc2YwLxEo0os5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxRRxED9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxRRxED9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B5AC19423;
	Tue, 31 Mar 2026 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940832;
	bh=WJMm/nvo7FEQhOodLq5J4+rqkrG//GrGouln67Ry4Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxRRxED99NPCotdPXJIDyWH5414lBo5Rteagf6606fzViKRDxRTk7QYmxWbsZktt6
	 fWfYEaUKIwxfYYZFoLQ6//+NQn4BqSfV/A5+N0lo27npVvXoMhnO/LGuzB2zVw2F2H
	 O7wYyHJGAfZDPig57GBJ39VR+a8yXc2lTveN53Nv5JQVofWLJ2TIg+NourKHsIykXK
	 QKoNxNTGAjeHIxcHTGDAKNLYBSfVh6UMP5Nh+325uV8QkyP/bwnBZBbWchTJLOLweM
	 0vPZ8QhI17Ss1GqhLcyTmIIsLaU4QzZHbLoM+UBr78WpoR12P0xIQM4zDmJJV1x29e
	 2HkwwMEjKnbrw==
Date: Tue, 31 Mar 2026 09:07:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andi.shyti@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	krzk+dt@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org
Subject: Re: [PATCH v3] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT
 schema
Message-ID: <20260331-stoic-offbeat-pheasant-c90cfe@quoll>
References: <20260330054439.9545-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330054439.9545-1-i.shihao.999@gmail.com>

On Mon, Mar 30, 2026 at 11:14:39AM +0530, Shi Hao wrote:
> Convert the IOP3xx and IXP4xx XScale bindings to DT schema. This
> conversion also adds the interrupts property, as it is used by the driver
> and existing DTS files but was not documented in the original binding.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

