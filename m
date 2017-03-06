From: James Maki <jamescmaki@revolayer.com>
Subject: Re: lis3lv02d i2c access on shutdown
Date: Mon, 6 Mar 2017 09:10:52 -0600
Message-ID: <41bff51c-9a4c-3e28-a9ed-eea916f87e9d@revolayer.com>
References: <647cd755-3554-0719-6811-c64ffae0fc1e@revolayer.com>
 <33dcfc02-67ef-ba6e-30a6-e2cd26aa9f71@tremplin-utc.net>
 <20170304223222.GA2386@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from p3nlsmtpcp01-02.prod.phx3.secureserver.net ([184.168.200.140]:60574
        "EHLO p3nlsmtpcp01-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbdCFPWj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Mar 2017 10:22:39 -0500
In-Reply-To: <20170304223222.GA2386@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?Q?=c3=89ric_Piel?= <eric.piel@tremplin-utc.net>
Cc: linux-i2c@vger.kernel.org

I think it is the same issue. How would i2c_transfer_noirq work? In my 
case another task was in the middle of a transaction when it was 
"stopped". This means not only do you need i2c_transfer_noirq, but also 
need to flush the bus before calling kernel_shutdown_prepare().


On 03/04/2017 04:32 PM, Wolfram Sang wrote:
>>> issue with i2c since other drivers have the same design. What I don't
>>> have is clear understanding of if/when/how i2c_transfer() can be called
>>> post kernel_power_off().
> Not sure if it is exactly the same issue, but last year we concluded
> that we probably need an optional i2c_transfer_noirq callback in
> i2c_adapter to talk to PMICs very late or very early. No work has been
> done so far, though. I hope I will find time for it this year.
>
