From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 6/6] drm/radeon: convert to use i2c_new_client_device()
Date: Fri, 27 Mar 2020 10:25:16 -0400
Message-ID: <CADnq5_P07b-A-VawLTgiTMSdifxMbWS5kgQV_+0Bw2x_DQHATQ@mail.gmail.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com> <20200326211005.13301-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211005.13301-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 5:35 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Move away from the deprecated API.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

patches 1,6, are:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_combios.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
> index 848ef68d9086..5d2591725189 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -2111,7 +2111,7 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
>                                                                     ucOverdriveThermalController];
>                         info.addr = power_info->info.ucOverdriveControllerAddress >> 1;
>                         strlcpy(info.type, name, sizeof(info.type));
> -                       i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
> +                       i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
>                 }
>         }
>         num_modes = power_info->info.ucNumOfPowerModeEntries;
> @@ -2351,7 +2351,7 @@ static void radeon_atombios_add_pplib_thermal_controller(struct radeon_device *r
>                                 const char *name = pp_lib_thermal_controller_names[controller->ucType];
>                                 info.addr = controller->ucI2cAddress >> 1;
>                                 strlcpy(info.type, name, sizeof(info.type));
> -                               i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
> +                               i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
>                         }
>                 } else {
>                         DRM_INFO("Unknown thermal controller type %d at 0x%02x %s fan control\n",
> diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
> index c3e49c973812..d3c04df7e75d 100644
> --- a/drivers/gpu/drm/radeon/radeon_combios.c
> +++ b/drivers/gpu/drm/radeon/radeon_combios.c
> @@ -2704,7 +2704,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
>                                 const char *name = thermal_controller_names[thermal_controller];
>                                 info.addr = i2c_addr >> 1;
>                                 strlcpy(info.type, name, sizeof(info.type));
> -                               i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
> +                               i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
>                         }
>                 }
>         } else {
> @@ -2721,7 +2721,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
>                                 const char *name = "f75375";
>                                 info.addr = 0x28;
>                                 strlcpy(info.type, name, sizeof(info.type));
> -                               i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
> +                               i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
>                                 DRM_INFO("Possible %s thermal controller at 0x%02x\n",
>                                          name, info.addr);
>                         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
