Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F64E73D8
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889274; cv=none; b=uSMEUOMAh6qylDccBfaFphJri7jpl3rVBdHmYfCI/jNkiGTwROMv/NQBSlHV3bnUP7Cx/4J8uJIqUniEBN+WqeS99CYTIYnUp4PM9btOIQl/W0Gz/m1l508FHYj04gmtEF0lxXukuNkjTWPmMcxdci4dAPcUFWoLO9H5AXPc4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889274; c=relaxed/simple;
	bh=duaA/tP3ZrtphzKrRPtimu+04mnuzh60SMdu7fjhsM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfkRp5G0iXyrpi8opTae2z6QZgNgiw+LuoWbWsYpGJcNf5ot8A41IGny9hq4IGRnHqLAGqBAfidCnpIVtR5sossxy1r7BBOCjWxmdwl/BAGe+JVK/MNxvVdVt1+2s8QxEwHHjAW5mPAFbwWzuBtf5hEc13ZQiTXRcMr2orXEeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY3iDa3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY3iDa3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F76E1F000FF;
	Tue, 13 Oct 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889264;
	bh=jnSSTMDu8j1ifHQpacWfqzsDmgL59oVYI6LmqGyjd8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dY3iDa3xikBk/2NY99ndsGIWB+5jc/4Wyoi4ENer+PQjS14rYX0YXlROefGIWc9tj
	 GxLrFG0xSxXZLXDHLitTjsYJf2PQY/TMBDFcTWG1hn/krevav41cNYb+EFLT0CAWUm
	 VZaBsEv8laPAWbXwQSq3GaLVdCAi+5y+0raVotp19JGba1tluxWgEu8+9qVHKr6lcn
	 at10/aYpwR/Y44Q1h/3CZqOWNiiBftwUaHuKh86dkPPIz66/kyoXD+xJPhH1IFdoY+
	 72WJm6+Nbtlwb+DlXNJUrNtqI8/YBpihhlifkxkZGlywk6bw46RBafnS2kWW89PwcQ
	 /MTFGhY1eA+hA==
Date: Tue, 13 Oct 2026 13:01:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Saranya Gopal <saranya.gopal@intel.com>
Cc: linux-i2c@vger.kernel.org, yo-jung@canonical.com, 
	mpearson-lenovo@squebb.ca, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] i2c: i801: Gate SPD instantiation on SPD Write
 Disable bit
Message-ID: <as4PVkDIkoCxrvkp@zenone.zhora.eu>
References: <20261013080603.808196-1-saranya.gopal@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013080603.808196-1-saranya.gopal@intel.com>

Hi Saranya,

On Tue, Oct 13, 2026 at 01:36:03PM +0530, Saranya Gopal wrote:
> From: Yo-Jung <yo-jung@canonical.com>
> 
> When DDR5 memory modules are present, probing the spd5118 hub requires
> page-selection write transactions. If the BIOS has set the SPD Write
> Disable (SPD_WD) bit in SMBHSTCFG, the transaction fails and wedges the
> controller into an unrecoverable "SMBus is busy" state.
> 
> Pass the PCH SPD Write Disable status into the SMBus core via
> i2c_register_spd_write_disable(). This safely skips spd5118 instantiation
> under write-protection while leaving legacy DDR4 (ee1004) functional.
> 
> Retain the original #ifdef CONFIG_I2C_I801_MUX preprocessor block around
> mux_pdev to prevent compile-time regressions when the multiplexer driver
> is disabled.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=213345
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Co-developed-by: Saranya Gopal <saranya.gopal@intel.com>
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
> Signed-off-by: Yo-Jung <yo-jung@canonical.com>

pushed to i2c/i2c.

Thanks,
Andi
