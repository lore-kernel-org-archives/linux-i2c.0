Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2313806A4;
	Thu, 19 Mar 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959338; cv=none; b=snJ0aUy1I8jasY1a8YGUJA2/USGSjocLUszzjODrjyGUOhLFo33WNJGPfP/s/Vt/2DHoI5muFGL5JQP5C+G3sgHMkclf7zMiaBBrxiNm6qXLiZrqCsg8owaJYT2n9LGU2YyzhPCYhyu9lfuXeyy4ZO5zGfSetrs+vv8YA78uCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959338; c=relaxed/simple;
	bh=qTCiiRiQcYvzEQvFpzTLrDQN9z/Q1eu3z9UAB+xvL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPo2razI438QG5dB41njJ81wipOzi9baAAjyQD3ZUpHaFr4MCe6zokJqP1vbzggPfrReeB9sRBscMNciuRlcb6gRN0acsJGO7NTYSWZ1smLP5A809MhJqTlgaEcLhT/ziOnpVX3JdHUe3Iof5ozQywKIlK8C3bLDhbgef2ItkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtjrxLlc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtjrxLlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD490C19424;
	Thu, 19 Mar 2026 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773959337;
	bh=qTCiiRiQcYvzEQvFpzTLrDQN9z/Q1eu3z9UAB+xvL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtjrxLlc+al3aud38MDaNhV7I2tPEUFXhMndplDTlcBXv0J9qxDAu8p4oNakH7IOO
	 feQrwmhxATEkafoMO45QYKEhjfP70J8kChNPP2OuJRkTb/4YNNo7y4Q5qyJ0kg2bGh
	 Wwn51Eh1776KVtKSPI66QXuiMU0vJx9N1/+ivJjtxclDYqLrECsA5YZxrhijZh9V4i
	 cGZEwthgb18/4qSLxNki3ZiZeiRVX1jpgY5cii5sExPOXASF+aQyrdnc/KdelR5cBY
	 So8GA+61pSxcZTBXz2tM929z2uz/3b6cyk/FVSLXJHkpkn53bRN6eDF27AQBokZsfx
	 61L34RdUsk2lQ==
Date: Thu, 19 Mar 2026 23:28:52 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: cp2615: fix serial string NULL-deref at probe
Message-ID: <abx39x7d5VdFnm5U@zenone.zhora.eu>
References: <20260309075016.25612-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309075016.25612-1-johan@kernel.org>

Hi Johan,

On Mon, Mar 09, 2026 at 08:50:16AM +0100, Johan Hovold wrote:
> The cp2615 driver uses the USB device serial string as the i2c adapter
> name but does not make sure that the string exists.
> 
> Verify that the device has a serial number before accessing it to avoid
> triggering a NULL-pointer dereference (e.g. with malicious devices).
> 
> Fixes: 4a7695429ead ("i2c: cp2615: add i2c driver for Silicon Labs' CP2615 Digital Audio Bridge")
> Cc: stable@vger.kernel.org	# 5.13
> Cc: Bence Csókás <bence98@sch.bme.hu>
> Signed-off-by: Johan Hovold <johan@kernel.org>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
