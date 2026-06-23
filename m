Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FE2C375E
	for <linux-i2c@vger.kernel.org>; Tue, 23 Jun 2026 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192247; cv=none; b=hGeOThGfZkojfMupovt/7/DdJC124QKGBiO9Mr2v4LwqjpGkU4/6hepE195W0wcojxGyCgMk84RON67UqLsyKwYZEgcjGirXaEylxBU3oYXQsk6eUmQXeOUlpFuoH/4kCZMqrQducc49Tt/BZxObOF0IWZZ0xv6mDYgczwHXI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192247; c=relaxed/simple;
	bh=4Blk7sBC5Pyt2qRm+LBFR++263IVBnMbyxzxLBYAARk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQdpXyyQSENwh2fY0BmQNrXRNGMPAhYOu5u61/9HV08ANcUwHZ0Vr2SO96LKmDUZ62Is/w0v8rfERlFAuckPTrvV/6MMWAyx7xttdDRqazZ+OqZXlqcKwRw5/cGHVGaLsfVSWxIMhzUKSWuzuwUL6rHxKyxRLWaeC6yuSRYoJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn6ujqjp; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn6ujqjp"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1363fe80fe8so7309008c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192245; x=1782797045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlgnE36nEB31kjx0F0SU25BmzIL5DnY8cGWLmeitAjk=;
        b=Jn6ujqjpE5EFgsR66Rd/oFS3lJIDKGT1zSiDxbvjKG01wr0RXfpzWl3+F9AMAyiJnr
         RILzT8YzUOjjRwkTg7fmlDZB6b7vFHxELQ0l1sBQ0N41DUYFWM6GLZGfTMO9Aq2Ae33P
         QykowD/ibgmDY80EhqSY6OmfsENI45tdAAIvNacwt/HtS5qsP4e663DSI4xyENg0u0Jw
         nkAh9x310Om0Us1lK0cRGWWu6WfeKtmtG5f42kbz9Pj/ZwJxTPFLq4Ag7jJNLBj1cW+D
         09eimbQOuqU4pYeZGbVTRdIt9MSE/SsIUT8y6YudrB7f7Xu47D/Gp8bQEW7QoOWgLTdC
         oXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192245; x=1782797045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlgnE36nEB31kjx0F0SU25BmzIL5DnY8cGWLmeitAjk=;
        b=MvMTjqI+pDOr39s5dgmDp0hMuC/8PVJp+jaUMK/7Ow3+cOHbP+Ra5WjcaeAol0CpYW
         gpyQgjYLhhidfLIPmLERKDML7py6QA18HDtHX3x6fORvXe6DCS4Mvc6aJ8EHxojOQrff
         MjTKx5agqKA1y7qBf3I77c0fyV248q3lLGiNom/J+CDyAuH4x/1iYg2UABQWb513KmK8
         dfANdO1yzaFb5T/9uRF/vk1OUz8lKhakqGXtXGimwKOUZLghG6pRj9xo9J7U+z+Y6NYN
         xfcuQ2NITwc7WXOSeDtsMWaifWd0JlXNRpK1jgOzNvb6g/Vkli/ywZWfopAadAxzwmuQ
         GVtw==
X-Forwarded-Encrypted: i=1; AFNElJ8HwseNoiiUB7HIfbD0HLm9UbY3/LAutKqs2XnYoYNomJYI5H5K7MnEasDVuNuuHjoP79VmVlMwnrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIZb2Zm/2s4eapUstUUJZBqWH5TGCShVJkYVmpZO0fhM2rI9m
	DuDUpheI8OJDWkjlZFP3D9PnmUCpoxo0UuXkuGA16TQsaUhbCcfcLSpT
X-Gm-Gg: AfdE7clYdnF3M4N5yvdLaVk4XyacVTTbPRLFPgJIzvNkDECTN9vzWtHcsCBVkirWNfa
	s4WKPm/13mtdRhYxn50a8482/DRpX6/6LFsSjUUh4pqDYybnqO9FTpz+XQARVxkJUU99Jhxedsa
	K3TnQNIxO2A6hOvwSjZ0qwqPUfw8oxW5s708qvfrkq1VKVx6zhffnETUezQeS5W28e4TqUVmn2D
	cNMWvxYoFyjVSsLDeiaiYVm8CN9zSW6t9AHXuxgWHKF0TFdi1TpV2Gj2JqMh0NPjGTS/wYXgt7o
	Q/b+LB5S4Ncw6v3PEZfty95NEDpuIXXgonm7Z/uI4MNrLsJ0MDjL2PzEtTemCwGS+dJiwiYlAF1
	EnVKTjSMB5dOWSjce6Rut7gYD+ZwhnQqVDtDxp1PPn7kQELP9Z1xZmhGxn7Q+CzMsvCjSnPB/Gv
	RbvYmrhBehxg1pWHGc7E1fF02UvaU6334jtVlXR7jABu0iLNp3IQOxEQ==
X-Received: by 2002:a05:7022:6093:b0:136:ff02:d00b with SMTP id a92af1059eb24-139a38806e9mr10415016c88.25.1782192245424;
        Mon, 22 Jun 2026 22:24:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d8d:3bdf:d563:1911])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adca1b00sm10508406c88.2.2026.06.22.22.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:24:04 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:24:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfram Sang <wsa@kernel.org>, itewqq <shipeiqu@sjtu.edu.cn>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bryam Vargas <hexlabsecurity@proton.me>
Subject: Re: [PATCH] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <ajoYKOBRXc3HrH6a@google.com>
References: <ZxGrwObOFkNuCn_w@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxGrwObOFkNuCn_w@google.com>

On Thu, Oct 17, 2024 at 05:28:48PM -0700, Dmitry Torokhov wrote:
> i2c_smbus_read_block_data() is dangerous to use because it may deliver
> up to I2C_SMBUS_BLOCK_MAX (32) bytes, which may be surprising to the
> caller. Callers tend to allocate buffers of sizes big enough to hold
> data from a well-behaving device and do not expect that
> i2c_smbus_read_block_data() may attempt to write more data than
> expected.
> 
> To make i2c_smbus_read_block_data() safer to use change it so that
> it accepts size of the supplied buffer as another argument and ensure
> that it will not copy more data than the size of the buffer.
> 
> To allow users to gradually transition to the new API employ some
> macro trickery allowing calling i2c_smbus_read_block_data() with either
> 3 or 4 arguments. When called with 3 arguments it is assumed that
> the buffer size is I2C_SMBUS_BLOCK_MAX bytes. Once everyone is
> transitioned to the 4 argument form the macros should be removed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Wolfram, any chance we could get this in? I am getting patches for OOB
access because of the unexpected behavior and I'd like to fix them
without doing extra memcpy().

Thanks.

-- 
Dmitry
