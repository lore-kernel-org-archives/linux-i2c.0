From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH] misc: (at24) move header to linux/platform_data/
Date: Fri, 23 Aug 2013 15:40:18 -0400 (EDT)
Message-ID: <276016030.909379.1377286818459.JavaMail.root@mail>
References: <1377285996.620418788@f48.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377285996.620418788@f48.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Wolfram Sang <wsa@the-dreams.de>, kernel@savoirfairelinux.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Alexander wrote:
> Can this file be additionally renamed to misc-at24.h to reflect
> belongs to a particular subsystem?

I'm not sure about that. Having the subsystem name at the beginning of
the file doesn't seem to be a convention for all subsystems. For
instance, this is true for gpio, spi or leds, but not for hwmon.
Actually, I would stick with the corresponding subsystem naming, here:
at24.c -> at24.h.

Regards,
Vivien
