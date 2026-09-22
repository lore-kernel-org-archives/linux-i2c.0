Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEF577E2B
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097596; cv=none; b=YA08gdoB+dMTfDydx0pFrB6UcWGiVD+dxFntEzVbbmsRx0ZSxRmL2p83f8EXEmNusdM44dLy0tcYY++I8HGYqRiH9v5BnfikHTqbskAyMEvmqo5HkF1vth2oixHlT8V0oAz3vWit0Bgd+YugwzfhrY5Kgx5af+cvYSInDl9CS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097596; c=relaxed/simple;
	bh=6wTYl3fPn9nlTqWjvYm7Nq+9tWOEygh9IVzIKdiR2oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkueuY3hnDq2bJFZA2O9Ls/CEE07LVnYptGiXpFQIivAl0hFuJDmudQQzDEyad+yQwAFN4XNJserhvyhyBDatp8jtpQwfGtJGGb6WYrAxLMPjkagg/T/Ng4ordydURt5S7nWHuf7xPlZonRAihtWOJXC+A1ktgO0M7RBVSj+qSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3fpi2YG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3fpi2YG"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so143887a91.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790097594; x=1790702394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
        b=R3fpi2YGR1iw8Px21lKPuJxQa3xYXCv9Mpn2pp7nvZTr5cx5S8aK5HbtF3oqZWIFQM
         RMZ3C0IacF5arX5aUdVWDSlMSotuYQA4Op5VFEMGn055iG+3zTrz5B/Kf8iog9lSXhZZ
         B157y2CkT0mf/XtYGvnhueJQMfUPdVjeLDGegSgXKkejeOexHV8Jc5oDbrKf3Z2qa4mD
         hts7qgawAiOZuCKQsdQAw5yKxpocn841NQ5Hu1VNYbKlO1f/HGPcNH19kCYQ/UPmaqF9
         OYKbnmqRDwKR6tzbt0XUMzLli1e6tFFAlATxO9QSteifnJPhfcdMvKQ7lvc6fqOdrGg/
         xkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097594; x=1790702394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
        b=kyLsToE79iYpmzQVfDFQETh07xrQSJWSm81ERrJYIuZrqOM+ix2mtdebhp+dJXRPGe
         yROJCkeOI1MvlEjl9c8WraGQYcsHaQXrtQ5jGrseXoo2etDeIuatbz6Gd1Sffy1a6KIN
         2YxndT2ZYwboEIq5hZMSlf24/3AgRX19PU7d6kHyfr023iQ+f8bsmetmHPkbrDPjwQBc
         qCZtL3ZQTxycAbgcXT9yrHKsH7BPVWPLjuCkbQla+goGDdF7uLY4ww7jY4N1VJwqpBkC
         ajfk/XF8117yx8e2OkI6BtS0Jf17kTKxXjSOM2rjZkJz+mId934ZB8qlNulUHarAAZTS
         B3uA==
X-Forwarded-Encrypted: i=1; AKwUvBzwiMXTUFHpC7j39sz2f1dmHUnQoxlMuTn+BrI9c6LQxIMscpSUVd6+ETaI60c6wjKcsJ4nHh8BOYo=@vger.kernel.org
X-Gm-Message-State: AFuF++m14V2Y1/9KmTgF8DwFXpbh06Ww/T5AmzIw406cXCQLGHb3xJbF
	c0HWddT5rSgS0xMmJjmBmmX7rRdClHgFD477GchbEMEvAR2pv6X59s1Y
X-Gm-Gg: AYBFou1tlscBqP/4yzknz2IvSPbRjUxf6N5ckPa2pOSSOwsh28G9Ba2VI/JRA3TrIrE
	jmoK2dJaqKWlkDxPwCWgNz4ZJ1DBjyel/MKFvFXxpE+/AfARmDYabBvogScBrTEHuDs+nRrMiu6
	WgY9wb5qL52UFqWouyFUIrvj2vCcvGH12o1ylR3OFk7T+OuMs726WSJ3MRGCvUp0JgK5vuHVaP2
	Luu7B1Uq92J84yRbFHRLVU2qx2zhqvhz0nS6HbbdxAXKnzHg6E3z5r7bYGRYZj2xEBR0jODZyZb
	MkaNVImy3q7Kv9WDrIOK1mZfIQeDJb4+iwhRxrg4UB2NboL44fnBpJ6mOhNpdMBNXIVBpZQII3v
	RIFYENvLEB3ZxgxSSB7m7OoMCwJDIuHNFisZXBOy2xR7f3jlrO0LH9Lu9t9o0V+yJuQJ+m26ffH
	rcjkPBKTyH14mBxnwKNALLvLRuQB/VpB/ZykaI2wZNuZUlrSc6Eps7wfFasiKR887OFTTJ7AZ65
	FMoqabfgxYVGw==
X-Received: by 2002:a17:90b:2b4c:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-3a07e4f7b61mr128059a91.2.1790097593735;
        Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddaf4f5sm336767a91.4.2026.09.22.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 10:19:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <940e0763-9de3-4d55-90cc-8289d5525b17@roeck-us.net>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to watchdog-next.

Thanks,
Guenter
