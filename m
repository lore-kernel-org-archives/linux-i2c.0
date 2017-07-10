From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: Today's linux-next build fail on powerpc
Date: Mon, 10 Jul 2017 20:07:58 +0530
Message-ID: <1499697478.19784.42.camel@abdul.in.ibm.com>
References: <1499320823.19784.17.camel@abdul.in.ibm.com>
         <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753565AbdGJOiL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Jul 2017 10:38:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6AEXeBk065510
        for <linux-i2c@vger.kernel.org>; Mon, 10 Jul 2017 10:38:11 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bma0nchb1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-i2c@vger.kernel.org>; Mon, 10 Jul 2017 10:38:10 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-i2c@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Tue, 11 Jul 2017 00:38:07 +1000
In-Reply-To: <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel <linux-kernel@vger.kernel.org>, Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-next <linux-next@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Fri, 2017-07-07 at 19:36 +0300, Andy Shevchenko wrote:
> On Thu, Jul 6, 2017 at 9:00 AM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > Hi Luis,
> >
> > next-20170705 fails to build on powerpc with below errors.
> 
> Hi,
> 
> I had sent a fix yesterday. Had you chance to test it?
> 
> 

Are these the one you are referring to ?

[v1,2/2] ACPI / boot: Don't define unused variables 
[v1,1/2] ACPI / boot: Correct address space of __acpi_map_table()

Applying above patches did not fix the build failure.

drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit
declaration of function
‘i2c_detect_slave_mode’ [-Werror=implicit-function-declaration]
  if (i2c_detect_slave_mode(&pdev->dev))
      ^
  CC [M]  fs/jffs2/scan.o

Please point me to the correct patch you are referring to ?

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
