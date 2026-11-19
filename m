Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080899;
	b=ENe+1njeZZfXdEWJA6XYhF3nbgm4oYPekNX/mL0lbeGRkwR1e9mk4gUp0gqfJu0rtX+G
	 yeI5Ou1FH7PcnwpOTyEFpyOMdjb3+3lTQx+5O9h/GUINxYNpsEhYgZBUMtcZ9hzT5lpyj
	 BaxHbfTXCEREElxQPDcxODBpuuW3l2jTsNjjuRxqmtG6RATX9gXHmRFN3486bJ4XKoOPz
	 qRgYp9qAFJ8gU2BfkZyVvRUvrV8nHH1rY2FkEJRID5pcekcZ5HKHFZY67lK+/sO7NtK/H
	 2c9UTOVrGXt4lUlYhpqNpU4zQ1FB1VWBUmskyLZZv10bZcsXw/uJVb4q1VnkyX60VBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=BfuQOTrbBgGM1H6IV66t9dZSuCArSgWVXq1IwDlbWkM=;
	b=A5jc5HQKQhNNi0cvy2yUu3AGaJ6jx5z5GO0qAs34PHJ7zaSVK7sjAxRJwAaaXfWj/zAA
	 fGYb1RMW6H6CKueT4ykwH7Fc99zJVBmLL9aleMfTz8d3qfrrMYPKHWzsSUdurQnlmOYTW
	 peN3NM0POhhMnIcKFisuSj0ARuebdW2vDzYuDs3P2ufG1S410oyrww8JOCctZUSw0k2Bo
	 t6D37WECy8ogeuiXbZlScDKvGTK6gActp+W9ABJdOnqELDYRtCQvsSgUpkg1cregaRubH
	 hqFxHyu2yCxXnJf27EJ7JOGdgPfhm0K0B2ZAQUNyKXJO5bGUjqRaP8My3ms2holuEQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mqxw3sXJ;
	arc=none smtp.remote-ip=74.125.228.138
Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63360A2600
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 09:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB63360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mqxw3sXJ
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c506defeb1eso63803866b.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795080897; x=1795685697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BfuQOTrbBgGM1H6IV66t9dZSuCArSgWVXq1IwDlbWkM=;
        b=Mqxw3sXJNtOeYUpyxS6zeblK2hzEmxEDcP8q5cgMGE0sn6TgRcI1x5niSLviXjCdP/
         7EpdntYjEGx/fTKehBBDY8r/JFWX+xu2VbjU/sJBDEaj09siuHE9J7i230iXP5Qy4hM5
         lH2ScX1lQV956ku9mM+rNCyQSaneTlkKTzv/Wn2YdOUqdgLq3JGGGyNCgi8E6WYphFim
         0RoZTC2Q7Vfjh+vYBmW2OFxn6zaBjZnsE5YgoKHo71iy714h5ija9aUMttjfUgbRDcME
         DzN/tgTNgSPR4d/sdf+tOa1ZEWJF5uJAmK89HxbAV4GQOlNgy9jeL9q9K8vhYFaJeKN0
         31yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795080897; x=1795685697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BfuQOTrbBgGM1H6IV66t9dZSuCArSgWVXq1IwDlbWkM=;
        b=jatzsijFPsNhZRD4qzx1OwuklyJm1i7tRT2WPoD71T5F7MxRik3bH4pBnEkGDi8vD6
         4+Yo7dAwQQTmgnJfcr/Jop+D1VlpL/92rUvnUJzpxG0o9C6TXqlp7smQNTj7sknFxpfM
         7gDf+ub/JIwhbW6O6R9KdwAhozz895wYfulxk9IhfUoAwTGA4zWPYB6hAdZnU3Ek0Uvx
         JgskWiwpJdaWUd8noVd0sOYdrP55FdD5IqUc5exI7DsuypFyfCiV0VRXqLKolJPPOrt4
         RFjzHR5x9WpasJjhv5LIyVfvmjuE1/Y9askKwQcwrELwLBgPaCXl1UjYT/LfhxFQ+FKc
         fJAA==
X-Forwarded-Encrypted: i=1; AL+hErEu8kOn8DK+PRUa/IvgmuAjYNXWOXWx0h6QlBOHiSJGrhY+/Vx5Mas6my53hXxzYu95Bp2WOLGumBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QHtkt/1dT8WXn96uDECfNxyn194UUxYx90b4SA5l38mJ0Aedh
	FHAQQqRzVQdRVw2oujNf/oC4PwvVW89sn/8CS9u5jix8aSHYYAuUdCnJ
X-Gm-Gg: AYBFou2vEnLk4Prc94x7XtNRDjkcCXyKowbK5ohhOy9bjWW93jY9EKvCOeecQ40DiLT
	nnuXouucqxIfL9YfARyguXlQWc5QG7xfES4cssAxicALn3OQgH3B/EQMv2FWxVsBBGkmxlBzDFH
	8s51EkHpe6G6BLFJBAjrLQLvUdXoOn9DxfyltY8EACRKXgVV2UGt3zJhGbneiKsJ/v30W+d9rg/
	zl9DhwsxRvaNu/ePcivHgP2YYP3HaUYYqmASpMvGQqoHA0tgV+UWKAZo6S98HhRAAk8wynT8i8j
	IIWg/JwZVCLVQP0xCxbE1N7XfYLGlA0giWihbtoc3wPRYUzy5mP9P6vQmHUrqz2F6r1YZA4S18K
	I/9KmlIfYhlfF4L2K6WO/pFkRQm+B8wU6fXi4ctwpquLFJPmqKXU7wPyuy7hyldZHfS/+ksjNfv
	a5rmli/NVReAcS0KenqQm8U0zI9cmg7yPDF6WlQ6D2PWtXDGll/pv9O1omXOa+prfg4po0Fr+GA
	ZgmpfHoKQQCcLUBgcUztyvQwrP0G1unAATW5SL6aXKHTpW0sP3Dpz3HeRv80CK0eAbmiMsUmvAv
	sWM3eyuQrkZykt4PlbTbOppkBZl11T+VUch/sqYT2ZHQKC5jFClG5wMMgaF4U4vQPSeFXw0ak8O
	2UF2FWqnXVrG1CfzJ3jmsKv0yK26T+CGJYC5bXgv7Wa9uVeIwdhq3/JC3
X-Received: by 2002:a17:907:6d13:b0:c3f:7e8:235d with SMTP id a640c23a62f3a-c510dec35a4mr480605066b.5.1795080897118;
        Thu, 19 Nov 2026 01:34:57 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5122e68675sm93767366b.0.2026.11.19.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:34:56 -0800 (PST)
Date: Thu, 19 Nov 2026 10:34:54 +0100
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v4 1/2] i2c: i2c-xiic: fix clearing of bnb irq
Message-ID: <av7CvgS20rBjsJHx@thi-server.fritz.box>
References: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
 <20261118101147.3350796-2-thi.zirnstein@gmail.com>
 <av2jSyTFI1VoyGSU@zenone.zhora.eu>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2jSyTFI1VoyGSU@zenone.zhora.eu>

On Wed, Nov 18, 2026 at 02:22:18PM +0100, Andi Shyti wrote:

Hi Andi, 

Thank you for your review and feedback

> Hi Thilo,
> 
> ...
> 
> > +	ret = read_poll_timeout_atomic(xiic_getreg8, sr,
> > +			sr & XIIC_SR_BUS_BUSY_MASK, 0, XIIC_BB_TIMEOUT_US, 0,
> > +			i2c, XIIC_SR_REG_OFFSET);
> 
> this is a bit of an overkill: you are forcing tight loops for
> 1ms. If you consider that the minimum wait is 1ns, in 1ms you
> will end up busy looping a lot of time. Please, don't set the
> delay_us to '0', but calculate a proper waiting time between
> reads.
> 

I also had doubts about whether this approach is too heavy. 
I have general concerns about the busy-waiting in atomic context
in this patches, though I noticed other I2C adapters wait 
for relatively long periods there as well. 
The tight loops in patch 2/2 are even longer.
Those waits are longer because the code waits for the entire I2C transfer 
to finish, but polling is unavoidable there since sleeping or scheduling 
deferred work is not possible in atomic context—is that right?
So this kind of builtin if doing i2c transfer in atomic context ?

I will reduce the maximum poll timeout to 4 µs, 
which matches the minimum I2C START condition hold time 
in standard mode and seems reasonable.

I will also increase delay_us. Out of curiosity, 
what is the reasoning behind the delay interval? 
I assume we want to avoid hammering shared buses
 or registers with continuous I/O reads.

> Andi

kind regards,

Thilo
