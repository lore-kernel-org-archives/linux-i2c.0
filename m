From: York Sun <yorksun@freescale.com>
Subject: Re: multiple i2c-ocores adapters
Date: Fri, 2 Oct 2015 12:11:15 -0700
Message-ID: <560ED6D3.40901@freescale.com>
References: <CY1PR03MB1469CBCC35D971A2F26773DBBE4B0@CY1PR03MB1469.namprd03.prod.outlook.com>
 <874mi9x0w7.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0110.outbound.protection.outlook.com ([65.55.169.110]:55712
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750923AbbJBTL0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 2 Oct 2015 15:11:26 -0400
In-Reply-To: <874mi9x0w7.fsf@dell.be.48ers.dk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Peter,

On 10/01/2015 11:03 PM, Peter Korsgaard wrote:
>>>>>> "York" == York Sun <yorksun@freescale.com> writes:
> 
>  > Peter,
> 
>  > I have a platform (FPGA) with multiple ocores i2c adapter. When I
>  > register them using MFD framework, I got a message regarding
>  > duplicating name for sysfs. I wonder if this driver (i2c-ocores.c)
>  > only supports one adapter. I can try to fix it by adding a name string
>  > into ocores_i2c_platform_data and allocate struct i2c_adapter on
>  > demand. Am I on the right direction?
> 
> I guess your problem is that the driver core is complaining about
> duplicate names for your platform devices (generated from the
> mfd_cell). Make sure you set the .id member to something unique.
> 

What I got was

sysfs: cannot create duplicate filename '/bus/platform/devices/ocores-i2c'

I think it is caused by the i2c-ocores driver. Will dig deeper.

York
