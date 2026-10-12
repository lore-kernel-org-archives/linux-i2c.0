Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B096384CDA;
	Mon, 12 Oct 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845716; cv=none; b=INOb+qzCO4tRAYWH4VoGG1gPuQoFZXLSYhImDuteX6sQXNYu5a6Luot93fqVz0/n4fF1AthI2Seg+H0L5ybt2azVWyX2Az7s2E49XaUJgaYNrx73xQMCPVA+dc64UnmN2Lv7XydwNzPA+UfrUPyRZJFXrUqQ/q7iVZKXlVJpu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845716; c=relaxed/simple;
	bh=mzwEaypCwzwTdzF/5CWu6gt+vWvFYueUIderpRNUGEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq64P3HcpeqO5gwhPS9PC6fjufata2Vehb06Am7OZdbUD1E6XxkmIOHOC31jYzQhi72Iu3zzCwB0WdVxje73ts8/DrxcOicvRDwIByrPPGwfibovlhvPFd1pwFz6px0GnYSQ0Im0UaHibtDIbQh7V8sPoIniH+4BRyITjT8YIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMl0uiV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMl0uiV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8EE1F0089B;
	Mon, 12 Oct 2026 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791845715;
	bh=F4gL4AuSV3iViioxl00z0ZJvZKon3k2zQeY4DYfAv1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hMl0uiV+6WOvPPohkLGx1abAsT+eYk+Gbl1hlY1aiPWtBx/+pS0MZW1NkLDr/W2RR
	 1rW9c6FMcf7dGuDVQwAiH+KyQ/jcBDjBtM8CgV3U1ZedlER9wV3BLwgZ/uvIS0RrVy
	 7OoDi++i28I0n+csOLJqvg1gEb8etoS/+UtnGZy5ByZUIXmXNhrf4p+q+5Gc20Bgpv
	 HHw/j3TXiFPBbPFl8sqAMi7t7PtEnpvr+f7psZ09ilYVbqSn/PvSD/9YqeCqMRdmgU
	 51wXmJJmf0QEvAgPyHRKv5ORLo7Hi+bvH6M25MbOr8rRfAa0Qv9lFAunA320JN6+n3
	 oy9VVRpObGWrg==
Date: Tue, 13 Oct 2026 00:55:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support
 to OpRegion handler
Message-ID: <as1gYyr53eIxdzZV@zenone.zhora.eu>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
 <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>

Hi Hans,

...

> +	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
> +		if (action == ACPI_READ)
> +			status = i2c_master_recv(client, gsb->data, info->access_length);
> +		else
> +			status = i2c_master_send(client, gsb->data, info->access_length);
> +
> +		if (status >= 0) {
> +			gsb->len = status;
> +			status = 0;
> +		}

We should also check whether status != info->access_length.

Andi

> +		break;
> +
>  	default:
>  		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
>  			 accessor_type, client->addr);
> -- 
> 2.55.0
> 
