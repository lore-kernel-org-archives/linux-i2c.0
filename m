From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: i2c_new_{secondary_device,dummy,device}() return type.
Date: Fri, 9 Feb 2018 18:59:40 +0100
Message-ID: <19f18d1d-efba-a6ca-32f4-0b55f284f27e@gmail.com>
References: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:50455 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeBIR7t (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Feb 2018 12:59:49 -0500
In-Reply-To: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Am 09.02.2018 um 11:01 schrieb Kieran Bingham:
> Hi Wolfram,
> 
> As part of my work looking at using i2c_new_secondary_device() to move address
> mappings into the device tree, it has become evident that the return code of the
> i2c_new_secondary_device() is obfuscated, and is simply a valid client - or NULL.
> 
> This means that we must 'guess' as to whether the device failed due to a memory
> allocation, or if the device address was already in use (perhaps a more common
> failure).
> 
> Because of this - I would like to see the return codes of
> i2c_new_secondary_device(), ic2_new_dummy(), and therefore i2c_new_device()
> support returning ERR_PTR()s rather than a client or NULL.
> 
> These functions are used fairly extensively - thus it will be a fair bit of work
> (or a good coccinelle script) - So I'd like to ask your opinion on the validity
> of this task before I commence anything down that rabbit hole!
> 
> Any comments? Pre-ack/nack? (from anyone?)
> 

This has been addressed as part of adding a devm_i2c_new_dummy().
Related patches are in status "under review" since end of December.
See also here:
https://marc.info/?l=linux-i2c&m=151375074832371&w=2
https://patchwork.ozlabs.org/patch/851268/

Maybe these patches cover already what you need.

Rgds, Heiner

> --
> Regards
> 
> Kieran Bingham
> .
> 
