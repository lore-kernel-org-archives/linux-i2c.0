From: Raphael Lisicki <rlisicki@radiodata.biz>
Subject: Two nxp,pca9539 sharing IRQ
Date: Mon, 4 Dec 2017 14:22:42 +0100
Message-ID: <7594fad0-00c3-5dc6-c095-908e8a03c31a@radiodata.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.radiodata.biz ([78.47.114.250]:48054 "EHLO
        smtp.radiodata.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbdLDNch (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Dec 2017 08:32:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp.radiodata.biz (Postfix) with ESMTP id 4A66560366
        for <linux-i2c@vger.kernel.org>; Mon,  4 Dec 2017 14:22:55 +0100 (CET)
Received: from smtp.radiodata.biz ([127.0.0.1])
        by localhost (smtp.radiodata.biz [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Q189ELdbJ3SX for <linux-i2c@vger.kernel.org>;
        Mon,  4 Dec 2017 14:22:45 +0100 (CET)
Received: from mail (mail.radiodata.biz [87.128.68.248])
        by smtp.radiodata.biz (Postfix) with ESMTPSA id B4F0560169
        for <linux-i2c@vger.kernel.org>; Mon,  4 Dec 2017 14:22:45 +0100 (CET)
Received: from [192.168.3.180] (unknown [192.168.3.180])
        by mail (Postfix) with ESMTPSA id 1B0DE3FEEA
        for <linux-i2c@vger.kernel.org>; Mon,  4 Dec 2017 14:22:45 +0100 (CET)
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hello everybody,

I am having trouble to use the NXP PCA9539 as an IRQ source on a board 
where two of them share the same Interrupt line.

When the PCA9539 starts, interrupts are already enabled. There is also 
no way to disable interrupts. This means that both chips pull down the 
interrupt line. When the driver gets instantiated for the first chip, 
the interrupt line is enabled and an interrupt caused. This causes the 
interrupt handler for the first chip to be called, but this does not 
reset the interrupt coming from the second chip. Its handler is not 
being called as it is still not installed. This means that the interrupt 
line will be considered stuck and disabled subsequently.

I think I need to delay the activation of the interrupt source until 
both interrupt handlers have been installed. Is it possible to describe 
this behavior in the devicetree?


Best regards

Raphael Lisicki
