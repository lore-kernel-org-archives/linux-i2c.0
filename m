From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/6] gpu: convert to use new I2C API
Date: Sat, 28 Mar 2020 22:49:37 +0100
Message-ID: <20200328214937.GA9505@ravnborg.org>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:51214 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1Vtl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 28 Mar 2020 17:49:41 -0400
Content-Disposition: inline
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:09:58PM +0100, Wolfram Sang wrote:
> We are deprecating calls which return NULL in favor of new variants which
> return an ERR_PTR. Only build tested.
> 
> 
> Wolfram Sang (6):
>   drm/amdgpu: convert to use i2c_new_client_device()
>   drm/gma500: convert to use i2c_new_client_device()
>   drm/i2c/sil164: convert to use i2c_new_client_device()
>   drm/i2c/tda998x: convert to use i2c_new_client_device()
>   drm/nouveau/therm: convert to use i2c_new_client_device()
>   drm/radeon: convert to use i2c_new_client_device()

With the ack from Alex I went ahead and applied the patches to
drm-misc-next.

	Sam


> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        | 2 +-
>  drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c     | 8 ++++----
>  drivers/gpu/drm/i2c/sil164_drv.c               | 7 +++++--
>  drivers/gpu/drm/i2c/tda998x_drv.c              | 6 +++---
>  drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_atombios.c       | 4 ++--
>  drivers/gpu/drm/radeon/radeon_combios.c        | 4 ++--
>  7 files changed, 19 insertions(+), 16 deletions(-)
> 
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
