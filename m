Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375139;
	b=Lr0U6kbq4f1OlCR6dDwfPi18PnOGi0BOS0p6HS7+DqAR7DH+S4TN3I3LOHijgh57Pa6f
	 21r2J0UvhXxYWvhFSeuBuV+Ap4Yw63P7eTD6f+scYY/Yezl74ErVfTeoRYDrzB6LLFDDj
	 ffWC2AZ5knKUWtk+mwlaCALnBW9pKfNOXmy87qlo2D/v6SY6UJGZcooPu5ODKr1rdV1gF
	 i+Gg4L6OGkVoS/BKEJDsLN33BaW65F4n2W+vokZgde/3JWpKvqgRkXwyVDivOi7dj+QZ3
	 jvGMzKTocJEAvsK5mmoH0I9cyY1V+HaMAc/0fVynmgcyG1rO8vgfuNOiSz2HS78R19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
	b=JptxL6pBczG5h6lJykbcQWWNqmfca7GUDj0jA8XOIdhzOpsE9W9ZWqItpgmtbT8oKfDH
	 BskngFpTi/+tE5M7xrg8Udm3oQxwWOVyIm2isyEx3Z9M4+EkOyMtkApdtgfxovSCbTGFf
	 OlqU4QUl8gWxR/Q5Ryw1z3cENATMKd3kdTvzBFeOFyWGQL5idQ0zygI6r5Em3Qmgj5ApF
	 2YXVvtqTI4fX2aIa2kfhGx9yc+dQzkBXsv7wWGbtiwY5mAtx271LNMX4IcQLACx8ufMix
	 +aZrwxYdtmpclzm8+F+/ybxrAGmZVihakY1isuBUwac6tzCy+WHncGFv76OkLgV1AFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3UjBH3C;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC89606A31D
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 19:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC89606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O3UjBH3C
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso18813615e9.2
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795375137; x=1795979937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=O3UjBH3CmNWhcmGEJhbSQHkXs5PNu0jtbxwsuPUdWbYk7HhTLqUQCZVRasMZgp1kjv
         KSBaZEyIvEJ4mxlaMSVnEuZf+DLpxMU/XKVPPkZfy1Y35+CnkvifWZf8TqhkE4zGEJk9
         R5ieUAlv4aqfeP+ncJ1fIhK0aCwtizM756ibsGNChZmUkb0i63l00NI64vNo0akhcQpn
         i3CK4KrtHXExRUTQ2/xvOcxl6EDgLx5Z0wbUXODLYyx9OoPZMJ8oX4QI+gB9TumKtHpj
         XqmmkOxo8RVqcXnVO+JR/1tjk7vjPWNboEesTNetWxR7w5fjJwVkdrrBiSWUV+D14hc2
         h11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375137; x=1795979937;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=Wp3DrmzysgfZKZ+0h+iqEBTX9sE13HnD0YbSLG+MTdNDVkmvdgL9nxL5I7H92uvcsI
         2tuDDAuBER9SJXx4vtoiYt6/pGRf11kJZiIXKTWSxHbEHLRW0dDjdRQeZ0dsZyap+Ckj
         5HZy4QE14zc99GooRIBwk6FapuZPTpVtZydwgJhQMHU2GXUuElvdyzCph6aK6j8pKVdt
         V74XlFSfRT7SeoNfhrvUBm+H3PQdj8Rmm2aL/CTv+YGOxE04sZBWBodgJp097EMxdZrR
         bnEP4dON2Tg7iDizPi5HzVvErrlOgHETke0s7+jRIsNCozfoUeYMdCrJvQ4IYtq75sSf
         J/BA==
X-Forwarded-Encrypted: i=1; AL+hErHpMRlX2gOREhbLlA0g6Kl+aSR+FaW+z5OHbVg7G8ZOeiCyIZi+GDLEgFtAvD7Fh4mhkp/It5s1ngU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZE0dEe+KRVWnWroCsw9Ax2m1WCQEpAAtv/h/epuKE/vqVFSYW
	U0+QfdgT5EfANEf8ZYxXTvgkW3MmSCGJUAo6yQOzNTAEBpUB2spq49XF
X-Gm-Gg: AZFdTZfPfwkaeAZWPBRm8sUrSoiZaxXRi468pD0Vmlk5XFrmIYoCG4FvFv+WNjIS479
	K7FXQZsNvggtMpPvgMLsEBJXLVuFMiJN7HPvwkJw/Vt0bs/bszVFFfV8oDFAVUGc1fI3SIiBHcR
	Yu2E7cGb3zLGaatlHP0tdL6+HAwgADeFvfN75Qn/yAJmfWXDBkdB6VpnII68+heccrX6gbek7qo
	SmT4ze3tQ9/Kee8YGZt2a8bkdxUyrb0bXirBz8Lxzi+Us8P4b5DnYRvcu+V6Dxjm4pFBxtDydqU
	X4vFNS4z80tMq8K6MCDrqlJEhIkUqB0Nc57JfAeAC8Yjm637R7DnLmreaGM1gE/HceAoxNP/XH6
	tXDaESZhytfJwNA22RMpYPuuzHqr1XvhCug2GEpUVjoNwTHoMR8u1Y/VqHnnbJCmRARc0Ob1gct
	lxlS63yvYUM0TyZimRbc9iHQIrXLLmn8kOVAjrKVyyx0WhWh5CsJCKccTRDZfWRfVXpJNFimc1U
	A9NKKrQwoSNrZQIDvY4nvMgb0C43vY3luyUgqcO5UH7D7IGYbWcP0L8WAg6cLtnbsQABMKRdmNj
	ThyrviK531bgYumBjaRzE3CJj57m/YVcC38QsO0ccz3HclDjzDUZhKNSUS+dOpJEMg==
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id 5b1f17b1804b1-4bb8880abf7mr193493515e9.11.1795375137482;
        Sun, 22 Nov 2026 11:18:57 -0800 (PST)
Received: from cachyos-x8664.aetlocal ([2001:bb6:e78e:9100:cdb3:c7ee:74a4:5189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm199176045e9.2.2026.11.22.11.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:18:57 -0800 (PST)
From: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v5 1/7] riscv: dts: eswin: add reset generator for EIC7700 SoC
Date: Sun, 22 Nov 2026 19:18:55 +0000
Message-ID: <20261122191855.2183827-1-mervynpretorius.oss@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261015125454.1381941-2-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com> <20261015125454.1381941-2-pinkesh.vaghela@einfochips.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested on a DeepComputing FML13V03 (EIC7702X), on top of v7.4-rc3;
details in my reply to the cover letter.

Tested-by: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
