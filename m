From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at91: i2c-at91: improve time-out handling
Date: Mon, 26 Jan 2015 12:19:23 -0500
Message-ID: <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw@mail.gmail.com>
References: <54A58BA5.3080003@interlog.com> <20150107103113.GA30897@ldesroches-Latitude-E6320>
 <20150113152752.GK7660@katana> <54C41FD0.2010607@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C41FD0.2010607-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, patchwork-notifications-2CcfMPLixEJ8D7ILJbWmE2D2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

You can check if ret == -ETIMEDOUT in the error path instead of
allocating another variable.

You also generated the patch with your /arch/arm/boot/dts/Makefile changes.
