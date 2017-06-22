From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state change
 to STATE_DONE
Date: Thu, 22 Jun 2017 12:53:44 +0200
Message-ID: <df9d294c-357f-788a-5213-b229d4c3c5c1@denx.de>
References: <20170616092317.584-1-sr@denx.de>
 <87a858hz71.fsf@dell.be.48ers.dk>
 <7319c512-4301-8a33-5fc3-62486557a883@denx.de>
 <871sqkhxm4.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42978 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753062AbdFVKyA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 06:54:00 -0400
In-Reply-To: <871sqkhxm4.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Peter,

first sorry for the delay.

On 16.06.2017 15:26, Peter Korsgaard wrote:
>>>>>> "Stefan" == Stefan Roese <sr@denx.de> writes:
> 
> Hi,
> 
>   >> It is close to 10 years ago since I last had access to any boards with
>   >> the ocores controller, but the logic in ocores_process() indicates that
>   >> the controller would generate another interrupt once the stop condition
>   >> has been sent:
>   >>
>   >> if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
>   >> /* stop has been sent */
>   >> oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
>   >> wake_up(&i2c->wait);
>   >> return;
>   >> }
>   >>
>   >> Do you not see this interrupt?
> 
>   > No. It took me quite some time last week, to notice this misbehavior
>   > in this I2C driver. As the client (Goodix I2C touchscreen) always
>   > returned only after more than 1 second from reading one I2C frame.
> 
> Funky. On what kind of platform / what VHDL source version is this?

Thanks for looking into this. It seems that we had a quite old
version of the OpenCores I2C core implemented on our Altera /
Intel Arria V board:

Rev 1.2 (2001/11/10)

> The
> driver has now existed for more than 10 years and has had contributions
> from a number of people, but this is the first time I hear about this
> missing interrupt.

After updating to the latest version from OpenCores, the issue
with the missing interrupt seems to be resolved. So this patch
can be dropped.

Thanks,
Stefan
