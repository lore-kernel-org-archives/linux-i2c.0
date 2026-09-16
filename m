Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C34CC630
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553483; cv=none; b=VZ+55rkqmWvWBsDYnz2LMqSSRMq3M5hpsSj3Qhv4PUY/xrPmD+T00dQ5NektxXaHki2IcUhr7YjutbcK4KnPPqrNxSbhh4NfcaJhuHtkT3+/J0J0QhVyn+EymRuvAfrrdsPYrz+R1JJJJEdT3s7w6qfs6fl9jYytsNLLlgYlFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553483; c=relaxed/simple;
	bh=qcK8mVSLEgWHYfVxcypZ4shTT751evsoUA85cs2h7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRhVr8yZgSqMFkyzK9vP11kemLmKdmqJdW2gPk+sZz/4z1pZrevoIBHZboTDb2+YqMfKrCdyZSBgSh20s3kuf6pi5Pd2reB54QJyqVUu1qfS9MyG94C37bJ4SaNWmTXynkYlF+9qrHP1pckDYqeiTyaeLbmlc3XVSeSBzTCerIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OMMg/HBC; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OMMg/HBC"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-6a144c8f038so3252930a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789553473; x=1790158273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e622UGf8ZvPqnsgwsEF1KHHm7KMF1mCNxmUVRgHGZJI=;
        b=OMMg/HBCDVn4KsbXs69eTm2TCIR+jwgeKK7VR+V91orgJhwJHYbMr34fl5TTmRYStg
         GQOUPlnXM6v511/2RaQYK+Vsjb19lGW3hDZHG0tPhF/eSSr266NYKbPGQn6jd2j9zG91
         XEnNEUWj1G0P9xkebfqmfdkrZ3tKgOE1G8glM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789553473; x=1790158273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e622UGf8ZvPqnsgwsEF1KHHm7KMF1mCNxmUVRgHGZJI=;
        b=H0GYSHjzCzylzKAbc4/Kish7y8gChsQw9L1P1QGkr4SpMP6bfoBY1povsEv0kGYgqg
         UAzjmPO9RQP4III5/kfyBkhkOmTTkpkMEoIIyctwNFxlIVE9oiDHq4lRA61ZcNhbLFqA
         ol8qs9ma/OHPg61mlKo5kQKykwj/NR+5p9rr3DzFF6hpcOnq3Lx1iCbPw3VMJB92OlJs
         LttFKBcnvbP/GVOvgs5NDM6iY52P0lmPOAVZkE1WQtS0qrD4PhUjc0sALT59IsLncUP5
         RWXfwD2MLwVihB5Y/jQ2beDwx9px3YLXuugGG15Bh2KHw+x3YjbKF0JofwWvZAGXj2gF
         N3Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxv8RhEdvWAr8Pv4ojTD0OHe6ix0TKIYj1LoeUYnbUU3AIYBUphObFM9qnOM+4O6h0YtAoDyWQ/kIo=@vger.kernel.org
X-Gm-Message-State: AFuF++mnM1d3iJNKQKlsQXwX7LdIkm2rvdpe1P/j0yPrgJx+cKCoU4wF
	4hohark6WTCP/391otZhsakCzvOUUaXD3NVZHRGKpEGqYYrm+qTCtMeYDiFc1sgNbg==
X-Gm-Gg: AYBFou0qnMOtnNCtDlE5iFEj7fn7KIui3NgaKTfAl9HzIDIiCcf0O6I/WoLySIniiP+
	QPiJBEk2LVL7ENU5tQ4gPlPfI4GrmTXW/14fMRANGZ0tS8iWrjM+vHTcUInMTcj9TtBqeUVFHbe
	gqZDIqBCESDIE8fEnn7OwtDlEG47NQQ5aESfEohWlRDBJgPrlqwd5KzHel1EcwbgYZqDHoBortx
	bdPOvMou1xG40Dm6JqfcrKqn/bRNoXWH8Xsxdt2/2jlxnA1MzmIZ+pVa3aArjkM0mEhiaY1xDZS
	z+io0W1Gm4nC7qsllPhzhkTpaSv/dQ5V1ZrieeJlli9vdFo2soB3wlNYRsWtj+sUHqySjPOGbBK
	Qf9+kKxv4rMmFDJ34atDnWez99mL9rdn1HhTP2meo3BRUGtsI2tO4F+QsOGMWihk85V1o1dlbGI
	IhmL3xL8JR5BwYmqfnOcFSm5S0czqGGYbIF4RSF5MPcS12Mikkz511ge0gObwmqCxIgRIQ0qLxP
	HM0Gxo4UOO1xxV4
X-Received: by 2002:a17:906:c14f:b0:c26:1648:a066 with SMTP id a640c23a62f3a-c29e5308366mr126288266b.33.1789553473036;
        Wed, 16 Sep 2026 03:11:13 -0700 (PDT)
Received: from google.com ([37.228.200.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de6933e3sm106497566b.61.2026.09.16.03.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 03:11:12 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:11:10 +0100
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Benjamin =?iso-8859-1?Q?Cab=E9?= <kartben@gmail.com>,
	linux-i2c@vger.kernel.org
Cc: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: tiny-usb: add Zephyr Project VID/PID pair
Message-ID: <aqprPlSgpqkMmWJf@google.com>
References: <20260820213958.41276-1-kartben@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820213958.41276-1-kartben@gmail.com>

Heya,

On Thu, Aug 20, 2026 at 11:39:46PM +0200, Benjamin Cabé wrote:
> The Zephyr Project ships an i2c-tiny-usb sample with its USB device
> stack, which turns any supported board into a USB-to-I2C bridge. The
> sample implements the same vendor request protocol as the original
> i2c-tiny-usb firmware, exposing a single vendor-specific interface
> with no endpoints, so it can be driven by this driver as-is.
> 
> Zephyr in-tree samples must use the project's own USB vendor ID
> (0x2fe3) rather than a donated or third-party one, and product ID
> 0x0013 is reserved for this sample in the project's VID/PID list.
> Without an entry here, users have to bind the device by hand through
> the driver's dynamic ID sysfs attribute.
> 
> Link: https://github.com/zephyrproject-rtos/zephyr/commit/281b5743d183
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Benjamin Cabé <kartben@gmail.com>
> ---
>  drivers/i2c/busses/i2c-tiny-usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
> index 73355a56aabf..113af96728dd 100644
> --- a/drivers/i2c/busses/i2c-tiny-usb.c
> +++ b/drivers/i2c/busses/i2c-tiny-usb.c
> @@ -157,11 +157,13 @@ static const struct i2c_algorithm usb_algorithm = {
>  /*
>   * Initially the usb i2c interface uses a vid/pid pair donated by
>   * Future Technology Devices International Ltd., later a pair was
> - * bought from EZPrototypes
> + * bought from EZPrototypes. The Zephyr Project reserved a pid from
> + * its own vid for the i2c-tiny-usb sample of its USB device stack.
>   */
>  static const struct usb_device_id i2c_tiny_usb_table[] = {
>  	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
>  	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
> +	{ USB_DEVICE(0x2fe3, 0x0013) },   /* Zephyr Project */
>  	{ }                               /* Terminating entry */
>  };

Thanks this makes the Zephyr side sample way easier to use.

Reviewed-by: Fabio Baltieri <fabiobaltieri@chromium.org>

Cheers,
Fabio
