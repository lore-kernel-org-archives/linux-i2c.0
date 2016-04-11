From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V2 1/2] i2c: core: add devm apis for i2c_new_dummy and
 i2c_unregister
Date: Mon, 11 Apr 2016 21:34:29 +0530
Message-ID: <570BCB0D.2090004@nvidia.com>
References: <1456753023-20559-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1456753023-20559-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: wsa@the-dreams.de, corbet@lwn.net
Cc: bjorn.andersson@sonymobile.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Monday 29 February 2016 07:07 PM, Laxman Dewangan wrote:
> Add resource managed version of i2c_new_dummy() and
> i2c_unregister_device().
>
> This helps in reducing the code size in error path and device
> remove callbacks and making proper sequence for deallocations.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>
> ---
> Changes from V1:
> - Got review comment on similar change for pinctrl and taken care of
>    the same on this patch as V1 has similar issue.
> - Add the new devm_ APIs in the Documentation/driver-model/devres.txt
> - Will push the change for using this new APIs later once this is
>    applied as most of consumer for these APIs are in other subsystem like
>    MFD/RTC.
>
Can you please review?

If required, I can resend the patch.

Thanks,
Laxman
