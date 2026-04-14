Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A21EB5E3
	for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186316; cv=none; b=eFc0pOox/UeFswJdV93048e3hIqvXmsMpImZZBBRPJiOXuUnEbqV7litcjmAKd0D8djSh8tvzWtIVrVBMQo+0ViCtvBBvRi8aoMEItRmvMWfIsVK/oApXFOVd++LYlZZjUDGHzPVsgM9GkfothWOPwRzAdD489pZS9RFw4/hoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186316; c=relaxed/simple;
	bh=WTBuw93b1FoXdiTf+ccgKqIkAq/vVQHDLivoX9bjrc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kewJdrfPJFi6bRqPbg926suaNFP09bt/Hy4jOrGFk6dLdzTLiTx6gKT78uwClGE1QqK4eVRoRj2VCO2kbYsw3ssNe3ARXWO6mIuXMEk9haNKjxwBeKgeRyYT7IOBfu3DhUfyre+wxdabGUvMV+pVmQmHBqdCydcXKL7N08VrY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lse/8cWw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lse/8cWw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab077e3f32so28014575ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186315; x=1776791115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BfDHSzCeSREz/dP7uAmnGq3TsH/et6isuhvmuO8qLE=;
        b=lse/8cWwWueT6zLmegh4uBpmumguexknFcfyPBuyuzQntODxGyJLAHCsuMUzUdU3JS
         sd7Ttcaels9yQ7oAAUjhudT62ArRpPlKQFS7K4jtZ1q2sl3bzOyhk26TKzwFFYJjBnZR
         W7bwBkAhcy/h0ALU1FYTujNdX1aobX+Zi8oiynT4KQIichaWcmUZDwaxQ+t5wbnoR4L5
         rhcKKDv2UN8RiQG9pspi+cN2DY3iS2co2jm+I0/1p1yoFaNOVhkKbyAQrTQJVJ2opkKe
         O5XmKPgPdgQtqh/PVR+UXIONU26eIl5xkkQHGl0AP2odFgICstnsGqF3HqpD6vkCVVSW
         8xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186315; x=1776791115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BfDHSzCeSREz/dP7uAmnGq3TsH/et6isuhvmuO8qLE=;
        b=eI+rPSH7jSIWAc1r1vea1cUwbZ4WY6SsnxZU5I2HiMP7I1PGyNE7QtUVmCqCPeRg4E
         fjlGRzeOo4134L4XSK+BuOUCDyRCZJugKiYv9bUAp9ybtg5lKxoEqpMQtZCKb/N2M6M+
         zG6W/5iQqW1/DEL4h16kMmELATaB4mH1dwyI7XmD1CRz/6k+Ohb/1QoXUA/uU2a/Ma/k
         HTBoKlaJpW8dyidadUPFq60JATp2g9IdBjc8c56Ot97kMXajKoL6zl7u0iTE5J6Ypwvn
         FaYVuuLbK+5OnnGIITFnYQfOykY7+SXzF+2zkI5D6VbOY0gp4VvhqY2xW4WksRavD53U
         INVg==
X-Forwarded-Encrypted: i=1; AFNElJ9zza3dghLgoRutcEAXQRgjUni1l7BRaY5cj+3OlmEDbyEo3EIVKR5rqYBnfBlYWJysny773Jpq5ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMi0jyoykMBc/V0yYv7LmDz1/12ujf0oov+9Ah3O1NZ4LeNoa
	8bPYOGbisyquLZqKEmVrL8LBT/+xcMZ+EoZ2vXgqKj+KD+pEm5KYjmgm
X-Gm-Gg: AeBDiettvq6eMCOYBXIcbWrqQYbxb4tMmbjhOS5cHFrSBL1oOSKnjSDIgkb5QruqF00
	h/M/00sZh/CzSbE2YU3aTLf2HsnS4EEe2351uet9vOXyRYfZWtosK7JRHVE8IMavfe2VvPAkPLH
	0kK86rMn56KsWnkPjUd9tRnuRcC1c2ShFEJyv+0u47+7jXpFPNJXLljHwOQwxCana8wRUWuRcly
	iglzeNIj7aGVxQI7vJfRmHTqIrOARZp4aUxbr62CXqayoXz+mUsVXDxTPCFW3cVt67eWxmVL2IW
	LzG7QZJAB7eME9SguanDGq+HM1sUSyhiYrKgKdK/Ms/VuDvcvOPh44WQgfHcD0RhUITakPUOdRK
	D6lGBKkZnLmDQSPH5JSzwjlL6ZIaKv2t/LRReDB+f6pO3f57myB8DWyedS0CUnjJ/yEaGXVzaDQ
	rNdLVTlXkqkHRInNKUMm9sG0vP5yE/acYAt88+dXeNJbl11F8rB7qKl2Cotm6A
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr93427165ad.38.1776186314338;
        Tue, 14 Apr 2026 10:05:14 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3ab3dsm163655085ad.74.2026.04.14.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:05:13 -0700 (PDT)
Date: Wed, 15 Apr 2026 01:05:10 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: stub: Reject I2C block transfers exceeding
 I2C_SMBUS_BLOCK_MAX
Message-ID: <ad5zxsFtxvuCpkXM@SLSGDTSWING002>
References: <20260329164126.820797-2-bestswngs@gmail.com>
 <20260414172239.7e98a0ae@endymion>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414172239.7e98a0ae@endymion>

On 26-04-14 17:22, Jean Delvare wrote:
> Hi Weiming,
> 
> On Mon, 30 Mar 2026 00:41:27 +0800, Weiming Shi wrote:
> > The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
> > as the transfer length. The existing check only clamps it to avoid
> > overrunning the chip->words[256] register array, but does not validate
> > it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
> > i2c_smbus_data.block buffer (34 bytes total). The driver is a
> > development/test tool (CONFIG_I2C_STUB=m, not built by default)
> > that must be loaded with a chip_addr= parameter.
> > 
> > A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
> > with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
> > stub_xfer() to read or write past the end of the union
> > i2c_smbus_data.block buffer:
> > 
> >  BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
> >  Read of size 1 at addr ffff88800abcfd92 by task exploit/81
> >  Call Trace:
> >   <TASK>
> >   stub_xfer (drivers/i2c/i2c-stub.c:223)
> >   __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
> >   i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
> >   i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
> >   i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
> >   __x64_sys_ioctl (fs/ioctl.c:583)
> >   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >   </TASK>
> > 
> > The bug exists because i2c-stub implements .smbus_xfer directly,
> > bypassing the I2C_SMBUS_BLOCK_MAX validation in
> > i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
> > function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
> > I2C_SMBUS_I2C_BLOCK_DATA case does not.
> 
> Thank you for the excellent analysis and detailed description. I agree
> with everything you wrote above.
> 
> > Fix by rejecting oversized transfers with -EINVAL when
> > data->block[0] exceeds I2C_SMBUS_BLOCK_MAX, consistent with both
> > the I2C_SMBUS_BLOCK_DATA case in the same function and the
> > I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().
> 
> Would it make sense to also reject len == 0? That's what the i2c-stub
> driver does in the I2C_SMBUS_BLOCK_DATA case, so it would seem
> consistent to do the same for the I2C_SMBUS_I2C_BLOCK_DATA case.
> 
> > 
> > Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> 
> If there any public link to that report? If so, it should be mentioned
> here with a Closes: tag.
> 
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  drivers/i2c/i2c-stub.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> > index fbb0db41b10e1..349ef9fb2fdbc 100644
> > --- a/drivers/i2c/i2c-stub.c
> > +++ b/drivers/i2c/i2c-stub.c
> > @@ -214,6 +214,10 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> >  		 * We ignore banks here, because banked chips don't use I2C
> >  		 * block transfers
> >  		 */
> > +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> >  		if (data->block[0] > 256 - command)	/* Avoid overrun */
> >  			data->block[0] = 256 - command;
> >  		len = data->block[0];
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> -- 
> Jean Delvare
> SUSE L3 Support

Hi Jean,

Thanks for the review.
I'll add a data->block[0] == 0 check to reject zero-lenght in v2.

The report no publick URL. sorry

Thanks,
Weiming Shi
