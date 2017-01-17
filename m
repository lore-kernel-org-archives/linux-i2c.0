From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v5 4/5] dt: bindings: i2c-mux-pca954x: Add documentation
 for nxp,irq-mask-enable
Date: Tue, 17 Jan 2017 17:28:23 +0800
Message-ID: <aeab2bbe-e243-98f6-b07f-76e4dda62fd6@electromag.com.au>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-5-git-send-email-preid@electromag.com.au>
 <9190ec70-eda4-5e44-a85a-211945c30eeb@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:53177 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751221AbdAQJfq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Jan 2017 04:35:46 -0500
In-Reply-To: <9190ec70-eda4-5e44-a85a-211945c30eeb@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On 17/01/2017 16:57, Peter Rosin wrote:
> On 2017-01-17 09:00, Phil Reid wrote:
>> Unfortunately some hardware device will assert their irq line immediately
>> on power on and provide no mechanism to mask the irq. As the i2c muxes
>> provide no method to mask irq line this provides a work around by keeping
>> the parent irq masked until enough device drivers have loaded to service
>> all pending interrupts.
>>
>> For example the the ltc1760 assert its SMBALERT irq immediately on power
>> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
>> device is registered irq are enabled and fire continuously as the second
>> device driver has not yet loaded. Setting this parameter to <1 1> will
>> delay the irq being enabled until both devices are ready.
>
G'day Peter,


> Hang on, does this suggestion I made make any sense at all? Maybe it does,
> but does the pca954x driver even get notified of any but the first irq client
> that unmasks interrupts on a mux segment? How can it count the number of
> active irq clients if not?

Good question.

So what I did to test is setup my 2 ltc1760s to use the same irq on the pca954x.
Using the latest patch series.

Adding a log message into the irq_unmask function got the following.
	dev_err(&data->client->dev, "irq_unmask %d %x %d", pos, data->irq_mask, data->irq_enabled);

dmesg | grep irq_unmask
[    4.392098] pca954x 4-0070: irq_unmask 0 1 1


But Looks like both got registered ok to the same irq.
cat /proc/interrupts
161:          0          0  i2c-mux-pca954x   0 Level     15-000a, 16-000a

So from this testing, it doesn't look like it gets called multiple times.
So back to the bitmask for the dt do you think.
I think the interrupt enablelogic is correct now.

>
> I'm truly sorry for the trouble I'm causing by not just saying how it should
> be done from the start, but I feel like I've been thrown in at the deep end
> when it comes to interrupt controllers...

No problem. I'm learning a couple things as we go.
Should help me out on other drivers :)


-- 
Regards
Phil Reid
