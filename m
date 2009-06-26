From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Fri, 26 Jun 2009 10:51:16 +0100
Message-ID: <20090626095116.GD5415@sirena.org.uk>
References: <4A448926.1030701@samsung.com>
 <1246007760.3067.5.camel@hpdv5.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1246007760.3067.5.camel-b91qqBXZ9ZExq86mLogaLw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaswinder Singh Rajput <jaswinder-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 26, 2009 at 02:46:00PM +0530, Jaswinder Singh Rajput wrote:

> I am curious what is the use of include/linux/gp2ap002.h, it only have
> gp2ap002_platform_data structure which you can keep in your source file
> the only file which is using it.

Platform data is data which is passed in from the board-specific code
for the system (which will live under arch) to configure the driver.
