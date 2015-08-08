From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 1/4] rtc: bq32k: move binding docs to proper place
Date: Sat, 8 Aug 2015 23:50:35 +0200
Message-ID: <20150808215035.GB17085@amd>
References: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
 <1439058636-3082-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439058636-3082-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jason Cooper <jason-E2nrXYax+wsBe96aLqz0jA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat 2015-08-08 20:30:33, Wolfram Sang wrote:
> The I2C dir is not for I2C client devices! Move it to the proper folder.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Acked-by: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>

> diff --git a/Documentation/devicetree/bindings/i2c/ti,bq32k.txt b/Documentation/devicetree/bindings/rtc/ti,bq32k.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/i2c/ti,bq32k.txt
> rename to Documentation/devicetree/bindings/rtc/ti,bq32k.txt

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
