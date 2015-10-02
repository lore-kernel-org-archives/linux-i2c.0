From: York Sun <yorksun@freescale.com>
Subject: multiple i2c-ocores adapters
Date: Fri, 2 Oct 2015 05:47:37 +0000
Message-ID: <CY1PR03MB1469CBCC35D971A2F26773DBBE4B0@CY1PR03MB1469.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0114.outbound.protection.outlook.com ([157.56.110.114]:1953
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbbJBFrk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Oct 2015 01:47:40 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


Peter,

I have a platform (FPGA) with multiple ocores i2c adapter. When I register them using MFD framework, I got a message regarding duplicating name for sysfs. I wonder if this driver (i2c-ocores.c) only supports one adapter. I can try to fix it by adding a name string into ocores_i2c_platform_data and allocate struct i2c_adapter on demand. Am I on the right direction?

York
