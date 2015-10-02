From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: multiple i2c-ocores adapters
Date: Fri, 02 Oct 2015 22:51:23 +0200
Message-ID: <87zj01dmes.fsf@dell.be.48ers.dk>
References: <CY1PR03MB1469CBCC35D971A2F26773DBBE4B0@CY1PR03MB1469.namprd03.prod.outlook.com>
	<874mi9x0w7.fsf@dell.be.48ers.dk> <560ED6D3.40901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32823 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbJBUv0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Oct 2015 16:51:26 -0400
Received: by wiclk2 with SMTP id lk2so49582475wic.0
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2015 13:51:25 -0700 (PDT)
In-Reply-To: <560ED6D3.40901@freescale.com> (York Sun's message of "Fri, 2 Oct
	2015 12:11:15 -0700")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

>>>>> "York" == York Sun <yorksun@freescale.com> writes:

Hi,

>> I guess your problem is that the driver core is complaining about
 >> duplicate names for your platform devices (generated from the
 >> mfd_cell). Make sure you set the .id member to something unique.

 > What I got was

 > sysfs: cannot create duplicate filename '/bus/platform/devices/ocores-i2c'

 > I think it is caused by the i2c-ocores driver. Will dig deeper.

Like I said, this sounds like you are trying to register multiple
platform devices with the same name (ocores-i2c) and id == -1.

Please make sure you use unique ids when you have more than 1 device
instance on your system.

-- 
Bye, Peter Korsgaard
