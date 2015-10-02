From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: multiple i2c-ocores adapters
Date: Fri, 02 Oct 2015 08:03:36 +0200
Message-ID: <874mi9x0w7.fsf@dell.be.48ers.dk>
References: <CY1PR03MB1469CBCC35D971A2F26773DBBE4B0@CY1PR03MB1469.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38393 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbJBGDk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Oct 2015 02:03:40 -0400
Received: by wiclk2 with SMTP id lk2so16983568wic.1
        for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2015 23:03:39 -0700 (PDT)
In-Reply-To: <CY1PR03MB1469CBCC35D971A2F26773DBBE4B0@CY1PR03MB1469.namprd03.prod.outlook.com>
	(York Sun's message of "Fri, 2 Oct 2015 05:47:37 +0000")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

>>>>> "York" == York Sun <yorksun@freescale.com> writes:

 > Peter,

 > I have a platform (FPGA) with multiple ocores i2c adapter. When I
 > register them using MFD framework, I got a message regarding
 > duplicating name for sysfs. I wonder if this driver (i2c-ocores.c)
 > only supports one adapter. I can try to fix it by adding a name string
 > into ocores_i2c_platform_data and allocate struct i2c_adapter on
 > demand. Am I on the right direction?

I guess your problem is that the driver core is complaining about
duplicate names for your platform devices (generated from the
mfd_cell). Make sure you set the .id member to something unique.

-- 
Bye, Peter Korsgaard
