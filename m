Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C36923B612
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555496; cv=none; b=PsG7oZQ/+cC/bytOHUI7T19mEpw7WTgEBQOTGktijXBj0gZVMzu3K1X2TuY9Dn+I9wKP6kkhXzlwHpG+5oZvr7W2FKO9hwBMYwqBcoK6d09cjeLgb7VrGhNiuAvXruU78zuOzZp6BTiPDfi2DiwkAF7JxRpoprn59WNju4UDnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555496; c=relaxed/simple;
	bh=QaKKbCcJMgekZSc5+8aGKpYxuiEwDbDAhp6CDgKHl60=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KKbRLYFQupKIZBvGFkiovo0GhMk6rlSzQMXoj9KQcD7J0ciU8wG2BplinCCOzcyGwjzpISZKuy7n7mHrVAJ0db/8Ru6TcyefF+N3qX9MALgSxrrPnWOBNz+NYSRRvPb+8dvnC0QX28zU6HROd6KxpEd4joZIyCLXqXSN0LwSICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJWGw6R6; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJWGw6R6"
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-9519c5d5b27so471398241.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774555494; x=1775160294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XmfpOWHILBNPoUIFigWXCvXcdE+KdaoK2IRTSOIkuFQ=;
        b=OJWGw6R6gb99dfWFKXC9cxtk/7GgkNiV1QN0mJNnMTgRpdSW4jsUdeZjJIVELcIxpc
         rA3mujhTMSkgQoOSit8QzygyzTfYJbQLh4rGaGh1jaYrImrPu5StlMGcXDDm/FTVGHbF
         T1Tzh1ZZOqPAYUssbVhw7Ws/3cSuLcuq2jXzC3Fahyb9EZiIqjP9JpgUuZJ8+zeRf1ZP
         JBQ+SmuF9Jpx46w38WiqmgBgR7qvIzTfV3JILumr85NqrE9XKkLlbXHcEsFQLExaMMP1
         t9Te3Su/axjhnW/v19qsHNuHYtOj+82myfG65snux8fDk108P42UMSWVnsXQnStjHDPX
         I1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555494; x=1775160294;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmfpOWHILBNPoUIFigWXCvXcdE+KdaoK2IRTSOIkuFQ=;
        b=RtX0lz12f6YRuQNlkdgMEoofolaiRuvJiHh4zDG3HGlB308PTrXlgOEaKS5Y331Hex
         Kv7RqyjN2wmC8B2kcWGnlLKlkhYrORdAo/nPLpoPfdEYxcnhdEshCTwfb2TNLTXoKsPF
         bOJzetx087QF4429XRcWov0p2YE6R4SGBxWx8pyuT9ZACQiHAtwCQPtlixjrHJDWCQje
         HzxEw4Mc7V8u2Cvhl7Chc4ACObMZ//gufPf4w4qui7lihSqkeUPcrOFikRNRqddUvtAn
         5+UrOeAK3EURfYndjFggdJAYwLGhFbZVneaQr87ypHts3BY2gcXWAD+OncoqnrBk3TS3
         3FyA==
X-Gm-Message-State: AOJu0YwhYabDNtYZaqf4LjGz5WzLz+cCl+e6lIwz6CydIzRybRqQHAJd
	qvjticcXacgmn9aaie5D70zLmFyr0qj0/OSQsQKXN5LIWUeiQzJZXfHoVappnP+U7Eb/h7M3wZY
	HqMFGrkEDwmZT3i8tnTiHDFk7ICYlrB/WmXXxmgcP8jEaqde+m1Tehgju9SH8U30W3Eq+uD4aTG
	myADXZvQdbUaY7ojGEyFbBkPs4hDczBEVsWH33pTNkNdh6/Q==
X-Received: from uaaq11-n1.prod.google.com ([2002:a05:6130:834b:10b0:951:94f8:e12])
 (user=moritzf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:5808:b0:602:9977:a4e3
 with SMTP id ada2fe7eead31-603948182c9mr4252179137.33.1774555493607; Thu, 26
 Mar 2026 13:04:53 -0700 (PDT)
Date: Thu, 26 Mar 2026 20:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326200451.2904375-1-moritzf@google.com>
Subject: [PATCH v2] i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller
From: Moritz Fischer <moritzf@google.com>
To: linux-i2c@vger.kernel.org, andi.shyti@kernel.org
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com, 
	Moritz Fischer <moritzf@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>
Content-Type: text/plain; charset="UTF-8"

Define a new ACPI HID for GOOG5000 as used on Google Axion.

This has been validated on Silicon.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

---

Changelog from v1:
- Added Mika's Acked-by

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Dabros <jsd@semihalf.com>

A DSDT excerpt is here:
    Device (I2C0)                                                                                                                                                                            
    {                                                                                                                                                                                        
      Name (_HID, "GOOG5000")                                                                                                                                                                
      Name (_UID, 0x00)                                                                                                                                                                      
      Method (_STA) {                                                                                                                                                                        
        Return (0xf)                                                                                                                                                                         
      }                                                                                                                                                                                      
      Name (_CRS, ResourceTemplate ()                                                                                                                                                        
      {                                                                                                                                                                                      
        QWordMemory (                                                                                                                                                                        
          ResourceProducer,                                                                                                                                                                  
          PosDecode,                                                                                                                                                                         
          MinFixed,                                                                                                                                                                          
          MaxFixed,                                                                                                                                                                          
          NonCacheable,                                                                                                                                                                      
          ReadWrite,                                                                                                                                                                         
          0x0,                                                                                                                                                                               
          0xA02048000,                                                                                                                                                                       
          0xA020480FF,                                                                                                                                                                       
          0x000000000,                                                                                                                                                                       
          0x000000100                                                                                                                                                                        
        )                                                                                                                                                                                    
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive)                                                                                                                           
      {                                                                                                                                                                                      
          109                                                                                                                                                                                
        }                                                                                                                                                                                    
      })                                                                                                                                                                                     
      ...                                                                                                                                                                                    
    }                                                                                                                                                                                        
                                                                                                                                                                                             
This is being used by SoCs powering Google's Axion product line.   

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 426ffec06e22..3351c4a9ef11 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -268,6 +268,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "AMDI0510", 0 },
 	{ "APMC0D0F", 0 },
 	{ "FUJI200B", 0 },
+	{ "GOOG5000", 0 },
 	{ "HISI02A1", 0 },
 	{ "HISI02A2", 0 },
 	{ "HISI02A3", 0 },
-- 
2.53.0.1018.g2bb0e51243-goog

