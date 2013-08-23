From: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] misc: (at24) move header to linux/platform_data/
Date: Fri, 23 Aug 2013 16:45:33 -0400 (EDT)
Message-ID: <169123028.921974.1377290733515.JavaMail.root@mail>
References: <20130823201149.GA5640@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130823201149.GA5640@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram wrote:

> > IMHO it makes sense. Why wouldn't we want all platform_data in
> > include/linux/platform_data/?
> 
> For the same reason we don't want all driver source files in one
> directory? It's a mess.

Well, that's different. Not all drivers expose platform data, but many
subsystems have drivers with platform data. A common include directory
for the *_platform_data structure definitions makes sense.

Regards,
Vivien
