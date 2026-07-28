Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C53FB7F1
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272269; cv=none; b=k2kiIQ1D+FuiaP6FG8CB3QhVJrEZL40/b57epi46QFwc8DFcBbBDYqhMjD61XiIkOblU/j4NfjxBPMbSfbsWi6Xbs3c++B+uwBCykd/Zb5tQk14FBWH95vX0h1sXmN8g554ijVKT5vVESFk+A1Z8zUUhlnPYKgZm9UPEuRlczhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272269; c=relaxed/simple;
	bh=pp6cMPDGEoyvxUAEAodoMlmAX35D4rEQic6x2YXFrAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjyVramw48gwlLJnm9ibxQtYSFzulXAXU+Ia3htHrqOI882TDEAjPENBdWdOyP6R834MXi10YAu4YAo8jEiUNqg9t5tvoU21uz4nQGwCVl1kQPo/eXMufLpzLJIps/gf7SG2HEwA7a+VVxoyDLo1xlegW6UGgYVJ/upoPb62KV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCfXXEG0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCfXXEG0"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca913a601fbso123511a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785272266; x=1785877066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGBo4mzkQGDipH80tXiWUY8LE+Lu9hX02+5XGAA/YIU=;
        b=DCfXXEG0Sc9/CuR9L7VDaQ91TWqKQWi9KwCmSXonQZSFNriwxjACGa13VIJZ56mgCJ
         7jsCj9glzeYFPZ6b61cbdGJbvF/j7ql0ybUqcgvh4CM+Rcb79Cp5DuiPEyuGpHk9JjJj
         hprtDCozg7tDdJBtTu7WdG1gCzDmglD1/yidQrfzdJLBArILr8h84cNvCAxUCgPYcqxF
         5A52cyNQXVbN407pVzXtt9o2shMaoCgYWGUJVOguVKHO26Sv1PpK+DdEve6Zlt7QVgVW
         kW5jdchONR2i6hMLvUVE75M/3/TzNBVGoXE0OVIBjznyNnNiX1p4wBsRuRMDMO3ums98
         jd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272266; x=1785877066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGBo4mzkQGDipH80tXiWUY8LE+Lu9hX02+5XGAA/YIU=;
        b=rnafkf74Be+ixkBbmL5gt8UPPmfm8PXqb2OdIyZ0bcMBejUCXNjJMB2Gxwzj80aNSm
         Xnh2hyqhMK7ZnHzmn+lnAoNro1HgMTzYVvOAkd8Yj0Gpj7ORlwEB5FBf/3LN8uKEB/cP
         HCEX94Z8UTnvgppM8PyRYYsQbQWETYF8hE+1037s3sYIco8ikxtYlQnhbgLZxmfXm1nI
         dboJra1jBz1OGqck+3eEv0S+USeJbvM/BCz8kZfEjATUsrA2d+DKoS85LB571GJYWLNS
         fA9QT4eUsckRpMRz2yuB0nh+oRsB31PFVVfg0pBu+pGdEb6oU2C47JWe65JYWXQrUUpE
         He3A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2Xal5PbOjJpt7Auw7BBk9DdQgTEGzzxAmRu83cRaCVhznkW72e+MvmnHNujnNjKdYSu3dUy/AVpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMTPHJMVmqSNvlbElDvN9AGRmrkLLv2yvANPt/Hv9EoORWWtN
	lGkQWKuQTokr1+2TAkazRFekSFd+Ib62Kd01zFzPrbDhaPuB20cXcxxG
X-Gm-Gg: AR+sD13gUturlG4nAHp+Bi4tEGj6QoLSwCIBJE9v3Jeil+zZGhRA0IF2AXdHNt7GRSk
	vc9EbU5wPUadYBvCIbfQ9GaBJ8TMRnxf083TpD2wuO4Y47B8Mct99bEdCQH6ANSTTKzaIP4ZDLW
	K4/FKpB2ZfAp4U7EhRNiZiGeP03BHHefx9TpcAmneFHB95sAcJr1dufqa6XqAJXEzMBAWVXUz2l
	dzupW8ZUOONcMHFd/vhLrKdqDmP8GuxBtrVK89XCSem3UreGLdOJt64YKOGblHw4tdyybVgtIZ4
	TjTwNnW/U5UUK//yKTpRyeE+9L5rlkmUr5tDWvyzmC7Npcg3VmYyczdnU00zP4qBL4ULyCx1yIg
	+xnMCuSCgOcwyAop21fmC7fhrjwbaOyrifZhRJhsgrzY9aW5J+G3PK4Fld/F0TGxnQkuPHXk4Rn
	D+GP/3NGTy70RxwMImFSeLQSbqXUA371+NWY2YY2Q6ynY=
X-Received: by 2002:a05:6a20:7f9d:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3c8ba545762mr4766802637.36.1785272265674;
        Tue, 28 Jul 2026 13:57:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3062:3727:f62a:314c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d3250asm1815624eec.20.2026.07.28.13.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:57:44 -0700 (PDT)
Date: Tue, 28 Jul 2026 13:57:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <amkVnPwEteFKjRNY@google.com>
References: <alWiYfNDrOfo66HM@google.com>
 <amkE_TftCv75VrJC@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amkE_TftCv75VrJC@zenone.zhora.eu>

Hi Andi,

On Tue, Jul 28, 2026 at 10:30:33PM +0200, Andi Shyti wrote:
> Hi Dmitry,
> 
> thanks for your patch. The core, indeed, does not know the size
> of the caller's buffer, so this can be, indeed, handled in the
> generic I2C code, instead of delegating it to individual host
> drivers.
> 
> ...
> 
> > diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
> > index c277a8e1202b..4df5330aca00 100644
> > --- a/Documentation/i2c/dev-interface.rst
> > +++ b/Documentation/i2c/dev-interface.rst
> > @@ -161,9 +161,10 @@ for details) through the following functions::
> >    __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
> >    __s32 i2c_smbus_block_process_call(int file, __u8 command, __u8 length,
> >                                       __u8 *values);
> > -  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
> > +  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 length,
> > +                                  __u8 *values);
> >    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
> > -                                   __u8 *values);
> > +                                   const __u8 *values);
> 
> The kernel and userspace APIs should remain aligned. If the
> kernel helper gains a buffer-length argument, it makes sense to
> consider the same improvement for libi2c.
> 
> This requires a coordinated i2c-tools change. Updating this
> prototype here alone would document a userspace function which
> does not yet exist.

Oops, I missed the fact that that document is for libi2c, not the
kernel. I'll drop this chunk.

> 
> Wolfram, do you have any opinion here?
> 
> >  
> >  All these transactions return -1 on failure; you can read errno to see
> >  what happened. The 'write' transactions return 0 on success; the
> 
> ...
> 
> > +	if (length > I2C_SMBUS_BLOCK_MAX)
> > +		return -EINVAL;
> > +
> >  	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> >  				I2C_SMBUS_READ, command,
> >  				I2C_SMBUS_BLOCK_DATA, &data);
> >  	if (status)
> >  		return status;
> >  
> > -	memcpy(values, &data.block[1], data.block[0]);
> > -	return data.block[0];
> > +	ret_len = min(length, data.block[0]);
> 
> I don't like silently truncating the response.
> 
> If the device returns more data than the supplied buffer can
> hold, the caller should be notified. Otherwise, a truncated
> response is indistinguishable from a valid shorter response.
> 
> I think this should return an error, for example -EMSGSIZE, when
> data.block[0] is greater than length.

Yeah, I can do this.

Thanks.

-- 
Dmitry
