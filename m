From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Today's linux-next build fail on powerpc
Date: Mon, 10 Jul 2017 18:17:00 +0300
Message-ID: <CAHp75VdSgpviH9U1nh7HVL-t9kHHQeAdDSnAGjsXtFaXXTNnXQ@mail.gmail.com>
References: <1499320823.19784.17.camel@abdul.in.ibm.com> <CAHp75VdfjatKMWXzHLr7s3CCAh_-Gd=a2K72pFDdtt1X9Kk7Rw@mail.gmail.com>
 <1499697478.19784.42.camel@abdul.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33868 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbdGJPRC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Jul 2017 11:17:02 -0400
In-Reply-To: <1499697478.19784.42.camel@abdul.in.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel <linux-kernel@vger.kernel.org>, Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-next <linux-next@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, Jul 10, 2017 at 5:37 PM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> On Fri, 2017-07-07 at 19:36 +0300, Andy Shevchenko wrote:
>> On Thu, Jul 6, 2017 at 9:00 AM, Abdul Haleem
>> <abdhalee@linux.vnet.ibm.com> wrote:
>> > next-20170705 fails to build on powerpc with below errors.
>> I had sent a fix yesterday. Had you chance to test it?

> drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit
> declaration of function
> =E2=80=98i2c_detect_slave_mode=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>   if (i2c_detect_slave_mode(&pdev->dev))
>       ^
>   CC [M]  fs/jffs2/scan.o
>
> Please point me to the correct patch you are referring to ?

commit 8f1a357d41a22009150cf404b5aa5876efdb59b1

   i2c: Provide a stub for i2c_detect_slave_mode()

--=20
With Best Regards,
Andy Shevchenko
