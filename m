Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B53B19A8;
	Fri, 10 Apr 2026 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855872; cv=none; b=W6eXXETvyoW8ydAjNDkr7nj/st3kW6vyli5fopcEO1e9zHFfYLHWukKdrB4/HXL+Ro/KPtnkHcIEKkY2gMJP5bSI0UGiLM4r+c7j6O1Qoj+Mw6jDh8sdzJRCEVhrrJSZWSEFHiIAjvSQzgqOmx3pjiARbFFEQASrJsoi0H/tugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855872; c=relaxed/simple;
	bh=R2QOEE2zo/O8othUeZFOtmsKH3GnvkqW1KrNOBzMyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA6kv2IFWUKkj1fsmGrYkLSIT5LJRKGnDr96Ryc/jcK0QysVI9jLXiu90FPILoWkqOiyOyJjnvQfpwLQllZcvTyEMc8ldFa0avwXTY2vWoy1DlJGfBk8hDvTfP0aNaByOLrevS5OAbuzx2fseksf7AFxn6sECandtchN8PcQssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHc+4pzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHc+4pzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0BCC19421;
	Fri, 10 Apr 2026 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775855871;
	bh=R2QOEE2zo/O8othUeZFOtmsKH3GnvkqW1KrNOBzMyt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHc+4pzlYC5G2cZZi3FgYT0XWD9NJI1BZUKNWKmB5KkWmNm92h1gBcwVvb1r9lL5p
	 ir9SESkoF+BkG1VgcfGxQxUcRD/l0SwoZWcnaqVjAFEjB28JO1nO9PqUb4CsFbQJ0o
	 ltn6jc0lVXs11l9iHDZjGC/PJrLSiKDZ8KRYt+M5Ut8WhxpLXGLESD8TNm7Odn5SSI
	 keAOJIiuLRfmOuhData/6F62Be+ZUM9PBODN4Ovm/EI5UGEkGN6ew1QZevmhxgpVJ+
	 tvgUy8pRED2tkdo9RtMUKYmXT8LooCFrXrSWXmwHYDMDFIhHK/fFaIf2d2yTjsgKn1
	 +hdoia+SfS2iQ==
Date: Fri, 10 Apr 2026 23:17:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Arun T <arun.t@intel.com>
Cc: israel.a.cepeda.lopez@intel.com, hansg@kernel.org, 
	sakari.ailus@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miguel.vadillo@intel.com
Subject: Re: [PATCH 2/2] i2c: usbio: Add ACPI device-id for NVL platforms
Message-ID: <adlo6s-yzzkJHJ0c@zenone.zhora.eu>
References: <20260410080408.562311-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410080408.562311-1-arun.t@intel.com>

Hi Arun,

On Fri, Apr 10, 2026 at 01:34:08PM +0530, Arun T wrote:
> Add device IDs of Nova Lake into i2c-usbio support list
> 
> Signed-off-by: Arun T <arun.t@intel.com>
> Reviewed-by: Vadillo Miguel <miguel.vadillo@intel.com>

merged to i2c/i2c-host.

Thanks,
Andi
