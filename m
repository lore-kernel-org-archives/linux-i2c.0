From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/4] i2c: move client binding docs to proper place
Date: Sat,  8 Aug 2015 20:30:32 +0200
Message-ID: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The I2C binding directory is for master controllers, muxes and alike. Not for
client drivers. Move those who slipped in to their proper places.

I'd like to take these patches via my tree, so it is promptly cleaned up in one
go. So, I am mainly asking for acks here.

Thanks,

   Wolfram

Wolfram Sang (4):
  rtc: bq32k: move binding docs to proper place
  hwmon: max6697: move binding docs to proper place
  hwmon: ina2xx: move binding docs to proper place
  hwmon: ina209: move binding docs to proper place

 Documentation/devicetree/bindings/{i2c => hwmon}/ina209.txt  | 0
 Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt  | 0
 Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt | 0
 Documentation/devicetree/bindings/{i2c => rtc}/ti,bq32k.txt  | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina209.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/ina2xx.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt (100%)
 rename Documentation/devicetree/bindings/{i2c => rtc}/ti,bq32k.txt (100%)

-- 
2.1.4
