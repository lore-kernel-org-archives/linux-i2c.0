From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Mon, 15 Jan 2018 14:53:43 -0500
Message-ID: <20180115195343.GE24317@hmswarspite.think-freely.org>
References: <20170818160128.21228-2-radu.rendec@gmail.com>
 <20180104134606.GB919@hmswarspite.think-freely.org>
 <1515080529.3062.26.camel@gmail.com>
 <20180104162207.GD919@hmswarspite.think-freely.org>
 <1515085276.3062.37.camel@gmail.com>
 <20180105014727.GA18052@neilslaptop.think-freely.org>
 <1516019600.11739.3.camel@gmail.com>
 <20180115185304.GC24317@hmswarspite.think-freely.org>
 <20180115190226.5wuvqfat25e27z4m@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:58500 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeAOTxy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 Jan 2018 14:53:54 -0500
Content-Disposition: inline
In-Reply-To: <20180115190226.5wuvqfat25e27z4m@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Radu Rendec <radu.rendec@gmail.com>, linux-i2c@vger.kernel.org

On Mon, Jan 15, 2018 at 08:02:26PM +0100, Wolfram Sang wrote:
> 
> > > I sent the updated patch with PTR_ALIGN on Jan/4. Have you had a chance
> > > to look at it? Is there anything that can be further improved?
> > > 
> > hmm, I didn't see it, and I can't seem to find it on the i2c list archives here:
> > https://marc.info/?l=linux-i2c&r=1&b=201801&w=2
> > 
> > Can you point it out or resend it please?
> 
> http://patchwork.ozlabs.org/patch/855763/
> 
> You can also download it as mbox from there.
> 

Thanks, No need, its got the changes we agreed on.  

Acked-by: Neil Horman <nhorman@tuxdriver.com>
