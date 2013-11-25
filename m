From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Compile error in i2c-bcm-kona.c
Date: Sun, 24 Nov 2013 21:11:13 -0800
Message-ID: <5292DBF1.7040709@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Upstream HEAD, arm allmodconfig:

drivers/i2c/busses/i2c-bcm-kona.c:894:1: error: '__mod_of_device_table' aliased to undefined symbol 'kona_i2c_of_match'
make[3]: *** [drivers/i2c/busses/i2c-bcm-kona.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make[1]: *** Waiting for unfinished jobs....

Source:

static const struct of_device_id bcm_kona_i2c_of_match[] = {
         {.compatible = "brcm,kona-i2c",},
         {},
};
MODULE_DEVICE_TABLE(of, kona_i2c_of_match);

Makes me wonder how this was tested :-(.

Guenter
