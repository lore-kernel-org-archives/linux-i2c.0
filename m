From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Why isn't IRQ shared for i2c-ocore
Date: Wed, 6 May 2015 14:41:31 -0700
Message-ID: <554A8A8B.1020703@freescale.com>
References: <55304D8E.8070204@freescale.com> <55312AF7.7070504@freescale.com> <20150420064231.GE3447@x1> <55352839.70905@freescale.com> <20150420181651.GF3447@x1> <5535460B.2060309@freescale.com> <20150421073534.GK3447@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150421073534.GK3447@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Lee,

I have a follow up question regarding interrupt. I see many I2C bus drivers
request interrupt with flag = 0. Why not using IRQF_SHARED?

I understand the performance concern. If there is any other reason, I want to
know about it before I go too far on my driver.

York
