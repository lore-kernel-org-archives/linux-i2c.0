Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359E54DACE
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084034; cv=none; b=b8SRofSlNAKZQ7RUgGscIFo/aUoCBHcoF5Nhz76iqa3uEISFOQzCTqrLw7XZljzFU9KTleDQtN3RmQIgkxxndQ3JRPR2vHJN5KpsisKf7TuntIhDRDxFWqfXdNsaoVRh2vPOFnCPkl/UNnrx13Imt4vfsyP3VVLhiKPF9+39kYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084034; c=relaxed/simple;
	bh=H8SjBKeODkYJuB20OhnIYOCLI18toT67xX3EcancdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdL8iDh88SD8o30zucqLIi63r6cokK9yuZrV+YnXUX+pgzEzTuueRSQQnAnkR07bDxx2kW0XJNWrkxQKlVkpYH0xKp5VqWR2X4L9NLbxxm/bkmF0CbVmcoUv3/C6HfqcoPZ5ntgfrj7fbd7xhtMmS8HKgrHASWx9ZMGc+lLIaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVnz+QT3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVnz+QT3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso20477835e9.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790084024; x=1790688824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=SVnz+QT3I8ti62UzKDZqWI/t/Ky8xoFhL/3ym9+SybegBOVx489WKl0Qmri75qAh5j
         2h4w0vDlkamxb91ed6rPprLijfZS8iG+Ez0ysiNzq6ESv/pO3wsX9198r+RUn29Pk9zu
         V0prKgj3LREUVnYNIljsGZhmnFPcFKW0rxxbl4gU5noyCFbKbNTImO6yuszOBYTsZIiu
         i/CMicwx8ge90zMlR/fhX6ZhD0Bc8vvtCj+e6HBur2gehQuYIGy3/KXRXnGgHZH6GoCR
         Zjn1eq18uIU1kA7arVlw5BdCjlhLyqFDAwIi4Jar0+Q3zg876y979pZdYSnhcauvbbMQ
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084024; x=1790688824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=dz1nh+DG5GdMf3fUbPXuGgDBkRejDJXxK3iZaabZGZ/0mrRyCbDcQfDppHvUlklxlb
         L0NaJl/blh0WdtnH8sauLnMPM/3y8aXYodmMYEu6I1rSpt4QONoVvYTi6HlKJXyQvJMl
         qzXnF57M6T/bswlZ1BnY6TEFOqAh6mrRQG4e14rgaT3mRrW1ilZd/3E+coTuYBrmJ/Sa
         lEwvXUtUV9EOaXX+M/eKLdmQwO+impG4incHMWUdiMtaPedFF1pq1cUVM667ufnap9Ed
         WHpO/5uOBiHTzd4oVFL/WnykIyjGMjSMr5pmP4vJdqM2461iM0k129cr4GIoowB4DQd0
         jxIg==
X-Forwarded-Encrypted: i=1; AKwUvBzFdg+B2ebAMJWDY/MGGO797OWjMjx27dT6zSvWYDc4Ih0Ohr3xXia4KK5SRDcuw/3CruQ0k//kRFI=@vger.kernel.org
X-Gm-Message-State: AFuF++nKgHPp1+4OzFrlBXXj/13V5wtsBhYPZ0I1gjT1vGvOpofs1csJ
	wjD01ANZwjpBVOOM4P8KiNI9Htkwobbh9v4afr7kerEi8WU2RbzAtwPy3H0KR3K5QHo=
X-Gm-Gg: AYBFou0yPk843KzJg9u1B80pDNF2UGzEUHZN4Nt7rndfuLt62dO54xkXxi9HxYD4gG/
	LOeJx4OM6Ew+GY/z2CuQB8rEW0GpbaOYj4wYzD4nL+Dst15b2VD6vvM4+5nBeHQr2Dx4ghkmHd/
	tdo4VSG6OjMS/df3QFwdYFIpALg6oEUhj8B1aDt/crbRf+X4ochrlLiYUtn/v3iyjoipJQMfeOu
	jGrIKLlBcimoe7wGzIWsuaQ7F3jYV68iex+Dad0XWTYnrq2BshWHOMHRArxTkUGsHjIGNkV/LyW
	YJUuyLZwKADmRUW2QWnv6km8HJ88zpmk7P9ISFBQAg9J2/oawyU7lCin/+fQ6OCvH4ZNArvbiYy
	6c+3mKmrypiYTkXES83b4AqRfF32aj09K/C5uTQ22xiobnauoZRM8+Hs5b9SHaArDwU6HbD99gN
	ulvpQKh8yFVA53eGVkwH/McSPoMfZcJr8ggKV9l1RvzNS4nWo09A2YkcKIlzCvT/cuQvf5PhkiG
	k1kLERxVpMYQ3e30lZfs/ETIqp8asvx3H+11yjL03NjQrvVLa6KMX7BJn/V/zPERROU1xM=
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49fc58581bfmr184348345e9.31.1790084023989;
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:23 +0200
Message-ID: <20260922-module-string-v1-3-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0d9157a2d487 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
