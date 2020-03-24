From: Ajay Gupta <ajayg@nvidia.com>
Subject: RE: [PATCH v3] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 21:16:49 +0000
Message-ID: <BYAPR12MB27273959932290518B68800ADCF10@BYAPR12MB2727.namprd12.prod.outlook.com>
References: <20200324152812.20231-1-kai.heng.feng@canonical.com>
 <20200324205731.GA7641@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:17068 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgCXVQz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Mar 2020 17:16:55 -0400
In-Reply-To: <20200324205731.GA7641@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa@the-dreams.de>
> Sent: Tuesday, March 24, 2020 1:58 PM
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Ajay Gupta <ajayg@nvidia.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; open list:I2C CONTROLLER DRIVER
> FOR NVIDIA GPU <linux-i2c@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH v3] i2c: nvidia-gpu: Handle timeout correctly in
> gpu_i2c_check_status()
>=20
> On Tue, Mar 24, 2020 at 11:28:11PM +0800, Kai-Heng Feng wrote:
> > Nvidia card may come with a "phantom" UCSI device, and its driver gets
> > stuck in probe routine, prevents any system PM operations like suspend.
> >
> > There's an unaccounted case that the target time can equal to jiffies
> > in gpu_i2c_check_status(), let's solve that by using
> > readl_poll_timeout() instead of jiffies comparison functions.
> >
> > Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>=20
> Looks good to me, thanks Andy for the suggestion!
>=20
> Waiting for the Rev-by from Ajay (driver maintainer).
Reviewed-by: Ajay Gupta <ajayg@nvidia.com>
Tested-by: Ajay Gupta <ajayg@nvidia.com>=20

Thanks
Ajay
> nvpublic
