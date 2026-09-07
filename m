Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAE3ACA4B
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815894; cv=none; b=rTAUy0uu1EdOSk7AaskCwNOGfCBiGtcHAYNjsd03CpM6JVRxqopJWK4qBPTW7Z+z9K59RwdcJjFPAeNIQSre0tfCgoa6MEdg6StF5zywKguYbWP5E7uRh2ZSK1RWm7sYQWeq3GSR7Lg2mmXkuRAoiXMzEaViPjQCM33qmsVSN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815894; c=relaxed/simple;
	bh=V54ugBeoLmdEM++EBtsJF6c8spGpOIcxasxQjxR7p+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=auK3nZz4Pmb25tBm1gBMu4GhbBGYSPz6RrNObnYsHL2gx7lwi1vla8cGdbymIaJ+qMIg+1pTexMvVx4QnaVHXfdw4+CSJQGuLMFTik2bcEyngo50otIRCx3K/vgvN+ZQPaMmBMYESBIk30W6Omr6nPThyMi9qrpAhxGN4SIqjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=EZadtGJP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="EZadtGJP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2805782a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1788815890; x=1789420690; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V54ugBeoLmdEM++EBtsJF6c8spGpOIcxasxQjxR7p+E=;
        b=EZadtGJPKGqqK97zuS0U2JGVtk+Kdq57oAWXBm4TBfyOx0ZPmbRLTJxlEFosYLrD59
         jF7OdlnwExpF3fnbuqA4vpkego85l68SYCR1XD8Mq9UCfKHqVKDXVcaX3rJdb/KAxtZO
         gfh8MNkRsie3L071iGCQXCKzin44C62u7FKzol6UhBbwQ2S5lcRYzb8cKFWZEnL/ijJu
         OGeRvw13hYrf7J2oEy7m/xRi/hKAYjj4V80R0OQn2fAu75sJpxzkSyCR5z+fO7gZBjP5
         p7Hph3ExlBjVK/QPFzQlmt4skisOhI0100EdvJF/N1mFGikYjelr3FAR/FZ0chAaAdSF
         A5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788815890; x=1789420690;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V54ugBeoLmdEM++EBtsJF6c8spGpOIcxasxQjxR7p+E=;
        b=f4DHFTOAXzV8MrNb5eMdaTw6hShlwvnjtEu+WgBK9NXxwi7cG14sXPuVGk14onaSs6
         KABMyjE5lD2G/S7dO5r0/EGpDvf23irpHMhUwJ+T4q4Nb1NIEGaSo9ErnwkoKjkNYYxL
         EXtai/BWug50QSgrYASLWs/bw/Eyt6heGKzPUjgbZoSLV4kbWOQvy9OQXtlLg6RYf6Qf
         KVqqGfh3vvm6bgfADtjkjVXN/t/2qhuxS4iamyJUQbvwPa+9iWUaJq10lyC/OUJfJFPE
         Qw6vfOlpwztYFBq6vbqBnTbBtbD+DxqcET7zdb677lRc8MMtsrdErREbSFP2F4iD6xA2
         2GBg==
X-Forwarded-Encrypted: i=1; AKwUvBxdCbVlvbUDqWY7yavNvfaeQabOO+q8V9MlVjrazMEiOKXI6a3oC+sIXgSjPLpDx8n/O14+NNdclO4=@vger.kernel.org
X-Gm-Message-State: AFuF++mNdbSshW/nLH3M1/iGlhMUqI51r5VDTDkO62Cz/z63dLfjB25o
	SjtVGzAKAZuVkukF5RJVwPFkMAhjKlquuxvzvNqPh0hOq/X29QQEmncbpFyO0DCCLk9iLsAhz1M
	DAvsl
X-Gm-Gg: AYBFou0iDO/LMjiqvoOooOXrOKUwPT2IJt1yN8M+U4mQlpkOkNuRyBea8p1K0b8n0MK
	ULc/MdWDjJBFF0334kWXR8MOlUc/NmpuhIx53wLo+8NtqALKppszzghY9G8D71w2nDwpEq9uyK1
	ymBTvsWjcdPZNvszOxMDBERlqhkXnVfHYWh26d1ui7IJMEhxL8xTG+gGMbq6CIbhThUBKoKfVtu
	eK6VpWQr3lbdlIDY51hSuUbd/ELUxcgviVbnXw40nZ3NzRruye3VGJEimJe+AIIE3jZeTtOBa3Q
	6ZPqq1TuxyRa84/oSCrXC5GD+2xYATeHsafPQQ+kfd1qtsH+2I48nP8doFrhlo4Dl+ysUfcxgSZ
	wcuK2tbbnMLhI44pA9UVMLgYhDs2d1PO6uUmn1yg3SrFxuZYVVuqWYE5MspCF6CpRvbCc5jTIxW
	UlJzTlRj79tkYb/YKYT0FV0mtEqc6oAbhcoEPmG5EIFYjC9w+gpi4jn1heO/5jrjwHHvez7+TaT
	peRMlTu1tB/J09r6Q==
X-Received: by 2002:a17:90b:5826:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39b261b07b6mr39475479a91.10.1788815890606;
        Mon, 07 Sep 2026 14:18:10 -0700 (PDT)
Received: from brighamcampbell.com ([2601:680:c200:5c88::1fa4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm23155281c88.8.2026.09.07.14.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 15:18:07 -0600
Message-Id: <DL9EB60C2IIA.228Z11CQM65Q3@brighamcampbell.com>
Cc: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 0/2] i2c-tools: Make tools accept bus path
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
In-Reply-To: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>

Hi, Wolfram, Jean!

On Wed Jul 22, 2026 at 2:52 AM MDT, Brigham Campbell wrote:
> The purpose of this series is to make i2c-tools userspace utilities
> accept an i2c bus character device file path as an argument. This is
> useful, for example, if a sysadmin creates udev rules to create a
> persistent symlink to an i2c bus and wishes to use that symlink with
> i2c-tools.

I appreciate the feedback you've given to help get this series to v5. Do
you have any outstanding concerns about this series? Is there anything I
can do to help get it across the finish line?

Thanks!
--=20
Brigham Campbell
https://brighamcampbell.com

