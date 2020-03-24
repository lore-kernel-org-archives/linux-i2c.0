From: Ajay Gupta <ajayg@nvidia.com>
Subject: RE: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 03:51:08 +0000
Message-ID: <BYAPR12MB2727F872ED47A1862C8A9CF9DCF10@BYAPR12MB2727.namprd12.prod.outlook.com>
References: <20200311165806.12365-1-kai.heng.feng@canonical.com>
 <DA56E103-CAA7-4C28-9528-9EAFF2C717CD@canonical.com>
 <BYAPR12MB2727B1862E56594E4B6A3E0ADCF00@BYAPR12MB2727.namprd12.prod.outlook.com>
 <E6C41EAE-C56D-4FAB-969F-0842F4FF5C18@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4989 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCXDvN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Mar 2020 23:51:13 -0400
In-Reply-To: <E6C41EAE-C56D-4FAB-969F-0842F4FF5C18@canonical.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Kai-Heng

> -----Original Message-----
> From: linux-i2c-owner@vger.kernel.org <linux-i2c-owner@vger.kernel.org>
> On Behalf Of Kai-Heng Feng
> Sent: Monday, March 23, 2020 10:21 AM
> To: Ajay Gupta <ajayg@nvidia.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; open list:I2C CONTROLLER DRIVER
> FOR NVIDIA GPU <linux-i2c@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
> gpu_i2c_check_status()
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Ajay,
>=20
> > On Mar 24, 2020, at 00:47, Ajay Gupta <ajayg@nvidia.com> wrote:
> >
> > Kai-Heng
> >
> >> -----Original Message-----
> >> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> Sent: Sunday, March 22, 2020 10:38 PM
> >> To: Ajay Gupta <ajayg@nvidia.com>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>; Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com>; open list:I2C CONTROLLER DRIVER
> >> FOR NVIDIA GPU <linux-i2c@vger.kernel.org>; open list <linux-
> >> kernel@vger.kernel.org>
> >> Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
> >> gpu_i2c_check_status()
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >>> On Mar 12, 2020, at 00:58, Kai-Heng Feng
> >>> <kai.heng.feng@canonical.com>
> >> wrote:
> >>>
> >>> Nvidia card may come with a "phantom" UCSI device, and its driver
> >>> gets stuck in probe routine, prevents any system PM operations like
> suspend.
> >>>
> >>> Let's handle the unaccounted case that the target time equals to
> >>> jiffies in gpu_i2c_check_status(), so the UCSI driver can let the
> >>> probe fail as it should.
> > If status is not seen in 999.5 ms then I don't see any reason why it
> > will come exactly at 1000ms. In fact,  we expect status to be seen
> > within 160ms as per I2C_MST_I2C0_TIMING_TIMEOUT_CLK_CNT (16
> cycle) and
> > I2C_MST_I2C0_TIMING_SCL_PERIOD_100KHZ (10ms/cycle) programmed in
> > I2C_MST_I2C0_TIMING Register. We already have enough extra time to
> > look For response.
>=20
> This is to handle when there's no response.
>=20
> When the while loop terminates because of "time_is_after_jiffies(target)"
> (i.e. target <=3D jiffies), we also need to to handle "target =3D=3D jiff=
ies" case in the
> following if clause to properly timeout.
Ok got it. The change looks fine to me.

Acked-by: Ajay Gupta <ajayg@nvidia.com>

Thanks
> nvpublic
>=20
> I don't think I2C timings here can affect jiffies.
>=20
> Kai-Heng
>=20
> >
> > Thanks
> >> nvpublic
> >>>
> >>> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>
> >> A gentle ping...
> >>
> >>> ---
> >>> drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c
> >>> b/drivers/i2c/busses/i2c-nvidia-gpu.c
> >>> index 62e18b4db0ed..1988e93c7925 100644
> >>> --- a/drivers/i2c/busses/i2c-nvidia-gpu.c
> >>> +++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
> >>> @@ -88,7 +88,7 @@ static int gpu_i2c_check_status(struct gpu_i2c_dev
> >> *i2cd)
> >>>              usleep_range(500, 600);
> >>>      } while (time_is_after_jiffies(target));
> >>>
> >>> -     if (time_is_before_jiffies(target)) {
> >>> +     if (time_is_before_eq_jiffies(target)) {
> >>>              dev_err(i2cd->dev, "i2c timeout error %x\n", val);
> >>>              return -ETIMEDOUT;
> >>>      }
> >>> --
> >>> 2.17.1
> >>>
> >
