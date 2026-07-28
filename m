Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8B4756B1;
	Tue, 28 Jul 2026 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270643; cv=none; b=uVEvWDU/2v9Xu2j+GOFZciAHzOBrifR9rzv/JeNTBnS1tL3YhVSuZY5jSlaEjBGb2fWky5hi3PfreGJ3oYTJOpwz+JQFOeX7KA4U+5pasfWgM74Y+nHzVKm+0koOsQn7AjUHkxfszEdnQhCSzOeJCJ9tUvDDVvtssP0NQvfo5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270643; c=relaxed/simple;
	bh=P+vAuB8MmdKBvTKJQ0v3K8oM4wk3dFTpSh7kKG1FYUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiCHhPgUNMSrKGlmII0tpy5CZ4SNTY3JYJYZ19PUL8UlzPsJ2nhaVLPiPDOdnanmx4GZSNJ2w8XgVLFYVesLHd2biRk6sprPQ/V0NW4vdXw8Qfv2M0HJQRtbOUyoCPHSDjmQSu1Amrrrgr1SWLIVjDzMXmEaQahc3xvDya30xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGedZtAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGedZtAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F61F000E9;
	Tue, 28 Jul 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785270638;
	bh=pfkaONfQTI4AkasG0rJBaGwNNxdcN81d0t1EDh4yP58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGedZtArefRy+miiZucYYJptN0PVrbKrQNzURTKnt+oakZE/Kcwr57RKtfqQvJEdG
	 eR6+/KJtDc9cgaDItpHJ8Isn1Z/+ZCVXucsHfvUftVCyE6oU9b+rtLuqz47dS9AzlS
	 GBETB2nFqeknCyCQ7UgKJcw1Ba1WWPwkjChTt78cXAZidlQvPSlWgQ0eMNIaqWdU5r
	 TN8YLg3B1mLWmc4olqMb7oe0z/vjfZwFt0mmKLmZZR9XLa3jBKqVtU/Ql36xp8EsqU
	 HJ48cK4+8aPWbh5whfvO8aafx17VhZdowD5BeD/PZwKOY3V5umgeqHBrFR5Zz1Jr/u
	 fGMOxvBZIXUSQ==
Date: Tue, 28 Jul 2026 22:30:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <amkE_TftCv75VrJC@zenone.zhora.eu>
References: <alWiYfNDrOfo66HM@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alWiYfNDrOfo66HM@google.com>

Hi Dmitry,

thanks for your patch. The core, indeed, does not know the size
of the caller's buffer, so this can be, indeed, handled in the
generic I2C code, instead of delegating it to individual host
drivers.

...

> diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
> index c277a8e1202b..4df5330aca00 100644
> --- a/Documentation/i2c/dev-interface.rst
> +++ b/Documentation/i2c/dev-interface.rst
> @@ -161,9 +161,10 @@ for details) through the following functions::
>    __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
>    __s32 i2c_smbus_block_process_call(int file, __u8 command, __u8 length,
>                                       __u8 *values);
> -  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
> +  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 length,
> +                                  __u8 *values);
>    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
> -                                   __u8 *values);
> +                                   const __u8 *values);

The kernel and userspace APIs should remain aligned. If the
kernel helper gains a buffer-length argument, it makes sense to
consider the same improvement for libi2c.

This requires a coordinated i2c-tools change. Updating this
prototype here alone would document a userspace function which
does not yet exist.

Wolfram, do you have any opinion here?

>  
>  All these transactions return -1 on failure; you can read errno to see
>  what happened. The 'write' transactions return 0 on success; the

...

> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		return -EINVAL;
> +
>  	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
>  				I2C_SMBUS_READ, command,
>  				I2C_SMBUS_BLOCK_DATA, &data);
>  	if (status)
>  		return status;
>  
> -	memcpy(values, &data.block[1], data.block[0]);
> -	return data.block[0];
> +	ret_len = min(length, data.block[0]);

I don't like silently truncating the response.

If the device returns more data than the supplied buffer can
hold, the caller should be notified. Otherwise, a truncated
response is indistinguishable from a valid shorter response.

I think this should return an error, for example -EMSGSIZE, when
data.block[0] is greater than length.

Thanks,
Andi

> +	memcpy(values, &data.block[1], ret_len);
> +	return ret_len;
>  }
