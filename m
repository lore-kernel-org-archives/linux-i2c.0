Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C1C77B78
	for <linux-i2c@archiver.kernel.org>; Thu, 20 Apr 2023 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjDTKda (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 20 Apr 2023 06:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjDTKc4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 20 Apr 2023 06:32:56 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9B768F;
        Thu, 20 Apr 2023 03:30:18 -0700 (PDT)
X-QQ-mid: Yeas50t1681986556t830t04060
Received: from 7082A6556EBF4E69829842272A565F7C (jiawenwu@trustnetic.com [183.129.236.74])
X-QQ-SSF: 00400000000000F0FM9000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15567851786989932088
To:     "'Andrew Lunn'" <andrew@lunn.ch>
Cc:     <netdev@vger.kernel.org>, <linux@armlinux.org.uk>,
        <linux-i2c@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <olteanv@gmail.com>, <mengyuanlou@net-swift.com>,
        "'Jarkko Nikula'" <jarkko.nikula@linux.intel.com>
References: <20230419082739.295180-1-jiawenwu@trustnetic.com> <20230419082739.295180-3-jiawenwu@trustnetic.com> <ec095b8a-00af-4fb7-be11-f643ea75e924@lunn.ch>
In-Reply-To: <ec095b8a-00af-4fb7-be11-f643ea75e924@lunn.ch>
Subject: RE: [PATCH net-next v3 2/8] i2c: designware: Add driver support for Wangxun 10Gb NIC
Date:   Thu, 20 Apr 2023 18:29:11 +0800
Message-ID: <03ef01d97372$f2ee26a0$d8ca73e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQILBR3gZkFBC9g1wrfKT5ke1rRywwLGjwA7ApvXcEmupcagcA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvr:qybglogicsvr5
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thursday, April 20, 2023 4:58 AM, Andrew Lunn wrote:
> On Wed, Apr 19, 2023 at 04:27:33PM +0800, Jiawen Wu wrote:
> > Wangxun 10Gb ethernet chip is connected to Designware I2C, to communicate
> > with SFP.
> >
> > Add platform data to pass IOMEM base address, board flag and other
> > parameters, since resource address was mapped on ethernet driver.
> >
> > The exists IP limitations are dealt as workarounds:
> > - IP does not support interrupt mode, it works on polling mode.
> > - I2C cannot read continuously, only one byte can at a time.
> 
> Are you really sure about that?
> 
> It is a major limitation for SFP devices. It means you cannot access
> the diagnostics, since you need to perform an atomic 2 byte read.
> 
> Or maybe i'm understanding you wrong.
> 
>    Andrew
> 

Maybe I'm a little confused about this. Every time I read a byte info, I have to
write a 'read command'. It can normally get the information for SFP devices.
But I'm not sure if this is regular I2C behavior.

