Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382401DF74F;
	Tue, 14 Apr 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205591; cv=none; b=FX5thbbTdSBSqBW1ILqHK7tnpz9ymHRM0+nFwmqHK7+w2MrD/EEz/xqh/nhbyz+3MpIHuZa1UP2x5nIt/VqxmSCJShyiWF/LuyqiggrVg1JvPom9dOb4m9+fONlQBKkGSwYIchRMEBNFD2YEURfxSk30Ojn2oAhlv4qaAV0cS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205591; c=relaxed/simple;
	bh=EuGh4i6XBBqw0PE7x/hX5ss56WtaEarQUaP6BZTpvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtFhZu1VF0WIgqYIreqVaxf1JXDDja9rxEQ+r1/nYadmQkn5zs9AxkoKqH/nyVxBbAm77De+dm1Eg95DkiOvxB2dbrFFi02FE5MyYRcRCq3gHcWX66vrURshSwfwVqKn8yKDlvh8MXmI9sx7BRcZVOseMHvsES9nlmMS56+dPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUNkEnwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUNkEnwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43371C19425;
	Tue, 14 Apr 2026 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205590;
	bh=EuGh4i6XBBqw0PE7x/hX5ss56WtaEarQUaP6BZTpvEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUNkEnwWLi+KAL90b6P+77mdHcVnyIJJPaKFL3YSzoCWbv5xvZZPNZHKms6h7ppdu
	 kMVS2rShB0kp9BTttJJTP64xAq3yFF44uNYi/TN+MXdykmfIIMWjgQb6j8ss1kLCbE
	 h/rgdt6dcBfQfDJO/L7/wqWbYr69i0AtMZiQy/Gac3yS4I/T72JLgUwUiMS+fi36SH
	 KCJXXY0tfd7UKblwOuFiE20lxOKqcJAesfFD+tU11fPLbl5e3v3f7YiKSraVJk+lG2
	 YfV6j42RHcHvzlxePors+VW2rYLFZl69UgQHJHZ7GWnhNXAUkdsuDM14xj9CFNltk0
	 +pdBzw5sFK4UQ==
Date: Wed, 15 Apr 2026 00:26:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Arun T <arun.t@intel.com>
Cc: israel.a.cepeda.lopez@intel.com, hansg@kernel.org, 
	sakari.ailus@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miguel.vadillo@intel.com
Subject: Re: [PATCH v2 2/2] i2c: usbio: Add ACPI device-id for NVL platforms
Message-ID: <ad6-8dSL2UFSkusr@zenone.zhora.eu>
References: <20260410141038.585760-1-arun.t@intel.com>
 <20260410141038.585760-2-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410141038.585760-2-arun.t@intel.com>

Hi Arun,

On Fri, Apr 10, 2026 at 07:40:38PM +0530, Arun T wrote:
> Add device IDs of Nova Lake into i2c-usbio support list.
> 
> Signed-off-by: Arun T <arun.t@intel.com>
> Reviewed-by: Vadillo Miguel <miguel.vadillo@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This patch has already been merged.

Andi
