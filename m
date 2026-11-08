Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134487;
	b=I1Q9fcSqV8UwXhjCrD66FmDZvNUl8nSbkeSRrMD7QFwzfa19YjRQUcRUTZNjzeJ42F4v
	 PnM+IIo4sQZclO773owkCkqKQwGeTJZaXbcc+Tio7A7tm26iXt65YdIf7AJIzpxlDe/vc
	 NKzhB06GlHrzQYic6RuNpQD0cy2L8NkVyXxuTIzoCm5x0k/YwSJs9AuiJASLuM7ThSJHM
	 iNMpsWySNtgZ3WDAiayBlo2sLuMf5MJex5WnoCXlw7vQcOyoyZOpiPKDhcm8owypHpo16
	 R93mOVe2LVgddcMEliVPn6fJvulMawdP1CIQNlSm+RtpQd1il1PIR2TOo2KBRL1zEpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134487;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=buOLHq3aXEaLOdh+jel+eyDIOFFbNtd2Ddp+pAzex4s=;
	b=BsJxFHK5JhHFysy7vajWIV7WbzmFUEyEkUK7INlw2pjjj5g0HjtTFkh4uq/KhOO2kor3
	 z3w1GxoxuGJj0H2JSp/C4A2X+tcZHw+bSvULte987B5dU7moaTsK3LR+J5l1eOxl1ESVa
	 537lacCFU5BqnB5Mm8fH3bu3HkXKwMMiuHejvSYV5xGmtiXCkIkpyZd4CEIqUKCVssrvt
	 W7HvJBY3OgtjKoCj9IdYU3YyXRpicVDW9GexjZbk7UixWtNODbA5t68CLQv7g14bLm6KU
	 isAFWkfc/J1FML2ShyWgONPdiCOU2e0zPYBi9yQOnshj6Pl8eKin3yeWiDTprUrHRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AjmhaE8m;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FD606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 10:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 091FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AjmhaE8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=buOL
	Hq3aXEaLOdh+jel+eyDIOFFbNtd2Ddp+pAzex4s=; b=AjmhaE8mMo1wy2A4v7bW
	o/5uLxur08eTQ/lz9R4g4HKOOOrU1/rqf7skAcOURcDDFRQFwvW231UUyiGjaR/E
	yto6eCJLBQaVH23kFdvAQbpfNF5aynjJaHV9kONy2EUg7BAeZJhJJqdHkmzmW9zk
	iPBD/5TxNaDTObWJOOufKzPq7KVne+MYZEf+TSn+EHQgZSlyfvhOHacOXA0sffx6
	wFmPMPHw4yT7Ej8girrWKnPIqtcjlg7Brkn12YZJdeXv92vouEMNjID9afM5C+74
	DWPw6GkvsegzI9IEBwvl9dadgad/U9gKXnqw+MaCqoMwyHFkyWLmK/oAHsGhB+Jz
	FQ==
Received: (qmail 2814864 invoked from network); 8 Nov 2026 11:41:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:41:24 +0100
X-UD-Smtp-Session: l3s3148p1@hd2afMFfjpte20rG
Date: Sun, 8 Nov 2026 11:41:23 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Allen Pais <apais@microsoft.com>,
	"rlmenge@gmail.com" <rlmenge@gmail.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
Message-ID: <avBR0xxt0dvGb9_a@shikoro>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>


> Do I have to respin the patch?

Yes, please.

