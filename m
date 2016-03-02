From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 1/2] i2c: xiic: Implement Power management
Date: Wed, 2 Mar 2016 10:57:42 +0530
Message-ID: <CAM=Q2cvx9y2oiSop2-je2P0b5osQOL+t2w8y76WabHa2DTLayQ@mail.gmail.com>
References: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
	<20160301182947.GB1488@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33325 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcCBF1n (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Mar 2016 00:27:43 -0500
In-Reply-To: <20160301182947.GB1488@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Linux-I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Tue, Mar 1, 2016 at 11:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +     ret = clk_prepare_enable(i2c->clk);
>> +     if (ret)
>> +             dev_err(&pdev->dev, "Unable to enable clock.\n");
>
> Don't you want to bail out here? The clk refcounting will be messed up
> if you continue.

Agree missed it will fix it.
>
>> +err_clk_dis:
>> +     clk_disable_unprepare(i2c->clk);
>> +     pm_runtime_set_suspended(&pdev->dev);
>> +     pm_runtime_disable(&pdev->dev);
>> +     return ret;
>
> To match the inverse of the activation order, I'd put the
> clk_disable_unprepare after the pm_* calls. Couldn't it happen that
> those calls need to change the clk state?
>
makes sense will change in the next version
