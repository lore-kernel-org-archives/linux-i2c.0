Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E73074B1;
	Tue, 28 Jul 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253606; cv=none; b=n9QEKMGcpKou8Svr7Yz7qQ3ZJKWNksOqwNzEKpsFNm96TF1wCo/ohVpCDYfhyeVzikhzeQCTXkDnnARbQp+KewwKuror1zv8VSUWn/TQJKVZ+JDr520sm45PjXLgTTb1IC9nTn7Ng9be9mAf4zvqrfLW8OEdHC8p8vZ58goUKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253606; c=relaxed/simple;
	bh=M7QkidlmWurZPijT3ZLmUtr1RIut138LnMtUxbuPBME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1lcT5xFzwfYxvzMW0hK2L8LWjSchpdQ8u3YHXyEUAllKl/kcwBjzDBENAQ9CxKvZTLi4z4OhN+9Glcow+KSEUwMcblgXTVl3n26ESFfFl80/MIfIlVOwYpwwdyXI38QhdDNrWR9J6lTXOUR7ZYHhzxmGsBkHVkFFof9p5NNr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb4pHgMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb4pHgMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAA61F000E9;
	Tue, 28 Jul 2026 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253604;
	bh=c6Q8H3BBb/ZHjJDp0d6Gxi/uxMRFhRcse0wE6uR1er4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zb4pHgMl5ln2Zt/nT3EtsTDJNPb190VX64h9q3T/YKKsXVXtMjlgzhDLvqXGXoq/Z
	 hdANw02MUjMz8PS5yaD+VzssRmXRfX8e0VY606wJtwSv9uzHII3zhKgRXTwBNNHJ22
	 L1wRnxvIn/LPG5AOVGmduKs0WRtyA8gwRH6WD4zcDBqHLV3/MFeUrUZhSrH5wYEKCZ
	 ygmlqwaq70HTF/Zzfm1catJm1NbX8XB0BnIPojXJGAENZzdwLTCDOG/ak88ZoP6vW6
	 ql8mL3udVQ73368XFoDRWltAmjT9CqOv5pjpG2B69rI12QOkCV0rS1DZT3IZch5UAe
	 Sg/sdl+NxLLwg==
Date: Tue, 28 Jul 2026 17:46:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] i2c: qcom-geni: improve transfer error recovery
 and synchronization
Message-ID: <amjOqvpG5OcQk4fg@zenone.zhora.eu>
References: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>

Hi Praveen,

> Praveen Talari (3):
>       i2c: qcom-geni: use cancel command before abort on transfer timeout
>       i2c: qcom-geni: use dedicated completions for abort and reset events
>       i2c: qcom-geni: distinguish address-phase and data-phase NACK

merged to i2c/i2c.

Thanks,
Andi
