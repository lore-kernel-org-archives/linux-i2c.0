From: James Maki <jamescmaki@revolayer.com>
Subject: lis3lv02d i2c access on shutdown
Date: Sat, 18 Feb 2017 11:43:18 -0600
Message-ID: <e41b962a-70b9-d2ed-359f-06abd1d08405@revolayer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from p3nlsmtpcp01-02.prod.phx3.secureserver.net ([184.168.200.140]:55912
        "EHLO p3nlsmtpcp01-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdBRRqd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 18 Feb 2017 12:46:33 -0500
Received: from 208-107-182-215-dynamic.midco.net ([208.107.182.215]:49390 helo=[192.168.8.8])
        by p3plcpnl0870.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <jamescmaki@revolayer.com>)
        id 1cf94d-0005kV-Vq
        for linux-i2c@vger.kernel.org; Sat, 18 Feb 2017 10:45:32 -0700
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi,

I have an TI am335x that is using a i2c PMIC with pm_power_off  hook 
which locks up on shutdown. The pm_power_off hook gets stuck obtaining 
i2c_lock_adapter(). The holder of the lock is the lis3lv02d 
accelerometer which never releases it.

I do not think there is an issue in lis3lv02d. I think this is a general 
issue with i2c since other drivers have the same design. What I don't 
have is clear understanding of if/when/how i2c_transfer() can be called 
post kernel_power_off(). Is it possible to call i2c_transfer() at this 
point. I have tried calling schedule() and msleep() inside of 
kernel_power_off() after syscore_shutdown(). It looks like interrupts 
are enabled and I can still schedule at this point. So how is it 
possible that lis3lv02d is never able to exit the i2c_transfer()? Is 
there some other lock inside i2c_transfer that it is blocking on?

Is it possible that the process which had the accelerometer open has 
exited while holding the i2c lock. Is it even possible for a device to 
shutdown or file to close while holding a lock in the kernel?

I looked at adding a lis3lv02d_i2c_shutdown, but that was too late in 
the process already and the lis3lv02d was already stuck. Is there a very 
early place during shutdown that I can kick everyone off the i2c bus? 
Obviously this might not be the best general solution, but my concern 
right now is fixing the problem on this particular system first.

-James
