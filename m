From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v3 3/5] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 13 Jan 2017 08:17:35 +0800
Message-ID: <3d57b586-eab7-11a5-10b4-aaf0ed5baa6e@electromag.com.au>
References: <1483952576-5308-1-git-send-email-preid@electromag.com.au>
 <1483952576-5308-4-git-send-email-preid@electromag.com.au>
 <20170112191514.dpusqnbqahayx6j3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:55344 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdAMAST (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Jan 2017 19:18:19 -0500
In-Reply-To: <20170112191514.dpusqnbqahayx6j3@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On 13/01/2017 03:15, Wolfram Sang wrote:
> On Mon, Jan 09, 2017 at 05:02:54PM +0800, Phil Reid wrote:
>> Various muxes can aggregate multiple interrupts from each i2c bus.
>> All of the muxes with interrupt support combine the active low irq lines
>> using an internal 'and' function and generate a combined active low
>> output. The muxes do provide the ability to read a control register to
>> determine which irq is active. By making the mux an irq controller isr
>> latency can potentially be reduced by reading the status register and
>> then only calling the registered isr on that bus segment.
>>
>> As there is no irq masking on the mux irq are disabled until irq_unmask is
>> called at least once.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>
> Is the ack from Peda here forgotten or still missing?
>
> @peda: Once you are happy, do you want to take these patches via your
> shiny new mux-tree or do you prefer if I pick them?
>
G'day Wolfram,

I think he was hoping someone else would have a look at it based on this
feedback.

On 2017-01-04 15:13, Peter Rosin wrote:
> Irqs are not my strong point, I would prefer if someone else also had
> a look. And there are some comments below...

-- 
Regards
Phil Reid
