From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: interface to trigger a bus recovery sequence
Date: Sun, 18 Dec 2016 18:56:46 +0100
Message-ID: <9d29f4a6-50ae-2400-4a4d-79ba7ed48a53@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37214 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbcLRR4u (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Dec 2016 12:56:50 -0500
Received: by mail-wm0-f46.google.com with SMTP id t79so82292313wmt.0
        for <linux-i2c@vger.kernel.org>; Sun, 18 Dec 2016 09:56:49 -0800 (PST)
Received: from [192.168.1.212] (175.red-80-39-227.dynamicip.rima-tde.net. [80.39.227.175])
        by smtp.gmail.com with ESMTPSA id p144sm13547108wme.23.2016.12.18.09.56.47
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2016 09:56:47 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi all,

I was looking into the i2c bus recovery sequence and I was wondering why 
there doesn't seem to be an interface (ioctl/sysfs) that allows a user 
to trigger a recovery sequence.
Is this intentional or would such an interface - if it were to be 
implemented-  be welcome?

many thanks in advance.

jorge
