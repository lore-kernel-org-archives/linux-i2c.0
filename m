From: =?UTF-8?Q?=c3=89ric_Piel?= <eric.piel@tremplin-utc.net>
Subject: Re: lis3lv02d i2c access on shutdown
Date: Sat, 4 Mar 2017 22:35:53 +0100
Message-ID: <33dcfc02-67ef-ba6e-30a6-e2cd26aa9f71@tremplin-utc.net>
References: <647cd755-3554-0719-6811-c64ffae0fc1e@revolayer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:46899 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdCDVgE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 4 Mar 2017 16:36:04 -0500
In-Reply-To: <647cd755-3554-0719-6811-c64ffae0fc1e@revolayer.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: James Maki <jamescmaki@revolayer.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 18-02-17 19:09, James Maki wrote:
> Hi Eric,
>
> I have an TI am335x that is using a i2c PMIC with pm_power_off  hook
> which locks up on shutdown. The pm_power_off hook gets stuck obtaining
> i2c_lock_adapter(). The holder of the lock is the lis3lv02d
> accelerometer which never releases it.
>
> I do not think there is an issue in lis3lv02d. I think this is a general
> issue with i2c since other drivers have the same design. What I don't
> have is clear understanding of if/when/how i2c_transfer() can be called
> post kernel_power_off(). Is it possible to call i2c_transfer() at this
> point. I have tried calling schedule() and msleep() inside of
> kernel_power_off() after syscore_shutdown(). It looks like interrupts
> are enabled and I can still schedule at this point. So how is it
> possible that lis3lv02d is never able to exit the i2c_transfer()? Is
> there some other lock inside i2c_transfer that it is blocking on?
>
> Is it possible that the process which had the accelerometer open has
> exited while holding the i2c lock. Is it even possible for a device to
> shutdown or file to close while holding a lock in the kernel?
>
> I looked at adding a lis3lv02d_i2c_shutdown, but that was too late in
> the process already and the lis3lv02d was already stuck. Is there a very
> early place during shutdown that I can kick everyone off the i2c bus?
> Obviously this might not be the best general solution, but my concern
> right now is fixing the problem on this particular system first.
>

Dear James,

Unfortunately, I don't know enough about I2C to be able to help you. 
Honestly, I know pretty much nothing about this subsystem, and all the 
code dealing with it in the lis3lv02d driver has been contributed by 
other people.

The only thing I can say is that indeed it does sound more like an issue 
happening at the I2C level than in this specific driver. Concerning the 
lock, if I understand correctly, it shouldn't possible for a process 
talking to the accelerometer to suddenly be killed, while a kernel lock 
is held, preventing it to ever be release. That said, in practice, there 
are sufficiently enough bugs in the kernel for this to be possible ;-)

So I'd suggest you to contact people who understand well the I2C 
subsystem. I've CC'd Wolfram, maintainer of the subsystem, and the 
dedicated mailing-list.

Best,
Éric
