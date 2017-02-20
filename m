From: James Maki <jamescmaki@revolayer.com>
Subject: Re: lis3lv02d i2c access on shutdown
Date: Mon, 20 Feb 2017 12:41:05 -0600
Message-ID: <c3ab193a-8fa5-2ab5-71f4-908af9078311@revolayer.com>
References: <3954427e-9b04-af29-6506-283f71443479@revolayer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from p3nlsmtpcp01-03.prod.phx3.secureserver.net ([184.168.200.142]:59356
        "EHLO p3nlsmtpcp01-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbdBTSoR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Feb 2017 13:44:17 -0500
Received: from 208-107-182-215-dynamic.midco.net ([208.107.182.215]:42144 helo=[192.168.8.8])
        by p3plcpnl0870.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <jamescmaki@revolayer.com>)
        id 1cfsva-0007BW-Si
        for linux-i2c@vger.kernel.org; Mon, 20 Feb 2017 11:43:15 -0700
In-Reply-To: <3954427e-9b04-af29-6506-283f71443479@revolayer.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

I understand the issue now. After kernel_shutdown_prepare() is called 
from kernel_power_off() you are no longer allowed to sleep. I couldn't 
find this documented anywhere but it appears to be assumed and probably 
obvious to anyone working in this part of the code.

What this also means you are no longer allowed to grab a mutex. This 
means if another task has stopped while holding the i2c mutex then an 
i2c PMIC will never be able to shutdown the device. There are a lot of 
devices out there depending on an i2c PMIC for shutdown, so kind of 
surprised me that this issue exists. The easy/ugly fix is just to force 
everyone off the i2c bus before calling kernel_shutdown_prepare(). This 
solved my problem, but not a great general solution.

On 02/18/2017 12:02 PM, James Maki wrote:
> Hi,
>
> I have an TI am335x that is using a i2c PMIC with pm_power_off hook 
> which locks up on shutdown. The pm_power_off hook gets stuck obtaining 
> i2c_lock_adapter(). The holder of the lock is the lis3lv02d 
> accelerometer which never releases it.
>
> I do not think there is an issue in lis3lv02d. I think this is a 
> general issue with i2c since other drivers have the same design. What 
> I don't have is clear understanding of if/when/how i2c_transfer() can 
> be called post kernel_power_off(). Is it possible to call 
> i2c_transfer() at this point. I have tried calling schedule() and 
> msleep() inside of kernel_power_off() after syscore_shutdown(). It 
> looks like interrupts are enabled and I can still schedule at this 
> point. So how is it possible that lis3lv02d is never able to exit the 
> i2c_transfer()? Is there some other lock inside i2c_transfer that it 
> is blocking on?
>
> Is it possible that the process which had the accelerometer open has 
> exited while holding the i2c lock. Is it even possible for a device to 
> shutdown or file to close while holding a lock in the kernel?
>
> I looked at adding a lis3lv02d_i2c_shutdown, but that was too late in 
> the process already and the lis3lv02d was already stuck. Is there a 
> very early place during shutdown that I can kick everyone off the i2c 
> bus? Obviously this might not be the best general solution, but my 
> concern right now is fixing the problem on this particular system first.
>
> -James
