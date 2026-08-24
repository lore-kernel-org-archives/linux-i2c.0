Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E5364EB1
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584592; cv=none; b=g4Pmk/D2qdyarsbUK+pSZivY7uq2Bg5y1uC4+85YOS4ijK2l2nfFpqi/BXylA6yChN1K1JOxWxaOIp6rQGwRD0H9F1hWSh+mdSMuW8Mhir30VlqM6u3GgsF4sId1h4r9QhJIbWkD4z41XtYw2fo2YJsVwuU1wZSkPGLjfAlvvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584592; c=relaxed/simple;
	bh=s55TdVXCadSeUHxoO8iqmpRHfDLK5jShkPGaR9oAdFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC/UuhqnqqV1/jZpaJsoE7ivNruTWsjUA9d8ii95555Pkau7kEXKinvmVdfa+4IJwCvN+AuoUyM50ZNOoCU1HEx1V4WS0FrUJ/R0AixC8iv9qBDZoPnLtYn1SuKRlvK7yn5Pw/HTqgARXpljTDXVFyzyIDu0da3+QhW3SkcI+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCTI2Lak; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LW7lF2p2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCTI2Lak";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW7lF2p2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz4z837SgWBU6BZap0nYTTwDo8TkFm9YBjxokHawMCY=;
	b=fCTI2LakGRuzqVsi9B++2Yf0xLg78TUzHndjn/DUWEvl/nYEXtl8mp8lAkfreYIrCHE0u2
	s0NVY6D1CyNnRMWwSvC0ZNkt035+mIIwPskEl896XgHTx7H6wID2XbZ7sRuk+4hKqHPQSP
	igMsaQK9UADiPC5reZs7iSwaQCNgtR0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-vNdVoxlMOJKUABH2NNeeng-1; Mon, 24 Aug 2026 11:16:28 -0400
X-MC-Unique: vNdVoxlMOJKUABH2NNeeng-1
X-Mimecast-MFC-AGG-ID: vNdVoxlMOJKUABH2NNeeng_1787584588
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso74302821cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787584588; x=1788189388; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nz4z837SgWBU6BZap0nYTTwDo8TkFm9YBjxokHawMCY=;
        b=LW7lF2p2uOrpj0R4ibagPBjAc0OiMUy7VBAkhxateCV+vxXOtR6FLW8JHbG/8YJCH1
         ONMaHjKc/fQ8gPS3f0EW0Wyro1NVnDwnf1ulNuUMFCNrx3hhgsT6vGOZpJvFZJ8wdmVS
         o/bkPLdMmquhP4SPI6kZfEkB61cghFGogl3qsVaBAxN7abS13cpUGjW2W709x2lTgRGv
         3AzxAPQfwb4MwYautt09C+j7GCGbDWNk1Se6U6SbXJS0ANjwfVQaVojSaemuF+fmQCo3
         8+jKcZayNdnKgN2xEih2Mx/QrUhG23+3SMW9VKi77Y73pdkw5GebLSmFczFSGwNkErNe
         O7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584588; x=1788189388;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nz4z837SgWBU6BZap0nYTTwDo8TkFm9YBjxokHawMCY=;
        b=HIo6FfNdGqJHp0r6YL8LK2EGll54Fppw4wRQYQLOF4MQFuJWUzIfns0mVkPZDEdvSI
         xXDiei568OXZSmcou8lhulHvxUyhEsysG03iRDbRU34yV5D8X9KSpeTVJD86mfW1HTrA
         r1o63UjF8lbsaWkuX5UwHNKgcdt4Ikuf5DdOLC512/5UO+KxXFo/tuVVprZDhqXLFKvy
         KkuZvG466rRM4Mu2ssG+Zglvsxc9BsRQX8frpfvCVmNsjQkM5dGY9czYac7WjvOzh8m7
         mIfr2xx0stOtO7iuzc5ZvUi34m4/8Sj+joFBO7ahClb165r7ctFB2/cOjyh2mjoV8B3B
         b5JQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRRNISdXcB26TggV7rnkGvBZeoR0q2n86sxTfnS/b43tJOXtg16lcYL67JXSiU0HPM95Odv3rZes8=@vger.kernel.org
X-Gm-Message-State: AFuF++n21Q/xme7IUvXw4i4T37G4f9of62Tn928FxkKlV/jTjA7YDtlc
	13vEsm0rF46593lgTOh2NjKT07zQUQ+EVYVY67EPKbwAVBMA5datn6YgwRoKOhED2hpHFyHDZxu
	relJOqetIxHR+D6PG1UbtqM1as50qkfR+7BcX9o9lLna/h7Tk2bjiGUyyQW+g4A==
X-Gm-Gg: AR+sD1376FE+Gbzk+3vlqKKjJ1wak/mXCTBlcQ5mzVepBjRDuxk4a7/+faPG5a70Jyd
	fGo+8JPTw7Z2kgkhJdK+PCQzUlXjyrUJFBIb2DknSv+21niGwo/1nblNxj2la78sWXqHW0Nf/al
	Xv3wnbzUXvPLPSWlFQLmyLJJe3hTOCn0VIcPeDNswzfRk6FFmJwXLRfqc3jJLa1dXMvEcw9aFBy
	Uax9NA+xDrdqJHymRNq36FwOcHvovcqOU29ZpHb/UFlqGUYZp+qzVTm57NJ88IEeqXt9rJSBSKJ
	NeIo2xZcUdLTOMBQRBTuxCJTBh/r0WrUbtkZreT15W3hGzfdcv0Ik6CpL0aetmkeXx1RKIV1ANk
	ezkMBY078IdUofRU9x9OKey77CKPF4Bv4LHk=
X-Received: by 2002:a05:622a:48c:b0:52d:6de2:906c with SMTP id d75a77b69052e-52e09bd76b6mr191238681cf.14.1787584588075;
        Mon, 24 Aug 2026 08:16:28 -0700 (PDT)
X-Received: by 2002:a05:622a:48c:b0:52d:6de2:906c with SMTP id d75a77b69052e-52e09bd76b6mr191237961cf.14.1787584587678;
        Mon, 24 Aug 2026 08:16:27 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09975f5asm50565271cf.2.2026.08.24.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:16:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:16:26 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH] i2c: bcm2835: Make sure clk_init_data is fully
 initialized
Message-ID: <aoxgSkSflxgaZO3K@redhat.com>
References: <9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Fri, Aug 21, 2026 at 12:03:30PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

